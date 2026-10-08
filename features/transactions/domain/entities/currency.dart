/// Canonical currency vocabulary — transactions domain enum.
///
/// SHARED VOCABULARY (contract locked in Phase 02): the single source
/// of truth for the monetary unit of an amount, consumed by:
///  - parser       — AmountExtractor pairs extracted numbers with a
///                   currency onto ParsedTransaction (Phase 07).
///  - transactions — Transaction / PendingTransaction carry it as a
///                   field (Step 02.5).
///  - API DTO      — serialized as `"currency"` in the payload
///                   (Phase 09).
///
/// All bank SMS amounts are integer units of the local currency
/// (rials/tomans are ALWAYS normalized to IRR at the parser layer —
/// see the amount contract on ParsedTransaction); this enum exists
/// for cross-currency correctness and auditability, not for a
/// converter.
///
/// Pure Dart — no Flutter, no Supabase SDK, fully unit-testable.
enum Currency {
  /// Iranian rial — THE default for this product (bank SMS are rial
  /// by default; toman mentions get converted at the parser layer
  /// with a documented rule).
  irr('IRR'),

  /// US dollar — reserved for future non-rial flows.
  usd('USD'),

  /// Euro — reserved for future non-rial flows.
  eur('EUR');

  const Currency(this.wireName);

  /// Stable wire/serialization name — persisted in the local DB,
  /// sent as `"currency"` in the API payload. Uppercase ISO-4217
  /// style. Never rename existing values.
  final String wireName;

  /// Parses a serialized currency code coming from local storage,
  /// API responses, or parser rule configs.
  ///
  /// LENIENT BY DESIGN — an unrecognized value falls back to
  /// [Currency.irr]:
  ///  - `IRR` is the product default and any bank SMS amount in this
  ///    product is rial-denominated by contract; degrading an unknown
  ///    code to the default loses NO truth (the raw amount stays
  ///    untouched) — unlike a wrong concrete remap which would
  ///    silently misrepresent the money unit.
  ///  - Currency codes from a NEWER app version degrade gracefully on
  ///    older versions.
  ///
  /// SECURITY NOTE: this leniency is acceptable ONLY because the
  /// product processes a single-currency domain (IRR) today. The day
  /// real multi-currency lands, this fallback must become STRICT
  /// (null + quarantine) — a wrong unit on a real amount is a
  /// financial integrity risk. That migration note is deliberate and
  /// lives here as the contract's guard.
  static Currency fromName(
    String? name, {
    Currency fallback = Currency.irr,
  }) {
    if (name == null) {
      return fallback;
    }
    for (final Currency currency in Currency.values) {
      if (currency.wireName == name) {
        return currency;
      }
    }
    return fallback;
  }
}