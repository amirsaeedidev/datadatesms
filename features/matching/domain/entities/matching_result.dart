import 'package:equatable/equatable.dart';

/// Evaluation of ONE Transaction against ONE PendingTransaction —
/// matching domain entity (MINIMAL Phase 03 pull-forward).
///
/// SCOPE LOCK: this file carries exactly the fields of the locked
/// matching_records TABLE (Phase 03) — nothing more. The matching
/// feature phase later enriches it (typed payload object, engine
/// helpers, l10n mappings) WITHOUT breaking this shape; the table
/// columns are the contract and this entity mirrors them 1:1.
///
/// AMBIGUITY CONTRACT (RULE-009): ambiguous outcomes land as
/// [MatchingResultStatus.needsReview] with competing candidates
/// referenced inside [payload] — the engine NEVER auto-resolves.
/// Review decisions (approve/reject/resolve) set the admin actor
/// fields.
///
/// SOFT PAIR: transactionId/pendingTransactionId are soft
/// references (no FK chain — the table contract): match rows
/// outlive backend cancellations.
///
/// SECURITY: [payload] carries only SAFE data — per-matcher scores,
/// competing candidate ids, masked hints. Never raw SMS, never
/// unmasked values.
class MatchingResult extends Equatable {
  const MatchingResult({
    required this.id,
    required this.transactionId,
    required this.pendingTransactionId,
    required this.status,
    required this.score,
    required this.decisionSource,
    required this.createdAt,
    required this.updatedAt,
    this.payload = const <String, Object?>{},
    this.decidedBy,
    this.decidedAt,
  });

  /// Local unique identifier (UUID) — match rows are local-origin.
  final String id;

  /// The evaluated financial record — transactions.id (soft ref).
  final String transactionId;

  /// The evaluated expectation — pending_transactions.id (soft ref).
  final String pendingTransactionId;

  /// The pair's current outcome — see [MatchingResultStatus].
  final MatchingResultStatus status;

  /// Engine confidence for this pair, 0.0..1.0 — deterministic
  /// matcher output (formula owned by the matching feature phase).
  final double score;

  /// Safe JSON payload — per-matcher scores, competing candidate
  /// ids, masked hints (see SECURITY in the class doc comment).
  final Map<String, Object?> payload;

  /// Who set the current status — engine (auto) or admin (review).
  final MatchingDecisionSource decisionSource;

  /// Acting admin user id — set only on review decisions; null on
  /// engine-evaluated rows.
  final String? decidedBy;

  /// Decision time (UTC) — null on engine-evaluated rows.
  final DateTime? decidedAt;

  /// First evaluation time (UTC).
  final DateTime createdAt;

  /// Last status/payload mutation (UTC) — re-runs UPDATE the pair
  /// row, never duplicate it.
  final DateTime updatedAt;

  /// Returns a copy with the provided fields replaced.
  ///
  /// NOTE: null arguments KEEP the current value — decidedBy/
  /// decidedAt are only ever SET (engine rows gain them once),
  /// never cleared back.
  MatchingResult copyWith({
    String? id,
    String? transactionId,
    String? pendingTransactionId,
    MatchingResultStatus? status,
    double? score,
    Map<String, Object?>? payload,
    MatchingDecisionSource? decisionSource,
    String? decidedBy,
    DateTime? decidedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return MatchingResult(
      id: id ?? this.id,
      transactionId: transactionId ?? this.transactionId,
      pendingTransactionId: pendingTransactionId ?? this.pendingTransactionId,
      status: status ?? this.status,
      score: score ?? this.score,
      payload: payload ?? this.payload,
      decisionSource: decisionSource ?? this.decisionSource,
      decidedBy: decidedBy ?? this.decidedBy,
      decidedAt: decidedAt ?? this.decidedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => <Object?>[
        id,
        transactionId,
        pendingTransactionId,
        status,
        score,
        // Equatable performs deep map comparison.
        payload,
        decisionSource,
        decidedBy,
        decidedAt,
        createdAt,
        updatedAt,
      ];
}

/// The pair's current outcome.
///
/// Three values — exactly the locked table vocabulary. Ambiguity is
/// needsReview, NEVER auto-resolved (RULE-009).
enum MatchingResultStatus {
  /// Engine-approved or admin-approved match.
  matched('matched'),

  /// Ambiguous / manual review queue — the RULE-009 landing state.
  needsReview('needs_review'),

  /// Rejected by engine pre-filters or by admin decision.
  rejected('rejected');

  const MatchingResultStatus(this.wireName);

  /// Stable wire name — persisted in matching_records.match_status.
  /// Never rename existing values.
  final String wireName;

  /// STRICT parse (persisted standing vocabulary): null for unknown
  /// values — a wrong standing silently misreports matching outcomes.
  static MatchingResultStatus? fromName(String? name) {
    if (name == null) {
      return null;
    }
    for (final MatchingResultStatus value in MatchingResultStatus.values) {
      if (value.wireName == name) {
        return value;
      }
    }
    return null;
  }
}

/// Who set the current status of a pair row.
enum MatchingDecisionSource {
  /// Automatic engine evaluation.
  engine('engine'),

  /// Admin review decision (approve/reject/resolve).
  admin('admin');

  const MatchingDecisionSource(this.wireName);

  /// Stable wire name — persisted in matching_records.decision_source.
  final String wireName;

  /// STRICT parse (persisted vocabulary).
  static MatchingDecisionSource? fromName(String? name) {
    if (name == null) {
      return null;
    }
    for (final MatchingDecisionSource value
        in MatchingDecisionSource.values) {
      if (value.wireName == name) {
        return value;
      }
    }
    return null;
  }
}