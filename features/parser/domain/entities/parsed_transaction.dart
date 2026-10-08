import 'package:equatable/equatable.dart';

import 'package:datadadtesms/features/banks/domain/entities/parser_rule.dart';
import 'package:datadadtesms/features/parser/domain/entities/parser_confidence.dart';
import 'package:datadadtesms/features/transactions/domain/entities/currency.dart';
import 'package:datadadtesms/features/transactions/domain/entities/transaction_type.dart';

/// Extraction output of ONE parse run — parser domain entity.
///
/// Contract locked in Phase 02 (consumed by Phase 08
/// ProcessTransactionUseCase → TransactionMapper → Transaction):
///
/// AMOUNT: [amount] is a NON-NEGATIVE INTEGER in the SMALLEST unit
/// of [currency] — for this product, rials. Toman mentions in bank
/// SMS ('تومان') are converted to rials by AmountExtractor (Phase 07)
/// using a DOCUMENTED multiplier (×10); the entity never receives a
/// half-unit value. No sign lives on the amount: the SIGN of the
/// movement is implied by [type] (deposit/withdrawal/...) — never
/// duplicate truth in two places.
///
/// MASKING: [cardNumberMasked] is already-masked at the EXTRACTION
/// boundary (CardExtractor, Phase 07) — this entity never carries a
/// full PAN anywhere, so no downstream layer can leak it:
///   `'6037********1234'` (head 4 + 12 stars + tail 4).
/// The FULL card never exists past the parser layer. [accountNumber]
/// stays plain: bank SMS never include sensitive PANs in accounts,
/// and display/audits show it as-is.
///
/// REFERENCES: [referenceNumber] / [traceNumber] are opaque bank
/// strings — preserved EXACTLY as extracted (leading zeros matter!
/// comparisons and the API payload must never trim/pad them).
///
/// BALANCE: [balance] is the post-transaction balance extracted from
/// the message — nullable when the SMS format has none.
///
/// TIMESTAMPS: [timestamp] is the transaction time extracted from
/// the message body. When no date/time is extractable,
/// DateExtractor falls back to the SMS receive time and raises
/// `timestampFallback` on the confidence warnings — the value here
/// is ALWAYS usable, never null, by design.
///
/// PROVENANCE: [parserVersion] / [sourceSmsHash] / [sourceMessageId]
/// tie this parse back to the exact rule set version and message it
/// came from — the audit chain (Phase 04/15) and the API payload
/// (`source_sms_hash`, Phase 09) consume these.
///
/// Pure domain: no Flutter, no Supabase, no serialization here —
/// wire mapping lives in `ParsedTransactionModel` (data layer).
class ParsedTransaction extends Equatable {
  const ParsedTransaction({
    required this.bankCode,
    required this.bankName,
    required this.type,
    required this.amount,
    required this.currency,
    required this.timestamp,
    required this.confidenceScore,
    required this.parserVersion,
    required this.sourceSmsHash,
    required this.sourceMessageId,
    this.cardNumberMasked,
    this.accountNumber,
    this.referenceNumber,
    this.traceNumber,
    this.balance,
  });

  /// Stable wire code of the detected bank — [Bank.code].
  /// Detection itself is BankDetector's job (Phase 07); the parse
  /// output simply carries the resolved bank.
  final String bankCode;

  /// Display name of the bank — [Bank.name] (config data, not l10n).
  final String bankName;

  /// Classified transaction type — [TransactionType.unknown] on
  /// ambiguous classification (never a guess).
  final TransactionType type;

  /// Amount in the smallest unit of [currency] (rials for IRR).
  /// Non-negative integer; sign is implied by [type].
  final int amount;

  /// Monetary unit — [Currency.irr] unless a rule says otherwise.
  final Currency currency;

  /// Transaction time from the message body (or receive-time
  /// fallback — see the class doc comment). UTC.
  final DateTime timestamp;

  /// Already-masked card — `'6037********1234'` or null when the
  /// message has no card. See the masking contract in the class doc
  /// comment.
  final String? cardNumberMasked;

  /// Account number as extracted — plain, preserved verbatim.
  final String? accountNumber;

  /// Bank reference — opaque string, verbatim (leading zeros kept).
  final String? referenceNumber;

  /// Bank trace/track number — opaque string, verbatim.
  final String? traceNumber;

  /// Post-transaction balance from the message, smallest unit of
  /// [currency]. Null when the SMS format carries no balance.
  final int? balance;

  /// Deterministic parse score `0.0..1.0` (the number that flows to
  /// the Transaction row and API payload).
  final double confidenceScore;

  /// Version tag of the exact rule set / dedicated parser that
  /// produced this parse — the parser-config audit chain.
  final String parserVersion;

  /// SHA-256 hex of the source SMS — [SmsMessage.bodyHash]. The
  /// `source_sms_hash` of the API payload; raw body never travels.
  final String sourceSmsHash;

  /// Id of the SMS row this parse came from — the `sms_id` FK the
  /// Transaction will carry.
  final String sourceMessageId;

  /// Returns a copy with the provided fields replaced.
  ///
  /// NOTE: `null` arguments KEEP the current value — this entity
  /// never needs to clear an extracted field back to null, so
  /// standard copyWith semantics are sufficient.
  ParsedTransaction copyWith({
    String? bankCode,
    String? bankName,
    TransactionType? type,
    int? amount,
    Currency? currency,
    DateTime? timestamp,
    String? cardNumberMasked,
    String? accountNumber,
    String? referenceNumber,
    String? traceNumber,
    int? balance,
    double? confidenceScore,
    String? parserVersion,
    String? sourceSmsHash,
    String? sourceMessageId,
  }) {
    return ParsedTransaction(
      bankCode: bankCode ?? this.bankCode,
      bankName: bankName ?? this.bankName,
      type: type ?? this.type,
      amount: amount ?? this.amount,
      currency: currency ?? this.currency,
      timestamp: timestamp ?? this.timestamp,
      cardNumberMasked: cardNumberMasked ?? this.cardNumberMasked,
      accountNumber: accountNumber ?? this.accountNumber,
      referenceNumber: referenceNumber ?? this.referenceNumber,
      traceNumber: traceNumber ?? this.traceNumber,
      balance: balance ?? this.balance,
      confidenceScore: confidenceScore ?? this.confidenceScore,
      parserVersion: parserVersion ?? this.parserVersion,
      sourceSmsHash: sourceSmsHash ?? this.sourceSmsHash,
      sourceMessageId: sourceMessageId ?? this.sourceMessageId,
    );
  }

  @override
  List<Object?> get props => <Object?>[
        bankCode,
        bankName,
        type,
        amount,
        currency,
        timestamp,
        cardNumberMasked,
        accountNumber,
        referenceNumber,
        traceNumber,
        balance,
        confidenceScore,
        parserVersion,
        sourceSmsHash,
        sourceMessageId,
      ];
}