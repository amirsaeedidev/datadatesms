import 'package:drift/drift.dart';

import 'package:datadadtesms/core/constants/db_constants.dart';

/// Match evaluations — Drift table (matching_records).
///
/// Storage for the MATCHING OUTCOME layer (its feature phase owns
/// the engine; Phase 03 only freezes the physical shape). Each row
/// is ONE evaluation of a Transaction against a PendingTransaction
/// — the third leg of the three-way separation (record standing /
/// transmission / matching), kept separate from both.
///
/// SOFT REFERENCES — NO FOREIGN KEYS, deliberate (two reasons):
///  1. pending_transactions rows are backend-owned mirrors; a
///     backend cancellation must not RESTRICT local match history —
///     the match row OUTLIVES the cancelled expectation (audit).
///  2. transactions rows are audit-retained forever, but the pair
///     uniqueness (below) must hold even across re-parses.
///     Referential history is enforced by query discipline, not by
///     an FK chain that would entangle three lifecycles.
///
/// PAIR UNIQUENESS: (transactionId, pendingTransactionId) UNIQUE —
/// one evaluation row per pair. A re-run of the matching engine for
/// the same pair UPDATES the existing row (score evolves, status
/// evolves) rather than duplicating history: the CURRENT state of
/// each pair is what the matching screen renders.
///
/// AMBIGUITY CONTRACT (RULE-009): ambiguous outcomes are stored as
/// `needs_review` with the competing candidates referenced in the
/// payload JSON — the engine NEVER auto-resolves. Review decisions
/// (approve/reject) mutate the row: [decidedBy] records the acting
/// admin user id, [decidedAt] the decision time.
///
/// WIRE ENUMS as TEXT: matchStatus stores its wire name ('matched'
/// | 'needs_review' | 'rejected'); the vocabulary is owned by the
/// matching feature's entity (its phase). decisionSource stores
/// 'engine' | 'admin' — who set the current status.
///
/// CONFIDENTIALITY: [payload] carries only SAFE data — matcher
/// scores per dimension, competing candidate ids, masked hints.
/// No raw SMS, no unmasked values (same policy as every layer).
@TableIndex(
  name: 'ix_matching_records_status',
  columns: <String>['matchStatus'],
)
@TableIndex(
  name: 'ix_matching_records_transaction_id',
  columns: <String>['transactionId'],
)
class MatchingRecordsTable extends Table {
  @override
  String get tableName => DbConstants.tableMatchingRecords;

  /// Primary key — locally generated UUID (match rows are
  /// local-origin records). TEXT, not auto-increment.
  TextColumn get id => text().clientDefault(() => '')();

  /// The evaluated financial record — transactions.id. SOFT
  /// reference (no FK): see the class doc comment.
  TextColumn get transactionId => text()();

  /// The evaluated expectation — pending_transactions.id. SOFT
  /// reference (no FK): backend-owned mirror, match history
  /// outlives cancellations.
  TextColumn get pendingTransactionId => text()();

  /// Wire name of the match status ('matched' | 'needs_review' |
  /// 'rejected') — model marshals. Ambiguity lands here as
  /// needs_review, never auto-resolved.
  TextColumn get matchStatus => text()();

  /// Engine confidence for this pair, 0.0..1.0 — deterministic
  /// matcher output (the matching feature phase owns the formula).
  RealColumn get score => real()();

  /// Safe JSON payload — per-matcher scores, competing candidate
  /// ids, masked hints. Never raw SMS / unmasked values.
  TextColumn get payload => text().withDefault(const Constant('{}'))();

  /// Who set the current status — 'engine' (auto evaluation) |
  /// 'admin' (review decision). Model marshals.
  TextColumn get decisionSource => text().withDefault(
        const Constant('engine'),
      )();

  /// Acting admin user id — set only on review decisions
  /// (approve/reject/resolve); null on engine-evaluated rows.
  TextColumn get decidedBy => text().nullable()();

  /// Decision time (UTC) — null on engine-evaluated rows.
  DateTimeColumn get decidedAt => dateTime().nullable()();

  /// First evaluation time (UTC).
  DateTimeColumn get createdAt => dateTime()();

  /// Last status/payload mutation (UTC) — re-runs UPDATE this row,
  /// never duplicate it (pair uniqueness).
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => <Column>{id};

  /// One evaluation row per pair — re-runs update, never duplicate.
  @override
  List<Set<Column>> get uniqueKeys => <Set<Column>>[
        <Column>{transactionId, pendingTransactionId},
      ];
}