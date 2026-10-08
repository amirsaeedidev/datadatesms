import 'package:equatable/equatable.dart';

/// WIRE CONTRACT SUITE of the backend API — core network DTOs.
///
/// Phase 02 CONTRACT FREEZE (Step 02.8), final file of the phase:
/// this single tree file hosts ALL five DTOs the roadmap mandates
/// (SendTransactionRequest / SendTransactionResponse /
/// SyncTransactionRequest / SyncTransactionResponse /
/// ApiErrorResponse) — the project tree allocates exactly ONE
/// contract-shaped file under core/network, so the whole suite
/// lives here, sectioned below.
///
/// RULES locked in this file:
///  - PRIMITIVES ONLY: no domain-entity/enum imports — core must
///    never depend on features. Enum↔wire conversion
///    (TransactionType/Currency/TransactionStatus ↔ their wire
///    strings) is implemented by the Phase 09 marshaling layer.
///  - NO TRANSPORT, NO MARSHALING HERE: Phase 02 freezes the SHAPES
///    (fields + documented sample JSON). (De)serialization and HTTP
///    behavior are Phase 09's; the sample JSON in each doc comment
///    IS the frozen contract.
///  - VERSIONING: the transaction wire body is contract v1. Adding
///    fields later = v2 while v1 readers keep working; existing
///    field names/wire names NEVER change.
///  - IDEMPOTENCY: send path keys on transaction_id; sync-envelope
///    path keys on the queue entry id. Retries replay identical
///    bodies — the Phase 02.6 queue lock (immutable payload).
class SendTransactionRequest extends Equatable {
  const SendTransactionRequest({
    required this.transactionId,
    required this.deviceId,
    required this.bankCode,
    required this.transactionType,
    required this.amount,
    required this.currency,
    required this.timestamp,
    required this.confidence,
    required this.sourceSmsHash,
    this.cardNumberMasked,
    this.accountNumber,
    this.referenceNumber,
    this.traceNumber,
    this.standing,
    this.updatedAt,
  });

  /// FROZEN v1 wire body — POST /api/v1/transactions.
  ///
  /// CREATE form (exact roadmap sample, + account_number extension):
  /// ```json
  /// {
  ///   "transaction_id": "local-unique-id",
  ///   "device_id": "device-id",
  ///   "bank_code": "MELLAT",
  ///   "transaction_type": "deposit",
  ///   "amount": 500000,
  ///   "currency": "IRR",
  ///   "timestamp": "2026-10-03T12:31:24Z",
  ///   "card_number_masked": "6037********1234",
  ///   "account_number": "1234-567-890",
  ///   "reference_number": "123456789",
  ///   "trace_number": "987654",
  ///   "confidence": 0.96,
  ///   "source_sms_hash": "sha256..."
  /// }
  /// ```
  ///
  /// UPDATE form (standing mutation — the Phase 02.6 lock "send the
  /// ENTIRE record"): identical field set PLUS the two update-only
  /// members [standing] and [updatedAt] carrying the new state. The
  /// backend merges as the source of truth.
  ///
  /// SECURITY: carries only masked/derived values by construction —
  /// the raw SMS body never travels; `source_sms_hash` is its safe
  /// reference (same rule as every layer since the parser boundary).

  /// THE Idempotency-Key of the send path — the local Transaction.id.
  /// Retries of the same record replay this exact value.
  final String transactionId;

  /// Capturing device — `device_id`.
  final String deviceId;

  /// Stable bank wire code — `bank_code` (e.g. 'MELLAT').
  final String bankCode;

  /// Wire name of the movement type — `transaction_type`.
  /// Allowed: deposit | withdrawal | transfer | purchase | unknown.
  final String transactionType;

  /// Amount in the smallest unit — rials, non-negative integer.
  final int amount;

  /// ISO-4217 style code — `currency` (e.g. 'IRR').
  final String currency;

  /// Transaction time, ISO 8601 UTC — `timestamp`.
  final DateTime timestamp;

  /// Already-masked card — `card_number_masked` ('6037********1234').
  final String? cardNumberMasked;

  /// Account number as extracted — `account_number`.
  final String? accountNumber;

