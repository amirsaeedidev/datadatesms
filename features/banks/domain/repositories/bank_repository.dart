import 'package:datadadtesms/features/banks/domain/entities/bank.dart';
import 'package:datadadtesms/features/banks/domain/entities/bank_sender.dart';
import 'package:datadadtesms/features/banks/domain/entities/parser_rule.dart';

/// Persistence contract of ALL bank configuration — banks domain
/// repository (abstract interface; the Drift-backed implementation
/// lives in `banks/data/repositories/bank_repository_impl.dart` and
/// lands with its feature phase).
///
/// OWNERSHIP DECISION (locked in Phase 03 Step 03.6): this ONE
/// repository owns the three config tables — banks, bank_senders,
/// parser_rules — because they sync TOGETHER as one backend config
/// bundle (the SyncBankConfigs usecase) and share one data-layer
/// model set (`banks/data/models`). The parser feature's rule-CRUD
/// usecases (create/delete/get/update_parser_rule) consume THIS
/// interface — the cross-feature direction `parser/domain →
/// banks/domain` was already sanctioned in Phase 02 (ParserRuleField
/// vocabulary) and stays one-way and acyclic.
///
/// TWO WRITE SHAPES — deliberate:
///  - `upsert*` (bulk) — BACKEND SYNC: replace/merge what arrived;
///    idempotent by entity id. Used by SyncBankConfigs.
///  - `update*` / `saveRule` (single) — LOCAL mutations (enable/
///    disable a bank or sender, edit a rule) from the review flows.
///
/// ERROR CONTRACT (Phase 04 will implement; signatures are FINAL):
/// implementations THROW typed exceptions (DatabaseException family,
/// core/errors) — repository methods return plain data, and the
/// USECASE layer of each feature wraps them into Result/Failure for
/// providers. That is why no Either/Failure type appears here:
/// signatures must not change when Phase 04 lands.
///
/// Pure domain: no Drift imports, no Table types — only entities.
/// That separation is the entire point of this interface (MD 03.6:
/// "Domain از Drift/SQLite جدا بماند").
abstract interface class BankRepository {
  // -------------------------------------------------------------------------
  // Banks
  // -------------------------------------------------------------------------

  /// All bank config rows (enabled AND disabled — the Banks screen
  /// shows the full list with toggles). Small table; consumers
  /// filter in memory.
  Future<List<Bank>> getBanks();

  /// One bank by id — null when absent (GetBank usecase).
  Future<Bank?> getBank(String id);

  /// One bank by its stable wire code (e.g. 'MELLAT') — the
  /// registry/resilience lookup. Null when absent.
  Future<Bank?> findByCode(String code);

  /// Bulk config sync from the backend — idempotent upserts keyed by
  /// entity id (SyncBankConfigs usecase).
  Future<void> upsertBanks(List<Bank> banks);

  /// Local single-row mutation (enable/disable, etc.) — persists the
  /// WHOLE entity (UpdateBank usecase).
  Future<void> updateBank(Bank bank);

  // -------------------------------------------------------------------------
  // Bank senders
  // -------------------------------------------------------------------------

  /// All senders, or only those of one bank. Null [bankId] = all.
  Future<List<BankSender>> getSenders({String? bankId});

  /// Only ENABLED senders — the deterministic input of BankDetector
  /// (Phase 07). Explicit contract because detection is the hot path
  /// of every incoming SMS.
  Future<List<BankSender>> getEnabledSenders();

  /// Bulk config sync from the backend — idempotent upserts.
  Future<void> upsertSenders(List<BankSender> senders);

  /// Local single-row mutation (per-sender enable/disable) —
  /// persists the WHOLE entity (UpdateSender usecase).
  Future<void> updateSender(BankSender sender);

  // -------------------------------------------------------------------------
  // Parser rules (config ownership — see the class doc comment)
  // -------------------------------------------------------------------------

  /// Rules of one bank — the ConfigurableBankParser's rule set
  /// (RuleMatcher, Phase 07). [activeOnly] filters to ACTIVE rules;
  /// the parser-test page (Phase 12) passes false to also see
  /// disabled ones.
  Future<List<ParserRule>> getRules({
    required String bankId,
    bool activeOnly = true,
  });

  /// Bulk config sync from the backend — idempotent upserts.
  Future<void> upsertRules(List<ParserRule> rules);

  /// Local single-rule upsert (create or edit via the rule editor) —
  /// keyed by id.
  Future<void> saveRule(ParserRule rule);

  /// Local rule removal (DeleteParserRule usecase). The backend
  /// remains the source of truth — the next config sync re-delivers
  /// whatever the backend still holds.
  Future<void> deleteRule(String id);
}