import 'package:equatable/equatable.dart';

/// Configurable parser rule of a bank — banks domain entity.
///
/// Contract locked in Phase 02 (RULE-010, RULE-011):
///  - Rules are CONFIG-DRIVEN data, synced from the backend (admin
///    authored) and cached locally — end users never author regex.
///  - Consumed by ConfigurableBankParser via RuleMatcher (Phase 07).
///  - This entity is a DUMB VALUE OBJECT: it stores the regex SOURCE
///    string but never compiles or executes it. Regex execution
///    happens ONLY in the parser layer (RegexExtractor / RuleMatcher).
///  - Structural validity (e.g. "a regex rule must have a pattern")
///    is enforced by the create/update usecases and the rule loader —
///    not by the entity itself.
///
/// Pure domain: no Flutter, no Supabase, no serialization here —
/// wire mapping lives in `ParserRuleModel` (data layer, Phase 03+).
class ParserRule extends Equatable {
  const ParserRule({
    required this.id,
    required this.bankId,
    required this.field,
    required this.ruleType,
    required this.priority,
    required this.isRequired,
    required this.isActive,
    required this.validation,
    required this.createdAt,
    required this.updatedAt,
    this.pattern,
    this.extractionGroup = 0,
    this.keywords = const <String>[],
  });

  /// Stable unique identifier (backend id for synced rules).
  final String id;

  /// Owning bank — [Bank.id]. Rules of a bank are executed as an
  /// ordered set by the ConfigurableBankParser.
  final String bankId;

  /// Target transaction field this rule extracts/classifies.
  final ParserRuleField field;

  /// HOW the rule produces a value (regex extraction vs keyword
  /// classification).
  final ParserRuleType ruleType;

  /// Regex source pattern — REQUIRED when [ruleType] is
  /// [ParserRuleType.regex], unused for keyword rules.
  /// Stored as-is; compiled only inside the parser layer.
  final String? pattern;

  /// Index of the capturing group to extract — regex rules only.
  /// `0` means the whole match. Keyword rules ignore it.
  final int extractionGroup;

  /// Keyword list — the matching source for keyword rules (e.g.
  /// transaction-type classification) and an OPTIONAL positive
  /// pre-filter for regex rules. Comparison itself happens in
  /// RuleMatcher (Phase 07), never here.
  final List<String> keywords;

  /// Execution order — LOWER value runs FIRST.
  /// Ties are broken by [id] ascending so execution is fully
  /// DETERMINISTIC (no config-order or hash-order luck).
  final int priority;

  /// Whether a failed/missing extraction from this rule FAILS the
  /// whole parse for the message. Non-required rules only affect
  /// confidence (missing field warning) — never hard-fail.
  final bool isRequired;

  /// Whether the rule participates in parsing at all.
  /// Disabling keeps the definition for rollback/history.
  final bool isActive;

  /// Typed validation & classification config applied to the
  /// extracted value — see [ParserRuleValidation].
  final ParserRuleValidation validation;

  /// When this rule was created (UTC).
  final DateTime createdAt;

  /// When this rule was last updated (UTC) — config sync time.
  final DateTime updatedAt;

