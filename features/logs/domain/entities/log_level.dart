/// Logs-domain re-export of the log severity level — dual-home
/// contract (Phase 02, see LogLevel's NOTE):
///
/// The CANONICAL definition lives in core/logging (LogLevel) because
/// AppLogger (Phase 04) must be able to classify entries BEFORE any
/// feature exists — core cannot depend on features. This file exists
/// so the logs FEATURE's domain consumes the type through its OWN
/// namespace, keeping
/// `features/logs/domain/entities` structurally complete per the
/// project tree, WITHOUT owning the definition.
///
/// RULE: no logic, no duplication, no re-definition — re-export
/// only. Any change to LogLevel semantics happens in core; this
/// file must never drift.
export 'package:datadadtesms/core/logging/log_level.dart' show LogLevel;