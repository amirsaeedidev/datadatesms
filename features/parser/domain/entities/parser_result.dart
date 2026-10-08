import 'package:equatable/equatable.dart';

import 'package:datadadtesms/features/parser/domain/entities/parsed_transaction.dart';
import 'package:datadadtesms/features/parser/domain/entities/parser_confidence.dart';
import 'package:datadadtesms/features/parser/domain/entities/parser_rule_result.dart';

/// Aggregate outcome of ONE parse run — parser domain value object.
///
/// Contract locked in Phase 02:
///  - Produced EXCLUSIVELY by ParserEngine (Phase 07) — exactly one
///    instance per parse attempt.
///  - Scope: ONE message × ONE resolved bank. Relevance & bank
///    detection happen BEFORE the parse — ProcessIncomingSmsUseCase
///    (Phase 06) runs BankDetector first: a message with no detected
///    (enabled) bank never produces a ParserResult at all; it is
///    marked `ignored` on the SmsMessage instead. Consequently
///    [bankCode]/[bankName] are ALWAYS present on this object.
///    (The Phase 12 parser test page calls BankDetector separately
///    for its own "no bank detected" feedback.)
///
/// THREE shapes, created ONLY through the named factories — an
/// invalid combination (both null / both set) is unrepresentable:
///  1. [ParserResult.success]      — transaction set, reason null,
///     confidence set. The ParsedTransaction flows toward Phase 08
///     (Validation → Dedup → Transaction).
///  2. [ParserResult.parseFailure] — reason missingRequiredField.
///     The parse RAN; confidence is REQUIRED because it explains
///     exactly WHICH fields failed (the correspondence locked in the
///     ParserConfidence / ParserRuleResult doc comments).
///  3. [ParserResult.noParserConfigured] — reason noParserConfigured,
///     confidence NULL, ruleResults empty. Nothing executed: a
///     CONFIGURATION GAP, not a message problem.
///
/// Expected downstream handling (Phase 06 UseCases own the actual
/// SmsMessage transition table):
///  - success            → advances toward Phase 08 pipeline
///  - parseFailure       → SmsMessage `failed`; detail → technical log
///  - noParserConfigured → SmsMessage `failed` (admin config gap)
///
/// SECURITY: log-safe by construction — no raw or normalized body
/// anywhere on this object; every value inside the traces is
/// display-safe (masking happened at the extraction boundary).
///
/// PERSISTENCE: not persisted as a whole — transactions persist only
/// the numeric confidenceScore; failure detail lives in technical
/// logs. Hence no serialization here and no copyWith (immutable
/// snapshot — same policy as ParserConfidence / ParserRuleResult).
///
/// Pure domain: no Flutter, no Supabase.
class ParserResult extends Equatable {
  const ParserResult._({
    required this.bankCode,
    required this.bankName,
    this.transaction,
    this.failureReason,
    this.confidence,
    this.ruleResults = const <ParserRuleResult>[],
  });

  /// Shape 1 — successful parse. [transaction] is the extraction
  /// output ready for the Phase 08 pipeline.
  factory ParserResult.success({
    required String bankCode,
    required String bankName,
    required ParsedTransaction transaction,
    required ParserConfidence confidence,
    required List<ParserRuleResult> ruleResults,
  }) {
    return ParserResult._(
      bankCode: bankCode,
      bankName: bankName,
      transaction: transaction,
      confidence: confidence,
      ruleResults: ruleResults,
    );
  }

  /// Shape 2 — the parser RAN but a required field could not be
  /// extracted or failed its validation config ([ParserRule.isRequired]
  /// contract; a missing amount is this reason too — amount is
  /// structurally required on ParsedTransaction).
  ///
  /// [confidence] is REQUIRED here: the breakdown (missingFields +
  /// warnings) is what explains the failure to logs, audit and the
  /// parser test page.
  factory ParserResult.parseFailure({
    required String bankCode,
    required String bankName,
    required ParserConfidence confidence,
    required List<ParserRuleResult> ruleResults,
  }) {
    return ParserResult._(
      bankCode: bankCode,
      bankName: bankName,
      failureReason: ParserFailureReason.missingRequiredField,
      confidence: confidence,
      ruleResults: ruleResults,
    );
  }

  /// Shape 3 — bank resolved but NO parser is available (dedicated
  /// parser not registered for its code, or configurable bank with
  /// zero active rules). Nothing executed.
  factory ParserResult.noParserConfigured({
    required String bankCode,
    required String bankName,
  }) {
    return ParserResult._(
      bankCode: bankCode,
      bankName: bankName,
      failureReason: ParserFailureReason.noParserConfigured,
    );
  }

  /// Wire code of the bank whose parser ran — [Bank.code]. Always
  /// present (detection is decided before the parse; see the class
  /// doc comment).
  final String bankCode;

  /// Display name of the bank — [Bank.name].
  final String bankName;

  /// Set ONLY on the success shape — the extraction output.
  final ParsedTransaction? transaction;

  /// Set ONLY on the failure shapes — which failure it is.
  final ParserFailureReason? failureReason;

  /// Trust breakdown. Present on success and parseFailure (where it
  /// EXPLAINS the outcome); null only for noParserConfigured —
  /// nothing ran, there is nothing to assess.
  final ParserConfidence? confidence;

  /// Per-rule execution traces of the ACTIVE rules that ran.
  /// Empty only for noParserConfigured.
  final List<ParserRuleResult> ruleResults;

  /// Whether this is the successful shape — the single discriminator
  /// consumers switch on.
  bool get isSuccess => transaction != null;

  @override
  List<Object?> get props => <Object?>[
        bankCode,
        bankName,
        transaction,
        failureReason,
        confidence,
        // Equatable performs deep list comparison.
        ruleResults,
      ];
}

/// Shape of a FAILED parse — why a ParserResult carries
/// [ParserResult.failureReason].
///
/// Wire names are OUTBOUND serialization only (technical logs, audit
/// metadata, parser test page). The result is recomputed at runtime
/// and never persisted as a database enum, so no `fromName` exists —
/// new reasons can be added non-breaking (same policy as
/// ParserRuleOutcome / ParserConfidenceWarningKind). If a future
/// phase ever persists these, the fromName added THEN must be
/// STRICT (null + quarantine).
enum ParserFailureReason {
  /// The parser RAN, but a field required for a valid transaction
  /// could not be extracted or failed its validation config — the
  /// [ParserRule.isRequired] contract. This ALWAYS covers the
  /// amount: amount is structurally required on ParsedTransaction,
  /// so a missing amount maps here regardless of the rule's own
  /// isRequired flag. WHICH field(s) failed: see
  /// ParserConfidence.missingFields + the missingRequiredField
  /// warning kind.
  missingRequiredField('missing_required_field'),

  /// The parser did NOT run at all: the bank resolved to no parser
  /// (dedicated parser not registered for its code, or configurable
  /// bank with zero active rules). A CONFIGURATION GAP, not a
  /// message problem — nothing executed, so there is no confidence
  /// breakdown and no rule traces.
  noParserConfigured('no_parser_configured');

  const ParserFailureReason(this.wireName);

  /// Stable outbound name for logs/audit — never rename existing
  /// values.
  final String wireName;
}