  /// Bank reference, verbatim — `reference_number`.
  final String? referenceNumber;

  /// Bank trace, verbatim — `trace_number`.
  final String? traceNumber;

  /// Deterministic parse score 0.0..1.0 — `confidence`.
  final double confidence;

  /// SHA-256 of the source SMS — `source_sms_hash`. The safe lineage
  /// reference; the raw body never travels.
  final String sourceSmsHash;

  /// UPDATE-ONLY — `standing`. Present exclusively on standing
  /// mutations; null/absent on the create form.
  /// Allowed: pending | confirmed | rejected.
  final String? standing;

  /// UPDATE-ONLY — `updated_at` of the mutated record. Present
  /// exclusively on standing mutations.
  final DateTime? updatedAt;

  @override
  List<Object?> get props => <Object?>[
        transactionId,
        deviceId,
        bankCode,
        transactionType,
        amount,
        currency,
        timestamp,
        cardNumberMasked,
        accountNumber,
        referenceNumber,
        traceNumber,
        confidence,
        sourceSmsHash,
        standing,
        updatedAt,
      ];
}

class SendTransactionResponse extends Equatable {
  const SendTransactionResponse({
    required this.success,
    required this.serverTransactionId,
    required this.status,
  });

  /// FROZEN v1 wire body — 2xx of POST /api/v1/transactions.
  /// Exact roadmap sample:
  /// ```json
  /// {
  ///   "success": true,
  ///   "server_transaction_id": "srv-123",
  ///   "status": "accepted"
  /// }
  /// ```
  ///
  /// NOTE — 409 duplicate does NOT arrive here: it arrives as an
  /// [ApiErrorResponse] (origin http, 409) and the Phase 09/10
  /// mapping converts it to duplicate-confirmed SUCCESS (the
  /// idempotency contract: a duplicate request never creates a
  /// second financial record).

  /// Whether the backend accepted the record.
  final bool success;

  /// Backend identifier of the accepted record — becomes
  /// Transaction.serverTransactionId locally (set-once).
  final String serverTransactionId;

  /// Acceptance status — 'accepted' on this 2xx shape.
  final String status;

  @override
  List<Object?> get props => <Object?>[
        success,
        serverTransactionId,
        status,
      ];
}

class SyncTransactionRequest extends Equatable {
  const SyncTransactionRequest({
    required this.id,
    required this.entityType,
    required this.entityId,
    required this.operation,
    required this.payloadVersion,
    required this.payload,
  });

  /// FROZEN v1 wire body — the queue-entry transmission envelope of
  /// the sync path (Phase 10 contract; the Phase 02.6 queue lock is
  /// its source). Sample:
  /// ```json
  /// {
  ///   "id": "queue-entry-uuid",
  ///   "entity_type": "transaction",
  ///   "entity_id": "transaction-uuid",
  ///   "operation": "create",
  ///   "payload_version": 1,
  ///   "payload": { "...the SendTransactionRequest v1 body..." }
  /// }
  /// ```
  ///
  /// For entityType 'transaction', `payload` IS the
  /// SendTransactionRequest v1 shape (create form or update form
  /// with standing/updated_at). For other entity kinds (e.g.
  /// 'pending_transaction'), their own vN payload contracts apply —
  /// defined by the sync feature when those phases land.

  /// THE Idempotency-Key of the sync path — the SyncQueueItem.id.
  /// A re-delivery replays this exact handle; the backend never
  /// double-applies.
  final String id;

  /// Snake-case entity discriminator — 'transaction' |
  /// 'pending_transaction' | (future kinds, unknown→skip+log).
  final String entityType;

  /// Local id of the carried record.
  final String entityId;

  /// Write kind — 'create' | 'update' (upsert-only vocabulary).
  final String operation;

  /// Version tag of the payload contract.
  final int payloadVersion;

  /// The fully-marshaled, IMMUTABLE body — byte-identical replays
  /// on retry (the queue payload lock).
  final Map<String, Object?> payload;

  @override
  List<Object?> get props => <Object?>[
        id,
        entityType,
        entityId,
        operation,
        payloadVersion,
        // Equatable performs deep map comparison.
        payload,
      ];
}

