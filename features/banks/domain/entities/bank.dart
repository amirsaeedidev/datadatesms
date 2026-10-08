import 'package:equatable/equatable.dart';

/// Bank entity — banks domain.
///
/// Contract locked in Phase 02:
///  - Banks are DATA-DRIVEN, not hardcoded enums: "adding a new bank
///    must not require rewriting UI / Matching / Registry".
///    A bank is a config record synced from backend and cached locally.
///  - [code] is the stable wire contract (`bank_code` in API DTOs and
///    the key used by BankParserRegistry in Phase 07).
///  - [parserType] decides HOW this bank gets parsed (RULE-012):
///    dedicated parser class vs configurable rule set.
///  - Sender phone numbers do NOT live here — [BankSender] owns them.
///    [detectionKeywords] is only the body-text fallback for the
///    BankDetector when the sender is unknown.
///
/// Pure domain: no Flutter, no Supabase, no serialization here —
/// wire mapping lives in `BankModel` (data layer, Phase 03+).
class Bank extends Equatable {
  const Bank({
    required this.id,
    required this.code,
    required this.name,
    required this.parserType,
    required this.isEnabled,
    required this.detectionKeywords,
    required this.createdAt,
    required this.updatedAt,
    this.parserVersion,
  });

  /// Stable unique identifier (backend id for synced banks).
  final String id;

  /// Stable wire code — e.g. 'MELLAT', 'MELLI', 'SAMAN', 'PASARGAD'.
  /// Used in: API `bank_code` field, parser registry lookup, audit
  /// metadata. Case-sensitive uppercase convention; never rename.
  final String code;

  /// Display name from bank config (e.g. 'بانک ملت').
  /// Config-driven data — NOT an l10n key: bank names arrive with the
  /// bank record itself.
  final String name;

  /// How this bank is parsed (see [BankParserType]).
  final BankParserType parserType;

  /// Whether the app processes SMS for this bank at all.
  /// Disable/enable flows only through UseCases (Phase 11 BankProvider).
  final bool isEnabled;

  /// Version tag of the active parser (dedicated parser version or
  /// parser-rule-set version). Nullable — a bank may not have a
  /// parser configured yet. Displayed on the Banks screen; used for
  /// versioned rollback of parser configs.
  final String? parserVersion;

  /// Body-text keywords the BankDetector uses as a FALLBACK when the
  /// sender number is not registered (e.g. 'ملت', 'Mellat').
  /// Detection never guesses randomly — ambiguity resolves to unknown.
  final List<String> detectionKeywords;

  /// When this bank record was created (UTC).
  final DateTime createdAt;

  /// When this bank record was last updated (UTC) — config sync time.
  final DateTime updatedAt;

  /// Returns a copy with the provided fields replaced.
  ///
  /// NOTE: `null` arguments keep the current value (standard
  /// copyWith semantics). Lists are replaced wholesale, never merged.
  Bank copyWith({
    String? id,
    String? code,
    String? name,
    BankParserType? parserType,
    bool? isEnabled,
    String? parserVersion,
    List<String>? detectionKeywords,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Bank(
      id: id ?? this.id,
      code: code ?? this.code,
      name: name ?? this.name,
      parserType: parserType ?? this.parserType,
      isEnabled: isEnabled ?? this.isEnabled,
      parserVersion: parserVersion ?? this.parserVersion,
      detectionKeywords: detectionKeywords ?? this.detectionKeywords,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => <Object?>[
        id,
        code,
        name,
        parserType,
        isEnabled,
        parserVersion,
        // Equatable performs deep list comparison.
        detectionKeywords,
        createdAt,
        updatedAt,
      ];
}

/// How a bank's SMS gets parsed — RULE-012 (two official modes).
enum BankParserType {
  /// Bank has a dedicated parser class (e.g. MellatParser) — for
  /// banks with very specific SMS structure.
  dedicated('dedicated'),

  /// Bank is parsed by [ParserRule]s through ConfigurableBankParser —
  /// for banks whose format is rule-coverable.
  configurable('configurable');

  const BankParserType(this.wireName);

  /// Stable wire/serialization name — never rename existing values.
  final String wireName;

  /// Parses a serialized parser type.
  ///
  /// SECURITY/ROBUSTNESS: unknown values fall back to [fallback]
  /// (default [BankParserType.configurable]) — the generic safe path.
  /// An unrecognized type must never crash the parser pipeline.
  static BankParserType fromName(
    String? name, {
    BankParserType fallback = BankParserType.configurable,
  }) {
    if (name == null) {
      return fallback;
    }
    for (final BankParserType type in BankParserType.values) {
      if (type.wireName == name) {
        return type;
      }
    }
    return fallback;
  }
}