  /// Returns a copy with the provided fields replaced.
  ///
  /// NOTE: `null` arguments keep the current value (standard
  /// copyWith semantics). Lists are replaced wholesale, never merged.
  ParserRule copyWith({
    String? id,
    String? bankId,
    ParserRuleField? field,
    ParserRuleType? ruleType,
    String? pattern,
    int? extractionGroup,
    List<String>? keywords,
    int? priority,
    bool? isRequired,
    bool? isActive,
    ParserRuleValidation? validation,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ParserRule(
      id: id ?? this.id,
      bankId: bankId ?? this.bankId,
      field: field ?? this.field,
      ruleType: ruleType ?? this.ruleType,
      pattern: pattern ?? this.pattern,
      extractionGroup: extractionGroup ?? this.extractionGroup,
      keywords: keywords ?? this.keywords,
      priority: priority ?? this.priority,
      isRequired: isRequired ?? this.isRequired,
      isActive: isActive ?? this.isActive,
      validation: validation ?? this.validation,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => <Object?>[
        id,
        bankId,
        field,
        ruleType,
        pattern,
        extractionGroup,
        // Equatable performs deep list comparison.
        keywords,
        priority,
        isRequired,
        isActive,
        validation,
        createdAt,
        updatedAt,
      ];
}

/// Target field a [ParserRule] produces — mirrors the extractor set
/// of the parser engine (Phase 07).
enum ParserRuleField {
  /// Transaction amount — AmountExtractor.
  amount('amount'),

  /// Post-transaction balance — BalanceExtractor.
  balance('balance'),

  /// Card number (stored masked downstream) — CardExtractor.
  cardNumber('card_number'),

  /// Account number — CardExtractor/AccountExtractor.
  accountNumber('account_number'),

  /// Bank reference number — ReferenceExtractor.
  referenceNumber('reference_number'),

  /// Bank trace/track number — ReferenceExtractor.
  traceNumber('trace_number'),

  /// Transaction date/time — DateExtractor.
  date('date'),

  /// Transaction type classification — KeywordClassifier.
  transactionType('transaction_type');

  const ParserRuleField(this.wireName);

  /// Stable wire/serialization name — never rename existing values.
  final String wireName;

  /// Parses a serialized field name.
  ///
  /// STRICT — returns `null` for unknown values instead of a
  /// fallback: a rule that targets an unknown field is INVALID data
  /// and must be surfaced (quarantined + logged by the loader),
  /// never silently remapped to another field.
  static ParserRuleField? fromName(String? name) {
    if (name == null) {
      return null;
    }
    for (final ParserRuleField field in ParserRuleField.values) {
      if (field.wireName == name) {
        return field;
      }
    }
    return null;
  }
}

/// HOW a [ParserRule] produces its value.
enum ParserRuleType {
  /// Value extracted via [ParserRule.pattern] regex + capturing
  /// group — executed ONLY by RegexExtractor (Phase 07).
  regex('regex'),

  /// Value classified by matching [ParserRule.keywords] against the
  /// message, resolved through [ParserRuleValidation.valueMap] —
  /// executed by KeywordClassifier (Phase 07).
  keyword('keyword');

  const ParserRuleType(this.wireName);

  /// Stable wire/serialization name — never rename existing values.
  final String wireName;

  /// Parses a serialized rule type.
  ///
  /// STRICT — returns `null` for unknown values instead of a
  /// fallback: an unknown rule type cannot be executed safely, so
  /// the rule must be quarantined by the loader, not guessed.
  static ParserRuleType? fromName(String? name) {
    if (name == null) {
      return null;
    }
    for (final ParserRuleType type in ParserRuleType.values) {
      if (type.wireName == name) {
        return type;
      }
    }
    return null;
  }
}

/// Typed validation & classification config applied to the value a
/// rule extracts — the domain shape of the `validation_config` column.
///
/// All constraints are OPTIONAL; `ParserRuleValidation.empty` means
/// "no extra validation". Applying these constraints happens in the
/// parser layer (Phase 07) — this class is pure data.
///
/// Serialization to/from JSON belongs to the data layer
/// (`ParserRuleModel`), keeping the domain free of wire concerns.
class ParserRuleValidation extends Equatable {
  const ParserRuleValidation({
    this.minLength,
    this.maxLength,
    this.allowedValues,
    this.valueMap,
  });

  /// No-op validation — used when a rule needs no extra checks.
  static const ParserRuleValidation empty = ParserRuleValidation();

  /// Minimum acceptable LENGTH of the extracted value (characters).
  final int? minLength;

  /// Maximum acceptable LENGTH of the extracted value (characters).
  final int? maxLength;

  /// The extracted value must be one of these — e.g. reference
  /// formats, or the canonical type names for regex-typed TYPE rules.
  final List<String>? allowedValues;

  /// Canonical value mapping for keyword classification —
  /// e.g. `{'واریز': 'deposit', 'برداشت': 'withdrawal'}`.
  /// Matched keyword -> final field value. A keyword with no entry
  /// fails validation for keyword rules.
  final Map<String, String>? valueMap;

  @override
  List<Object?> get props => <Object?>[
        minLength,
        maxLength,
        // Equatable performs deep collection comparison.
        allowedValues,
        valueMap,
      ];
}