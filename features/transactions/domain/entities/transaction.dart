import 'package:equatable/equatable.dart';

import 'package:datadadtesms/features/transactions/domain/entities/currency.dart';
import 'package:datadadtesms/features/transactions/domain/entities/transaction_status.dart';
import 'package:datadadtesms/features/transactions/domain/entities/transaction_type.dart';

/// THE financial record — transactions domain entity.
///
/// Contract locked in Phase 02:
///
/// WHAT IT IS: the single source of local truth for ONE bank
/// transaction event. Created EXCLUSIVELY by TransactionMapper
/// (Phase 08) — only after ValidationEngine AND DeduplicationEngine
/// passed. Failed parses and duplicates never produce a Transaction
/// (the SmsMessage carries `failed`/`duplicate` instead) — hence
/// this entity is, by construction, "money that actually happened".
///
/// SELF-CONTAINED RECORD: the row carries everything its consumers
/// need WITHOUT joins — lists, the API payload (Phase 09), and the
/// sync queue build from this record alone. Snapshot semantics:
/// [bankName] and [parserVersion] are captured AT CREATION; the
/// record is historical evidence, so later admin config changes
/// (renaming a bank, upgrading parser rules) do NOT rewrite existing
/// records — that's the audit-friendly behavior, by design.
///
/// THREE-WAY SEPARATION (locked in TransactionStatus): this entity
/// carries NO sync state and NO match state. Transmission lives in
/// sync_queue (sync feature), matching outcome in matching_records
/// (matching feature). The transaction detail screen composes all
/// three independently — a record can be `confirmed` standing while
/// a retry is in flight and while matching is still pending.
///
/// DEDUP KEY: [dedupKey] is the canonical duplicate-prevention key,
/// computed by DeduplicationEngine (Phase 08) from a deterministic
/// documented combination of bank + source hash + amount + timestamp
/// + reference/trace (with canonical null handling — the exact
/// canonicalization is locked by the engine's unit tests in Phase
/// 08). It is PERSISTED here so Phase 03 can put a UNIQUE index on
/// the column: the engine check is the first line of defense, the
/// storage constraint is the last — double financial records are
/// structurally impossible, not just unlikely.
///
/// SERVER LINEAGE: [serverTransactionId] is set ONCE by SyncEngine
/// (Phase 10) when the backend accepts the record (API
/// `server_transaction_id`, status `accepted`) and is immutable
/// after — copyWith's null-keeps-current semantics enforce the
/// set-once contract structurally.
///
/// STATUS TRANSITIONS are owned by UseCases (08/10/11) — the state
/// machine itself is documented on [TransactionStatus]. This entity
/// is a dumb value object; it never decides.
///
/// SECURITY: [cardNumberMasked] is masked at the extraction boundary
/// (see ParsedTransaction) — a full PAN never exists past the parser
/// layer, so it cannot appear here, in storage, logs, or the wire.
///
/// Pure domain: no Flutter, no Supabase, no serialization here —
/// wire mapping lives in `TransactionModel` (data layer, Phase 03+).
class Transaction extends Equatable {
  const Transaction({
    required this.id,
    required this.smsId,
    required this.deviceId,
    required this.bankId,
    required this.bankCode,
    required this.bankName,
    required this.type,
    required this.amount,
    required this.currency,
    required this.timestamp,
    required this.confidenceScore,
    required this.status,
    required this.dedupKey,
    required this.sourceSmsHash,
    required this.parserVersion,
    required this.createdAt,
    required this.updatedAt,
    this.cardNumberMasked,
    this.accountNumber,
    this.referenceNumber,
    this.traceNumber,
    this.balance,
    this.serverTransactionId,
  });

  /// Creates a record in its INITIAL state — the only sanctioned
  /// way a Transaction comes into existence (TransactionMapper,
  /// Phase 08).
  ///
  /// Enforces the creation invariant: status `pending`, no
  /// [serverTransactionId], and `updatedAt == createdAt` (a fresh
  /// record has no history of changes yet).
  factory Transaction.created({
    required String id,
    required String smsId,
    required String deviceId,
    required String bankId,
    required String bankCode,
    required String bankName,
    required TransactionType type,
    required int amount,
    required Currency currency,
    required DateTime timestamp,
    required double confidenceScore,
    required String dedupKey,
    required String sourceSmsHash,
    required String parserVersion,
    required DateTime createdAt,
    String? cardNumberMasked,
    String? accountNumber,
    String? referenceNumber,
    String? traceNumber,
    int? balance,
  }) {
    return Transaction(
      id: id,
      smsId: smsId,
      deviceId: deviceId,
      bankId: bankId,
      bankCode: bankCode,
      bankName: bankName,
      type: type,
      amount: amount,
      currency: currency,
      timestamp: timestamp,
      confidenceScore: confidenceScore,
      status: TransactionStatus.pending,
      dedupKey: dedupKey,
      sourceSmsHash: sourceSmsHash,
      parserVersion: parserVersion,
      createdAt: createdAt,
      updatedAt: createdAt,
      cardNumberMasked: cardNumberMasked,
      accountNumber: accountNumber,
      referenceNumber: referenceNumber,
      traceNumber: traceNumber,
      balance: balance,
      serverTransactionId: null,
    );
  }

  /// Local unique identifier (UUID v4) — generated at creation; also
  /// the `Idempotency-Key` of the API send (Phase 09): a retried
  /// send of THIS record can never create a second server record.
  final String id;

  /// The SMS this record was parsed from — [SmsMessage.id]. The
  /// `sms_id` soft reference; one SMS produces at most one record.
  final String smsId;

