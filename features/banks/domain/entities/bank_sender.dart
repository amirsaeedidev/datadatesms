import 'package:equatable/equatable.dart';

/// Registered sender address of a bank — banks domain entity.
///
/// Contract locked in Phase 02:
///  - A [Bank] has ZERO or MORE senders (one row per number/shortcode).
///    This is the PRIMARY, deterministic input of BankDetector
///    (Phase 07): sender match -> bank. Keywords are only the fallback.
///  - [sender] stores the CANONICAL form: digits only for numeric
///    addresses ('98912...' with country code, NO '+', '00', or
///    leading zero), or lowercased alphanumeric sender IDs.
///    Normalization itself happens in MessageNormalizer (Phase 07) —
///    this entity only guarantees the storage contract.
///  - [matchType] decides how the canonical incoming sender is
///    compared: exact equality or prefix (for operator number ranges).
///  - Matching LOGIC lives in BankDetector (Phase 07) — this entity
///    is pure data, it does not match anything itself.
///
/// Pure domain: no Flutter, no Supabase, no serialization here —
/// wire mapping lives in `BankSenderModel` (data layer, Phase 03+).
class BankSender extends Equatable {
  const BankSender({
    required this.id,
    required this.bankId,
    required this.sender,
    required this.matchType,
    required this.isEnabled,
    required this.createdAt,
    required this.updatedAt,
    this.label,
  });

  /// Stable unique identifier (backend id for synced senders).
  final String id;

  /// Owning bank — [Bank.id]. A sender belongs to exactly one bank;
  /// ambiguity between banks is resolved by config data, never by
  /// guessing at runtime.
  final String bankId;

  /// Canonical sender address — e.g. '5004', '98300011',
  /// or lowercased alphanumeric IDs like 'samanbank'.
  final String sender;

  /// How an incoming sender address is compared against [sender].
  final BankSenderMatchType matchType;

  /// Whether this sender participates in detection. Allows disabling
  /// a single noisy number without touching the bank itself.
  final bool isEnabled;

  /// Optional human note (e.g. 'کارتابل ملت'). Displayed on the
  /// Banks screen; purely informational.
  final String? label;

  /// When this sender record was created (UTC).
  final DateTime createdAt;

  /// When this sender record was last updated (UTC).
  final DateTime updatedAt;

  /// Returns a copy with the provided fields replaced.
  ///
  /// NOTE: `null` arguments keep the current value (standard
  /// copyWith semantics).
  BankSender copyWith({
    String? id,
    String? bankId,
    String? sender,
    BankSenderMatchType? matchType,
    bool? isEnabled,
    String? label,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return BankSender(
      id: id ?? this.id,
      bankId: bankId ?? this.bankId,
      sender: sender ?? this.sender,
      matchType: matchType ?? this.matchType,
      isEnabled: isEnabled ?? this.isEnabled,
      label: label ?? this.label,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => <Object?>[
        id,
        bankId,
        sender,
        matchType,
        isEnabled,
        label,
        createdAt,
        updatedAt,
      ];
}

/// How an incoming sender address is compared to a registered
/// [BankSender.sender] — both in canonical form.
enum BankSenderMatchType {
  /// Sender must EQUAL the registered address exactly.
  /// The restrictive, preferred mode for stable shortcodes.
  exact('exact'),

  /// Registered address is a PREFIX of the incoming sender —
  /// for operator number ranges that share a common head.
  prefix('prefix');

  const BankSenderMatchType(this.wireName);

  /// Stable wire/serialization name — never rename existing values.
  final String wireName;

  /// Parses a serialized match type.
  ///
  /// ROBUSTNESS: unknown values fall back to [BankSenderMatchType.exact]
  /// — the most restrictive comparison, so bad config data can never
  /// widen detection (fewer false bank matches, never more).
  static BankSenderMatchType fromName(
    String? name, {
    BankSenderMatchType fallback = BankSenderMatchType.exact,
  }) {
    if (name == null) {
      return fallback;
    }
    for (final BankSenderMatchType type in BankSenderMatchType.values) {
      if (type.wireName == name) {
        return type;
      }
    }
    return fallback;
  }
}