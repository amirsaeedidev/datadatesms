import 'package:equatable/equatable.dart';

import 'package:datadadtesms/features/banks/domain/entities/parser_rule.dart';

/// Execution trace of ONE parser rule against ONE message — parser
/// domain value object.
///
/// Contract locked in Phase 02:
///  - Produced exclusively by RuleMatcher (Phase 07) — one result per
///    ACTIVE rule that ran. Inactive rules are filtered out BEFORE
///    execution and therefore never produce a result: there is
///    deliberately NO `skipped` outcome (a skipped rule is not part
///    of the run).
///  - Consumed by: ParserResult (aggregates them, next file), the
///    parser test page (Phase 12 — `parser_result_view.dart` renders
///    each rule line) and audit explanations for a parse.
///
/// CORRESPONDENCE with [ParserConfidence] (the aggregate view of the
/// same run):
///  - outcome [ParserRuleOutcome.executionError]
///    ↔ warning `ruleExecutionError`
///  - outcome [ParserRuleOutcome.validationFailed]
///    ↔ warning `validationFailed` (optional fields only)
///  - a REQUIRED rule ending in noMatch / validationFailed /
///    executionError ↔ warning `missingRequiredField` — and the
///    WHOLE parse fails (the isRequired contract on ParserRule).
///
/// SECURITY: [value] and [matchedKeyword] carry POST-normalization,
/// DISPLAY-SAFE data — masking already happened at the extraction
/// boundary (e.g. the card value here is the masked
/// `'6037********1234'`, a full PAN never appears on this object).
/// [errorMessage] is a short technical description and never
/// contains message text. The whole object is safe for the parser
/// test page, technical logs and audit metadata.
///
/// Pure domain: no Flutter, no Supabase, no serialization. This is
/// an immutable trace record — consumers never modify it, hence no
/// copyWith (same policy as ParserConfidence).
class ParserRuleResult extends Equatable {
  const ParserRuleResult({
    required this.ruleId,
    required this.field,
    required this.ruleType,
    required this.outcome,
    this.value,
    this.matchedKeyword,
    this.errorMessage,
  });

  /// The rule that produced this trace — [ParserRule.id].
  final String ruleId;

  /// The field this rule targets — [ParserRule.field].
  final ParserRuleField field;

  /// How the rule executes — [ParserRule.ruleType].
  final ParserRuleType ruleType;

  /// What happened — see [ParserRuleOutcome].
  final ParserRuleOutcome outcome;

  /// The extracted value, PRESENT ONLY when the outcome is
  /// [ParserRuleOutcome.matched] — null in every other outcome
  /// (nothing valid came out of this rule).
  ///
  /// Post-normalization, display-safe form (see SECURITY in the
  /// class doc comment): e.g. `'500000'` for an amount,
  /// `'6037********1234'` for a card, `'deposit'` for a keyword
  /// classification (the valueMap TARGET, not the raw keyword).
  final String? value;

  /// For KEYWORD rules only: the keyword from the message that
  /// triggered the classification — e.g. `'واریز'`. Null for regex
  /// rules and for non-matched keyword rules. Pairs with [value]:
  /// `matchedKeyword` is the trigger, [value] is the canonical
  /// result of the mapping.
  final String? matchedKeyword;

  /// PRESENT ONLY when the outcome is
  /// [ParserRuleOutcome.executionError] — a short technical reason
  /// (e.g. `'invalid regex pattern'`). Safe for logs; never message
  /// text.
  final String? errorMessage;

  @override
  List<Object?> get props => <Object?>[
        ruleId,
        field,
        ruleType,
        outcome,
        value,
        matchedKeyword,
        errorMessage,
      ];
}

/// Terminal outcome of one rule execution.
///
/// Wire names are OUTBOUND serialization only (log/audit metadata
/// and the test page). The breakdown is recomputed at runtime and
/// never persisted as a database enum, so no `fromName` exists —
/// new outcomes can be added non-breaking (same policy as
/// ParserConfidenceWarningKind). If a future phase ever persists
/// these, the fromName added THEN must be STRICT (null + quarantine).
enum ParserRuleOutcome {
  /// Rule executed and produced a value that PASSED its validation
  /// config — [ParserRuleResult.value] is set.
  matched('matched'),

  /// Rule executed cleanly but the pattern/keywords found nothing —
  /// a legitimate miss, NOT an error.
  noMatch('no_match'),

  /// A value was extracted but FAILED the rule's validation config
  /// (length / allowed values) and was DISCARDED.
  validationFailed('validation_failed'),

  /// The rule could not EXECUTE at all (e.g. invalid regex from admin
  /// config) — broken config, not a text miss. See
  /// [ParserRuleResult.errorMessage].
  executionError('execution_error');

  const ParserRuleOutcome(this.wireName);

  /// Stable outbound name for logs/audit — never rename existing
  /// values.
  final String wireName;
}