  /// Device that captured the source SMS — same value as the
  /// SmsMessage's deviceId at creation. Carried directly so the
  /// API payload (`device_id`) and audit lineage need no join.
  final String deviceId;

  /// Soft reference to the bank row — [Bank.id]. For local relations
  /// (joins to bank config).
  final String bankId;

  /// Stable wire code — [Bank.code]. Resilience identity: survives
  /// bank-row re-syncs and powers the API `bank_code` payload even
  /// if the bank config row is later disabled.
  final String bankCode;

  /// Display name SNAPSHOT at creation — [Bank.name]. Lists render
  /// without a join; historical records keep the name that was true
  /// when they were created (config data, not l10n).
  final String bankName;

  /// Financial movement type — [TransactionType]. Sign of the amount
  /// is implied by this, never stored separately.
  final TransactionType type;

  /// Amount in the smallest unit of [currency] (rials for IRR).
  /// Non-negative integer; sign implied by [type].
  final int amount;

  /// Monetary unit — [Currency].
  final Currency currency;

  /// Transaction time (from the message body, or receive-time
  /// fallback — see ParsedTransaction). UTC.
  final DateTime timestamp;

  /// Already-masked card — `'6037********1234'` or null when the
  /// message had no card. Masked at the extraction boundary; a full
  /// PAN never exists past the parser layer.
  final String? cardNumberMasked;

  /// Account number, verbatim as extracted. Null when absent.
  final String? accountNumber;

  /// Bank reference — opaque string, verbatim (leading zeros kept).
  /// Null when absent.
  final String? referenceNumber;

  /// Bank trace/track number — opaque string, verbatim. Null when
  /// absent.
  final String? traceNumber;

  /// Post-transaction balance, smallest unit of [currency]. Null
  /// when the SMS format carries no balance.
  final int? balance;

  /// Deterministic parse score `0.0..1.0` — the number that flowed
  /// from ParsedTransaction and is sent as `"confidence"` in the
  /// API payload.
  final double confidenceScore;

  /// Record standing — see [TransactionStatus]. Transitions owned
  /// by UseCases (08/10/11); created as `pending`, never with an
  /// error value.
  final TransactionStatus status;

  /// Canonical duplicate-prevention key — computed by
  /// DeduplicationEngine (Phase 08), persisted for the storage-level
  /// UNIQUE enforcement. See the dedup contract in the class doc
  /// comment.
  final String dedupKey;

  /// SHA-256 hex of the source SMS — [SmsMessage.bodyHash]. The
  /// `source_sms_hash` lineage; raw body never travels.
  final String sourceSmsHash;

  /// Parser version SNAPSHOT at creation — which rule set produced
  /// this financial record. The parser-config audit chain.
  final String parserVersion;

  /// Backend identifier of the accepted record — set ONCE by
  /// SyncEngine (Phase 10) on backend acceptance; immutable after.
  /// Null until then.
  final String? serverTransactionId;

  /// When the record was created (UTC).
  final DateTime createdAt;

  /// When the record was last mutated (UTC) — any status/lineage
  /// change refreshes this.
  final DateTime updatedAt;

  /// Returns a copy with the provided fields replaced.
  ///
  /// NOTE: `null` arguments KEEP the current value — this entity
  /// never needs to clear an extracted field or the set-once
  /// [serverTransactionId], so standard copyWith semantics are
  /// sufficient.
  Transaction copyWith({
    String? id,
    String? smsId,
    String? deviceId,
    String? bankId,
    String? bankCode,
    String? bankName,
    TransactionType? type,
    int? amount,
    Currency? currency,
    DateTime? timestamp,
    String? cardNumberMasked,
    String? accountNumber,
    String? referenceNumber,
    String? traceNumber,
    int? balance,
    double? confidenceScore,
    TransactionStatus? status,
    String? dedupKey,
    String? sourceSmsHash,
    String? parserVersion,
    String? serverTransactionId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Transaction(
      id: id ?? this.id,
      smsId: smsId ?? this.smsId,
      deviceId: deviceId ?? this.deviceId,
      bankId: bankId ?? this.bankId,
      bankCode: bankCode ?? this.bankCode,
      bankName: bankName ?? this.bankName,
      type: type ?? this.type,
      amount: amount ?? this.amount,
      currency: currency ?? this.currency,
      timestamp: timestamp ?? this.timestamp,
      cardNumberMasked: cardNumberMasked ?? this.cardNumberMasked,
      accountNumber: accountNumber ?? this.accountNumber,
      referenceNumber: referenceNumber ?? this.referenceNumber,
      traceNumber: traceNumber ?? this.traceNumber,
      balance: balance ?? this.balance,
      confidenceScore: confidenceScore ?? this.confidenceScore,
      status: status ?? this.status,
      dedupKey: dedupKey ?? this.dedupKey,
      sourceSmsHash: sourceSmsHash ?? this.sourceSmsHash,
      parserVersion: parserVersion ?? this.parserVersion,
      serverTransactionId: serverTransactionId ?? this.serverTransactionId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => <Object?>[
        id,
        smsId,
        deviceId,
        bankId,
        bankCode,
        bankName,
        type,
        amount,
        currency,
        timestamp,
        cardNumberMasked,
        accountNumber,
        referenceNumber,
        traceNumber,
        balance,
        confidenceScore,
        status,
        dedupKey,
        sourceSmsHash,
        parserVersion,
        serverTransactionId,
        createdAt,
        updatedAt,
      ];
}