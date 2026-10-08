import 'package:equatable/equatable.dart';

import 'package:datadadtesms/features/sms/domain/entities/sms_processing_status.dart';
import 'package:datadadtesms/features/sms/domain/entities/sms_source.dart';

/// A received SMS message stored locally — sms domain entity.
///
/// Contract locked in Phase 02:
///
/// LIFECYCLE — created by ReceiveSmsUseCase (Phase 06) via the
/// [SmsMessage.received] factory with status `received`; the
/// processing pipeline then fills [normalizedBody] / [processedAt]
/// and advances [processingStatus]. Transition RULES live in the
/// UseCases — the entity is a dumb value object.
///
/// HASH CONTRACT (dedup + security):
///  - [bodyHash] = SHA-256 hex over `body.trim()` — RAW body, NOT the
///    normalized text. Computed once at receive time (HashUtils,
///    Phase 04) so the hash is independent of normalizer versions:
///    upgrading MessageNormalizer (Phase 07) never re-keys existing
///    dedup data.
///  - Sender is deliberately NOT part of the hash: the same physical
///    message captured via [SmsSource.broadcast] AND
///    [SmsSource.inbox] backfill produces the same hash and
///    deduplicates (Phase 08). The dedup ENGINE may still combine
///    hash with bank/amount/reference when deciding whether two
///    same-hash messages are truly one transaction.
///
/// SECURITY POLICY for the sensitive [body]:
///  - NEVER written to technical logs — logs/audits reference
///    [bodyHash] instead (Phase 04/15 rule: "Raw SMS در Log عادی
///    ذخیره نشود").
///  - NEVER sent to the API — the transaction payload carries
///    `source_sms_hash` only (Phase 09 contract).
///  - Displayed ONLY in the policy-controlled SMS detail view; the
///    list screens show sender / time / status / short hash.
///  - Raw body IS stored in the local DB on purpose: offline-first
///    re-parsing after parser-rule updates requires the original
///    text (failed messages get reprocessed with new rules).
///
/// Pure domain: no Flutter, no Supabase, no serialization here —
/// wire mapping lives in `SmsMessageModel` (data layer, Phase 03+).
class SmsMessage extends Equatable {
  const SmsMessage({
    required this.id,
    required this.deviceId,
    required this.sender,
    required this.body,
    required this.bodyHash,
    required this.receivedAt,
    required this.processingStatus,
    required this.source,
    required this.createdAt,
    this.normalizedBody,
    this.processedAt,
  });

  /// Creates a message in its INITIAL pipeline state — the only
  /// sanctioned way to enter the system (ReceiveSmsUseCase).
  ///
  /// Enforces the initial-state contract: status `received`,
  /// no [normalizedBody], no [processedAt]. All three are produced
  /// later by the processing pipeline.
  factory SmsMessage.received({
    required String id,
    required String deviceId,
    required String sender,
    required String body,
    required String bodyHash,
    required DateTime receivedAt,
    required SmsSource source,
    required DateTime createdAt,
  }) {
    return SmsMessage(
      id: id,
      deviceId: deviceId,
      sender: sender,
      body: body,
      bodyHash: bodyHash,
      receivedAt: receivedAt,
      processingStatus: SmsProcessingStatus.received,
      source: source,
      createdAt: createdAt,
      normalizedBody: null,
      processedAt: null,
    );
  }

  /// Local unique identifier (UUID v4) — generated at receive time,
  /// stable for the message's whole local lifetime and used as the
  /// `sms_id` foreign key on the transaction.
  final String id;

  /// Device that captured this message — the `device_id` carried
  /// through transactions and API payloads.
  final String deviceId;

  /// Sender address EXACTLY as delivered by the native layer
  /// (e.g. '+98300011', '5004'). Canonicalization for bank detection
  /// happens in BankDetector (Phase 07) — the entity preserves the
  /// original for auditing and re-detection after config changes.
  final String sender;

  /// Raw message text — SENSITIVE. See the security policy in the
  /// class doc comment before exposing it anywhere.
  final String body;

  /// SHA-256 hex of `body.trim()` — dedup key + safe log/audit
  /// reference. See the hash contract in the class doc comment.
  final String bodyHash;

  /// Device-reported receipt time (UTC).
  final DateTime receivedAt;

  /// Current lifecycle state — see [SmsProcessingStatus].
  final SmsProcessingStatus processingStatus;

  /// How the message entered the system — see [SmsSource].
  final SmsSource source;

  /// When the local row was created (UTC).
  final DateTime createdAt;

  /// Normalized text produced by MessageNormalizer (Phase 07) during
  /// processing — the parse input. Nullable until the pipeline runs;
  /// persisted so re-parsing skips re-normalization drift.
  final String? normalizedBody;

  /// When the message reached a TERMINAL status (UTC). Nullable until
  /// then. Feeds the audit timeline on the SMS/transaction screens.
  final DateTime? processedAt;

  /// Whether the message is still awaiting or undergoing processing —
  /// used by crash recovery (re-queue stuck `processing` messages)
  /// and the SMS list's "pending" filter.
  bool get isPending =>
      processingStatus == SmsProcessingStatus.received ||
      processingStatus == SmsProcessingStatus.processing;

  /// Returns a copy with the provided fields replaced.
  ///
  /// NOTE: `null` arguments KEEP the current value — this entity never
  /// needs to reset [normalizedBody]/[processedAt] back to null, so
  /// standard copyWith semantics are sufficient.
  SmsMessage copyWith({
    String? id,
    String? deviceId,
    String? sender,
    String? body,
    String? bodyHash,
    DateTime? receivedAt,
    SmsProcessingStatus? processingStatus,
    SmsSource? source,
    DateTime? createdAt,
    String? normalizedBody,
    DateTime? processedAt,
  }) {
    return SmsMessage(
      id: id ?? this.id,
      deviceId: deviceId ?? this.deviceId,
      sender: sender ?? this.sender,
      body: body ?? this.body,
      bodyHash: bodyHash ?? this.bodyHash,
      receivedAt: receivedAt ?? this.receivedAt,
      processingStatus: processingStatus ?? this.processingStatus,
      source: source ?? this.source,
      createdAt: createdAt ?? this.createdAt,
      normalizedBody: normalizedBody ?? this.normalizedBody,
      processedAt: processedAt ?? this.processedAt,
    );
  }

  @override
  List<Object?> get props => <Object?>[
        id,
        deviceId,
        sender,
        body,
        bodyHash,
        receivedAt,
        processingStatus,
        source,
        createdAt,
        normalizedBody,
        processedAt,
      ];
}