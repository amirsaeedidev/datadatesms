import 'package:equatable/equatable.dart';

import 'package:datadadtesms/features/banks/domain/entities/parser_rule.dart';

/// Trust assessment of a single parse run — parser domain value object.
///
/// Contract locked in Phase 02:
///  - Produced EXCLUSIVELY by ConfidenceCalculator (Phase 07) from a
///    DETERMINISTIC, documented formula: identical inputs always
///    produce an identical [score] — no randomness, no clock
///    dependence, no rule-order luck.
///  - [score] is normalized: `0.0 <= score <= 1.0`. Only this number
///    flows downstream onto ParsedTransaction, the Transaction row
///    and the API payload (`"confidence": 0.96`). This object is the
///    full BREAKDOWN that powers the parser test page (Phase 12) and
///    audit explanations.
///  - Acceptance thresholds (auto-accept vs manual review) are POLICY
///    and deliberately NOT part of this contract — they belong to the
///    calculator and the transaction/matching decisions.
///
/// Field-set semantics — [ParserRuleField] (banks domain) is the
/// canonical field vocabulary for BOTH dedicated and configurable
/// parsers (the parser feature consumes bank configuration by design,
/// so this dependency direction is sanctioned):
///  - [matchedFields]  — fields extracted with a value that passed
///    their validation config.
///  - [missingFields]  — fields whose ACTIVE rule ran but produced no
///    valid value. Fields with no rule at all are NOT missing — they
///    are simply not part of that bank's message format.
///  - [warnings]       — typed, non-fatal observations that reduce
///    trust.
///
/// NOTE: a confidence object may also accompany a FAILED parse (see
/// [ParserConfidenceWarningKind.missingRequiredField]) so the parser
/// test page can explain exactly why the parse failed.
///
/// Pure domain: no Flutter, no Supabase, no serialization here —
/// this is a computed snapshot; consumers never modify it, hence no
/// copyWith.
class ParserConfidence extends Equatable {
  const ParserConfidence({
    required this.score,
    required this.matchedFields,
    required this.missingFields,
    required this.warnings,
  });

  /// Deterministic parse score, `0.0 <= score <= 1.0`.
  /// Higher = more required/expected fields matched and validated.
  final double score;

  /// Fields successfully extracted AND validated in this parse.
  final List<ParserRuleField> matchedFields;

  /// Fields whose active rule ran but yielded no valid value.
  final List<ParserRuleField> missingFields;

  /// Typed trust warnings raised during this parse.
  final List<ParserConfidenceWarning> warnings;

  @override
  List<Object?> get props => <Object?>[
        score,
        // Equatable performs deep list comparison.
        matchedFields,
        missingFields,
        warnings,
      ];
}

/// A single typed warning inside a [ParserConfidence].
///
/// Warnings are DIAGNOSTIC data: they explain reduced trust and are
/// SAFE for logs/audit — sensitive values are referenced by
/// [ruleId]/[field], never embedded (no raw SMS, no unmasked card).
class ParserConfidenceWarning extends Equatable {
  const ParserConfidenceWarning({
    required this.kind,
    this.field,
    this.ruleId,
  });

  /// What kind of trust issue was observed.
  final ParserConfidenceWarningKind kind;

  /// The field this warning relates to, when applicable.
  final ParserRuleField? field;

  /// The rule whose execution produced the warning, when applicable —
  /// a safe identifier for logs and the parser test page.
  final String? ruleId;

  @override
  List<Object?> get props => <Object?>[kind, field, ruleId];
}

/// Kinds of trust warnings a parse can raise.
///
/// Wire names are OUTBOUND serialization only (log/audit metadata).
/// The breakdown is recomputed at runtime and never persisted as a
/// database enum (transactions persist only the numeric score), so
/// no `fromName` parser exists — adding new kinds later is
/// non-breaking.
enum ParserConfidenceWarningKind {
  /// A REQUIRED field could not be extracted — the parse FAILED.
  /// The confidence breakdown accompanies the failure result to
  /// explain it (parser test page / audit timeline).
  missingRequiredField('missing_required_field'),

  /// An extracted value failed its rule validation config
  /// (length / allowed values) and was DISCARDED. Optional fields
  /// continue the parse and land in missingFields.
  validationFailed('validation_failed'),

  /// A rule failed to EXECUTE (e.g. invalid regex from admin config)
  /// rather than matching nothing. Distinguishes broken config from
  /// non-matching message text.
  ruleExecutionError('rule_execution_error'),

  /// Bank was detected through body-keyword FALLBACK because the
  /// sender was not registered — a weaker signal than sender match.
  fallbackBankDetection('fallback_bank_detection'),

  /// Transaction-type classification matched conflicting keyword
  /// groups; the type fell back to unknown.
  ambiguousTransactionType('ambiguous_transaction_type'),

  /// No date/time could be extracted; the transaction timestamp fell
  /// back to the SMS receive time (device clock).
  timestampFallback('timestamp_fallback');

  const ParserConfidenceWarningKind(this.wireName);

  /// Stable outbound name for logs/audit — never rename existing
  /// values.
  final String wireName;
}