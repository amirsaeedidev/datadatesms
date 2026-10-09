// Logs-domain re-export of the technical log event — dual-home
// contract (Phase 02): canonical definition lives in core/logging;
// this namespace keeps features/logs structurally complete without
// owning the definition. Re-export only — never drift.
export 'package:datadadtesms/core/logging/log_event.dart'
    show LogEvent, StackTraceData;