class SyncTransactionResponse extends Equatable {
  const SyncTransactionResponse({
    required this.success,
    required this.status,
    this.serverTransactionId,
  });

  /// FROZEN v1 wire body — 2xx of the sync path. Sample:
  /// ```json
  /// {
  ///   "success": true,
  ///   "status": "accepted",
  ///   "server_transaction_id": "srv-123"
  /// }
  /// ```

  /// Whether the backend accepted the envelope.
  final bool success;

  /// Acceptance status — 'accepted'.
  final String status;

  /// Present when the carried entry was a transaction record —
  /// becomes its serverTransactionId locally.
  final String? serverTransactionId;

  @override
  List<Object?> get props => <Object?>[
        success,
        status,
        serverTransactionId,
      ];
}

class ApiErrorResponse extends Equatable {
  const ApiErrorResponse._({
    required this.origin,
    required this.statusCode,
    this.errorCode,
    this.message,
    this.details,
  });

  /// Origin 1 — server answered with an HTTP error status and a
  /// parseable contract body.
  factory ApiErrorResponse.http({
    required int statusCode,
    String? errorCode,
    String? message,
    Map<String, Object?>? details,
  }) {
    return ApiErrorResponse._(
      origin: ApiErrorOrigin.http,
      statusCode: statusCode,
      errorCode: errorCode,
      message: message,
      details: details,
    );
  }

  /// Origin 2 — server answered but the body was not the contract
  /// JSON (unparseable / HTML / empty).
  factory ApiErrorResponse.malformed({
    required int statusCode,
    String? message,
  }) {
    return ApiErrorResponse._(
      origin: ApiErrorOrigin.malformed,
      statusCode: statusCode,
      message: message,
      details: null,
    );
  }

  /// Origin 3 — no HTTP response ever arrived (connection refused /
  /// timeout mid-flight / DNS failure).
  factory ApiErrorResponse.network({String? message}) {
    return ApiErrorResponse._(
      origin: ApiErrorOrigin.network,
      statusCode: null,
      errorCode: null,
      message: message,
      details: null,
    );
  }

  /// Error contract v1 — flattened from the wire envelope:
  /// ```json
  /// {
  ///   "success": false,
  ///   "error": {
  ///     "code": "VALIDATION_FAILED",
  ///     "message": "amount must be a positive integer",
  ///     "details": { "field": "amount" }
  ///   }
  /// }
  /// ```
  ///
  /// WELL-KNOWN STATUS MAPPING (Phase 09 implements; frozen here):
  ///   401 → Unauthorized (session dead)
  ///   403 → Forbidden
  ///   409 → Duplicate — SUCCESS-class (idempotent duplicate)
  ///   422 → Validation error (permanent)
  ///   429 → Rate limited (retryable; honor Retry-After)
  ///   5xx → Server error (retryable)
  ///   network origin → retryable (queued, never failed)

  /// Which transport shape this is.
  final ApiErrorOrigin origin;

  /// HTTP status code — null ONLY for the network origin.
  final int? statusCode;

  /// Machine-readable code from the body (e.g. 'VALIDATION_FAILED').
  final String? errorCode;

  /// Server/transport text — SECONDARY display only; the primary
  /// user-facing message is always a localized one from the
  /// Phase 09/12 mapping.
  final String? message;

  /// Server-owned structured detail (e.g. `{'field': 'amount'}`).
  final Map<String, Object?>? details;

  @override
  List<Object?> get props => <Object?>[
        origin,
        statusCode,
        errorCode,
        message,
        // Equatable performs deep map comparison.
        details,
      ];
}

/// Which transport shape an [ApiErrorResponse] represents.
///
/// Wire names are OUTBOUND serialization only (logs, the sync
/// screen). Runtime-constructed — never persisted, so no fromName
/// exists; new origins can be added non-breaking.
enum ApiErrorOrigin {
  /// Server answered with an HTTP error status + contract body.
  http('http'),

  /// Server answered but the body was not the contract JSON.
  malformed('malformed'),

  /// No HTTP response ever arrived.
  network('network');

  const ApiErrorOrigin(this.wireName);

  /// Stable outbound name for logs — never rename existing values.
  final String wireName;
}