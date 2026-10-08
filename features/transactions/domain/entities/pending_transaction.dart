import 'package:equatable/equatable.dart';

import 'package:datadadtesms/features/transactions/domain/entities/currency.dart';
import 'package:datadadtesms/features/transactions/domain/entities/transaction_type.dart';

/// An EXPECTED payment record — transactions domain entity.
///
/// ROLE — the other side of matching (contract locked in Phase 02):
/// a [Transaction] is money that actually happened (parsed from a
/// bank SMS on this device). A PendingTransaction is the payment the
/// business EXPECTS to receive/pay — authored on the website/CRM,
/// pushed down (Supabase realtime, Phase 14) and cached locally.
/// The MatchingEngine (its own feature phase) evaluates
/// Transaction × PendingTransaction pairs; the pair outcomes are
/// recorded as matching data — never on this entity.
///
/// THREE-WAY SEPARATION (locked in TransactionStatus) applies here
/// too: this entity carries its own RECORD STANDING only — no match
/// state (that belongs to matching records) and no sync state (the
/// sync queue owns transmission). A pending item can be `active`
/// while a match is under review and while its latest sync rides
/// the queue — none implies the other.
///
/// EXPIRY IS NOT A STATUS — deliberate: whether "the deadline has
/// passed" is a TIME-WINDOW judgment owned by TimeMatcher (matching
/// phase) and by reporting views; the standing is only ever mutated
/// by two events: an approved match ([PendingTransactionStatus.fulfilled])
/// or a backend cancellation (synced down). No clock ever writes to
/// this record — that keeps it deterministic and avoids a third
/// mutation path fighting the sync queue.
///
/// HINTS ([bankCode], [cardHint], [referenceHint]) are OPTIONAL
/// NARROWING constraints for the matchers — when absent the
/// corresponding matcher simply treats that dimension as
/// unconstrained. A hint NEVER turns into a hard requirement by
/// itself.
///
/// NO deviceId — deliberate: unlike SmsMessage/Transaction (captured
/// on this device), this is a backend-authored record SHARED across
/// devices; it is device-agnostic by definition.
///
/// Pure domain: no Flutter, no Supabase, no serialization here —
/// wire mapping lives in `PendingTransactionModel` (data layer).
class PendingTransaction extends Equatable {
  const PendingTransaction({
    required this.id,
    required this.title,
    required this.type,
    required this.amount,
    required this.currency,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    this.bankCode,
    this.cardHint,
    this.referenceHint,
    this.validFrom,
    this.validUntil,
  });

  /// Backend identifier of the expected-payment record — NOT a
  /// locally generated UUID: this row is authored on the backend and
  /// identified by it. Stable across re-syncs.
  final String id;

  /// Display label authored on the backend (e.g.
  /// 'سفارش ۱۲۳۴ — علی'). Config data, not an l10n key.
  final String title;

  /// The movement type the business expects (almost always
  /// [TransactionType.deposit] for incoming payments).
  final TransactionType type;

  /// Expected amount in the smallest unit of [currency] (rials for
  /// IRR). Non-negative integer; sign implied by [type] — same
  /// convention as Transaction.
  final int amount;

  /// Monetary unit — [Currency.irr] unless the backend says
  /// otherwise.
  final Currency currency;

  /// Optional constraint: payment is expected via this bank
  /// ([Bank.code]). Null = any bank.
  final String? bankCode;

  /// Optional hint for CardMatcher — masked form or last digits
  /// (e.g. '6037********1234' or '1234'). Null = unconstrained.
  final String? cardHint;

  /// Optional hint for ReferenceMatcher — a reference the customer
  /// was given and might appear with the payment. Null =
  /// unconstrained. Opaque string, compared verbatim (no
  /// trim/pad — same rule as Transaction references).
  final String? referenceHint;

  /// Start of the acceptable arrival window (UTC). Null = no lower
  /// bound. Interpreted by TimeMatcher; see the expiry note in the
  /// class doc comment.
  final DateTime? validFrom;

  /// Deadline of the acceptable arrival window (UTC). Null = no
  /// upper bound.
  final DateTime? validUntil;

  /// Record standing — see [PendingTransactionStatus].
  final PendingTransactionStatus status;

  /// When the backend created this record (UTC).
  final DateTime createdAt;

  /// When this record was last changed (UTC) — refreshed by backend
  /// edits AND by local standing mutations (an approved match sets
  /// `fulfilled`); standing changes ride the sync queue up in the
  /// sync feature's phase.
  final DateTime updatedAt;

  /// Returns a copy with the provided fields replaced.
  ///
  /// NOTE: `null` arguments KEEP the current value — this entity
  /// never needs to clear a hint or a window bound, so standard
  /// copyWith semantics are sufficient.
  PendingTransaction copyWith({
    String? id,
    String? title,
    TransactionType? type,
    int? amount,
    Currency? currency,
    String? bankCode,
    String? cardHint,
    String? referenceHint,
    DateTime? validFrom,
    DateTime? validUntil,
    PendingTransactionStatus? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return PendingTransaction(
      id: id ?? this.id,
      title: title ?? this.title,
      type: type ?? this.type,
      amount: amount ?? this.amount,
      currency: currency ?? this.currency,
      bankCode: bankCode ?? this.bankCode,
      cardHint: cardHint ?? this.cardHint,
      referenceHint: referenceHint ?? this.referenceHint,
      validFrom: validFrom ?? this.validFrom,
      validUntil: validUntil ?? this.validUntil,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => <Object?>[
        id,
        title,
        type,
        amount,
        currency,
        bankCode,
        cardHint,
        referenceHint,
        validFrom,
        validUntil,
        status,
        createdAt,
        updatedAt,
      ];
}

/// Record standing of a PendingTransaction.
///
/// State machine (transitions are OWNED by UseCases / the sync
/// layer in later phases — this enum is vocabulary + documentation
/// only):
///
/// ```text
///   backend creates (synced down)
///              ↓
///         ┌─────────┐  admin approves a match (review flow)
///         │ active  │ ─────────────────────────→ fulfilled
///         └────┬────┘
///              │ backend cancels (synced down)
///              ↓
///         cancelled
/// ```
///
/// `fulfilled` and `cancelled` are TERMINAL. There is deliberately
/// NO `expired` value — see the expiry note in the
/// PendingTransaction class doc comment.
enum PendingTransactionStatus {
  /// Open and awaiting a payment match.
  active('active'),

  /// An approved match fulfilled this expectation — terminal.
  fulfilled('fulfilled'),

  /// Cancelled on the backend — excluded from matching eligibility;
  /// the row is retained (audit trail). Terminal.
  cancelled('cancelled');

  const PendingTransactionStatus(this.wireName);

  /// Stable wire/serialization name — persisted in the local DB
  /// (`pending_transactions.status`) and exchanged with the backend.
  /// Never rename existing values.
  final String wireName;

  /// Parses a serialized standing coming from local storage or the
  /// backend payload.
  ///
  /// STRICT — returns `null` for unknown values (standing-enum
  /// policy, same as SmsProcessingStatus / TransactionStatus):
  /// a wrong standing silently misreports matching eligibility and
  /// financial expectations — it must be surfaced and logged by the
  /// mapper, never silently remapped.
  static PendingTransactionStatus? fromName(String? name) {
    if (name == null) {
      return null;
    }
    for (final PendingTransactionStatus value
        in PendingTransactionStatus.values) {
      if (value.wireName == name) {
        return value;
      }
    }
    return null;
  }
}