import 'package:drift/drift.dart';

import 'package:datadadtesms/core/constants/db_constants.dart';

/// Expected-payment records — Drift table (pending_transactions).
///
/// PHYSICAL mapping of the Phase 02 [PendingTransaction] entity.
/// Backend-authored records cached locally for matching: a mirror,
/// not a source.
///
/// NO deviceId COLUMN — deliberate (Phase 02 lock): unlike
/// sms_messages/transactions (captured on THIS device), these
/// records are SHARED across devices and device-agnostic by
/// definition. The storage mirrors the contract exactly.
///
/// NO foreign keys OUT — deliberate: the id space is backend-owned
/// (no local UUIDs), and no local table references these rows.
/// matching_records will reference them by id (a soft TEXT
/// reference, not a hard FK — see that table's doc when it lands:
/// match rows may outlive backend cancellations and must not be
/// restricted by a local FK chain).
///
/// NULLABILITY maps 1:1 to the entity: all hints
/// ([bankCode]/[cardHint]/[referenceHint]) and both window bounds
/// ([validFrom]/[validUntil]) are nullable narrowing constraints;
/// title/type/amount/currency/status/timestamps are non-null.
///
/// WIRE ENUMS as TEXT: type / currency / status store wire names;
/// model layer marshals (strict fromName already quarantined
/// unknown values at the entity layer).
@TableIndex(
  name: 'ix_pending_transactions_status',
  columns: <String>['status'],
)
class PendingTransactionsTable extends Table {
  @override
  String get tableName => DbConstants.tablePendingTransactions;

  /// Primary key — [PendingTransaction.id], the BACKEND identifier
  /// (not a local UUID). TEXT; rows arrive by sync with their ids.
  TextColumn get id => text().clientDefault(() => '')();

  /// Display label authored on the backend (e.g.
  /// 'سفارش ۱۲۳۴ — علی'). Plain TEXT.
  TextColumn get title => text()();

  /// Wire name of TransactionType ('deposit', ...) — model marshals.
  TextColumn get type => text()();

  /// Expected amount in the smallest unit (rials) — non-negative
  /// integer; sign implied by type.
  IntColumn get amount => integer()();

  /// ISO-4217 style code ('IRR') — model marshals.
  TextColumn get currency => text()();

  /// Optional bank constraint ([Bank.code]) — null = any bank.
  TextColumn get bankCode => text().nullable()();

  /// Optional masked-form / last-digits hint for CardMatcher —
  /// null = unconstrained.
  TextColumn get cardHint => text().nullable()();

  /// Optional reference hint, verbatim — null = unconstrained.
  TextColumn get referenceHint => text().nullable()();

  /// Window start (UTC) — null = no lower bound.
  DateTimeColumn get validFrom => dateTime().nullable()();

  /// Window deadline (UTC) — null = no upper bound.
  DateTimeColumn get validUntil => dateTime().nullable()();

  /// Wire name of PendingTransactionStatus ('active' |
  /// 'fulfilled' | 'cancelled') — model marshals. NO 'expired'
  /// value exists (Phase 02: expiry is a time-window judgment
  /// owned by TimeMatcher, not a standing).
  TextColumn get status => text()();

  /// Backend creation time (UTC).
  DateTimeColumn get createdAt => dateTime()();

  /// Last change (UTC) — backend edits AND local standing
  /// mutations (approved match → fulfilled).
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => <Column>{id};
}