import 'package:datadadtesms/core/constants/app_constants.dart';
import 'package:datadadtesms/features/sms/domain/entities/sms_message.dart';
import 'package:datadadtesms/features/sms/domain/entities/sms_processing_status.dart';

/// Raw event crossing the NATIVE boundary — what the Android receiver
/// delivers, BEFORE any domain logic runs.
///
/// A record typedef (not an entity file): the sanctioned birth of a
/// [SmsMessage] is ReceiveSmsUseCase (MD 06.3: native payload →
/// entity → hash → local save) — so the repository surface carries
/// the RAW shape and the USECASE builds the entity (id, hash,
/// initial status) through the SmsMessage.received factory.
typedef IncomingSmsPayload = ({
  String sender,
  String body,
  DateTime receivedAt,
});

/// Persistence + reader contract of the SMS feature — sms domain
/// repository (abstract interface; the impl wrapping
/// `sms_local_datasource` + `sms_native_datasource` lands in Phase 06
/// as `sms_repository_impl.dart`, per the project tree).
///
/// ONE SURFACE, TWO DATASOURCES (MD 06.2: "NativeDataSource و
/// LocalDataSource را پشت Repository abstraction قرار بده"):
///  - READER LIFECYCLE + the incoming stream — backed by the native
///    bridge (Phase 05: startReader/stopReader/onSmsReceived). No
///    native type ever crosses this boundary — the datasource maps
///    bridge payloads to [IncomingSmsPayload].
///  - LOCAL PERSISTENCE — backed by Drift (sms_messages table).
///
/// ERROR CONTRACT (same lock as BankRepository): implementations
/// THROW typed exceptions (SmsException/DatabaseException family,
/// Phase 04) — signatures are FINAL and carry no Result/Failure;
/// usecases wrap them for providers.
///
/// Pure domain: no Drift, no method-channel, no Pigeon types.
abstract interface class SmsRepository {
  // -------------------------------------------------------------------------
  // Reader lifecycle (native bridge — Phase 05)
  // -------------------------------------------------------------------------

  /// Starts listening for incoming SMS. Throws the typed permission
  /// exception (Phase 04) when SMS permission is missing — permission
  /// CHECKING itself belongs to the permissions feature; this only
  /// surfaces the native refusal.
  Future<void> startReader();

  /// Stops listening. Idempotent — stopping a stopped reader is a
  /// no-op, never an error.
  Future<void> stopReader();

  /// Whether the native reader is currently listening. The SMS status
  /// CARD (Phase 12) composes this with permission state (from the
  /// permissions feature) — composition happens above, at usecase/
  /// provider level.
  Future<bool> get isReaderRunning;

  /// Broadcast stream of RAW incoming messages — live while the
  /// reader runs. ReceiveSmsUseCase (Phase 06) is its single
  /// logical consumer: it builds entities, checks hash duplicates,
  /// saves, and emits the receive audit event.
  Stream<IncomingSmsPayload> get incomingMessages;

  // -------------------------------------------------------------------------
  // Local persistence (sms_messages table)
  // -------------------------------------------------------------------------

  /// INSERT-only (the receive path). A message id collision is a
  /// wiring bug and throws — updates go through [updateMessage].
  Future<void> saveMessage(SmsMessage message);

  /// One message by id — null when absent (detail view / reprocess
  /// flow).
  Future<SmsMessage?> getMessage(String id);

  /// Paged history, NEWEST FIRST (receivedAt DESC) — the SMS screen.
  /// [page] is 0-based; [pageSize] clamps to the app max. Optional
  /// [status] filter (e.g. the "pending" filter).
  Future<List<SmsMessage>> getHistory({
    int page = 0,
    int pageSize = AppConstants.defaultPageSize,
    SmsProcessingStatus? status,
  });

  /// ALL messages carrying this bodyHash — the ingestion-level dedup
  /// CHECK (ReceiveSmsUseCase). Returns a LIST on purpose: the hash
  /// index is deliberately NON-unique (broadcast + inbox backfill of
  /// the same physical message = two legitimate rows; the Phase 03
  /// sms_messages contract).
  Future<List<SmsMessage>> findByHash(String bodyHash);

  /// ALL messages in a given status — UNPAGED by design. Consumers:
  /// crash recovery (stuck `processing` re-queue, Phase 06) and
  /// re-parse batches of `failed` messages after parser-rule updates.
  /// Bounded only by retention reality, not by page windows.
  Future<List<SmsMessage>> findByStatus(SmsProcessingStatus status);

  /// Whole-entity UPDATE (the processing pipeline): status
  /// transitions, normalizedBody, processedAt — the entity stays the
  /// single source of truth; there is no field-partial update API.
  Future<void> updateMessage(SmsMessage message);
}