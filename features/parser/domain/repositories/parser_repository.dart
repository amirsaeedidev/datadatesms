import 'package:datadadtesms/features/parser/domain/entities/parser_result.dart';
import 'package:datadadtesms/features/sms/domain/entities/sms_source.dart';

/// RAW test input crossing the parser-test boundary — what the
/// parser-test page (Phase 12) submits, before any normalization.
typedef RawParserInput = ({
  String sender,
  String body,
  DateTime receivedAt,
});

/// The engine-facing contract of the parser feature — parser domain
/// repository (abstract interface).
///
/// ROLE SEPARATION — the deliberate split of parser persistence
/// (locked here, Phase 03 Step 03.6):
///  - RULES (definitions) — BankRepository owns the parser_rules
///    table with the rest of the bank config bundle (the Phase 03.6
///    ownership decision; rule CRUD lands on THAT interface).
///  - EXECUTION (this interface) — parse/test/simulate. This
///    repository exposes the ParserEngine as a repository-shaped
///    surface so usecases stay uniform (UI → provider → usecase →
///    repository/engine), per the roadmap's ParserEngine block.
///
/// CONSUMERS (their usecases land with Phase 07/11/12):
///  - ParseSms        — the pipeline's single parse entry point
///  - TestParser      — sample-set regression runs
///  - SimulateParser  — live message simulation (no persistence side
///    effects AT ALL — the Phase 02.3 SmsSource lock: simulated
///    input is never persisted as an SmsMessage)
///
/// DETECTION BEFORE PARSE (the Phase 02.4 ParserResult contract):
/// bank detection happens BEFORE [parse] is called — the caller
/// (ProcessIncomingSmsUseCase) resolves the bank via BankDetector
/// and passes its codes in. A message with no resolved bank never
/// reaches [parse].
///
/// ERROR CONTRACT (same lock as BankRepository): implementations
/// THROW typed ParserException family (Phase 04) — signatures are
/// FINAL, no Result/Failure here; usecases wrap for providers.
///
/// Pure domain: no Drift, no RegExp compilation concerns, no
/// method-channel — the engine's internals (Phase 07) live behind
/// this surface.
abstract interface class ParserRepository {
  /// Runs the FULL parse pipeline for one bank's message:
  /// select parser (dedicated/configurable) → normalize (if the
  /// engine needs it — the engine owns normalization) → match rules
  /// → extract → validate → confidence → [ParserResult].
  ///
  /// [bankCode]/[bankName] identify the resolved bank (detection
  /// already happened — see the class doc comment). The returned
  /// ParserResult is one of its three frozen shapes (success /
  /// parseFailure / noParserConfigured).
  Future<ParserResult> parse({
    required String bankCode,
    required String bankName,
    required String sender,
    required String body,
    required DateTime receivedAt,
  });

  /// One-off SIMULATION against a live-typed message — identical
  /// pipeline to [parse], zero persistence side effects, and it may
  /// also run bank DETECTION internally to report "no bank detected"
  /// feedback (the parser-test page renders that case distinctly —
  /// the Phase 02.4 split).
  ///
  /// Returns null when NO enabled bank matches the input — the
  /// simulation's own detection outcome, distinct from a parse
  /// failure of a detected bank.
  Future<ParserResult?> simulate(RawParserInput input);

  /// Executes a rule-set regression: runs [simulate] against every
  /// sample of the bank's sample set and reports each
  /// pass/fail. The sample SET itself is part of the backend config
  /// bundle (Phase 07 defines its storage with the engine) — this
  /// method only executes.
  ///
  /// Sample shape and expected results are owned by the parser
  /// feature's entities (Phase 07); the return maps each sample to
  /// its outcome.
  Future<Map<String, ParserResult>> runSampleSet(String bankCode);
}