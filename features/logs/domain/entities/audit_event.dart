import 'package:equatable/equatable.dart';

import 'package:datadadtesms/core/logging/audit_event_type.dart';
import 'package:datadadtesms/features/auth/domain/entities/user_role.dart';

/// A FINANCIAL audit entry — logs domain entity.
///
/// THE FINANCIAL TRAIL (contract locked in Phase 02): what this
/// entity records is the STORY of money — every milestone of every
/// transaction, from the SMS landing until the standing settles and
/// the backend acknowledges. Complements technical [LogEvent]s
/// (network/db/parser errors — the two systems are disjoint, see the
/// LogEvent class doc comment). PRODUCED exclusively by AuditLogger
/// (Phase 04) on behalf of the pipeline usecases (06/07/08/10/11).
///
/// DUAL ANCHOR — the availability boundary is documented on
/// [AuditEventType] (transaction_created is the birth of the
/// transactionId anchor). This entity carries BOTH slots; at most
/// one is null in a VALID event:
///  - Pre-record events (sms_received → transaction_queued ... and
///    parse/validation failures) anchor on [smsId]; [transactionId]
///    null.
///  - Post-record events anchor on [transactionId]; [smsId] is STILL
///    CARRIED (the lineage thread back to the message) — only
///    context events without a record in scope (e.g. sync_started)
///    leave it null.
///
/// SECURITY (RULE: "Raw SMS در Log عادی ذخیره نشود" — for AUDIT even
/// stricter): [metadata] carries only SAFE references — message
/// hash, masked values, ids, versions, attempt numbers, reason wire
/// names. NEVER a raw SMS body, never an unmasked PAN/account. The
/// hash [smsHash] is the SAFE identity of the message in the trail —
/// audit never needs the body to tell the story.
///
/// ACTOR SPLIT: [actorRole] + optional [actorUserId] record WHO/WITH
/// WHAT AUTHORITY the event happened:
///  - SYSTEM events (the overwhelming majority — the pipeline just
///    does its job): actorRole [UserRole.viewer] as "the system"
///    convention... NO — see the actor enum below: actorRole uses
///    [AuditActorRole], a dedicated 2-value vocabulary, because
///    UserRole is about HUMAN permission tiers and conflating them
///    is a modeling error. actorUserId is null for system events.
///  - ADMIN events (review decisions: confirm/reject/approve-match):
///    actorRole admin + the acting user's id.
///
/// Pure domain: no Flutter, no Supabase, no serialization here —
/// wire mapping lives in `AuditEventModel` (data layer, Phase 03).
class AuditEvent extends Equatable {
  const AuditEvent({
    required this.id,
    required this.timestamp,
    required this.type,
    required this.deviceId,
    required this.appVersion,
    required this.actorRole,
    required this.smsId,
    this.transactionId,
    this.smsHash,
    this.actorUserId,
    this.metadata = const <String, Object?>{},
  });

  /// Local unique identifier (UUID v4) — assigned at emission time.
  final String id;

  /// When the event happened (UTC).
  final DateTime timestamp;

  /// Which milestone — [AuditEventType].
  final AuditEventType type;

  /// Device that produced the event — the `device_id` column every
  /// table in this product carries.
  final String deviceId;

  /// App version at emission time — anchors the audit trail to the
  /// exact build that produced each decision.
  final String appVersion;

  /// WHO/WHAT produced the event — see the actor split in the class
  /// doc comment.
  final AuditActorRole actorRole;

  /// The acting human user's id — null for system events.
  final String? actorUserId;

  /// Lineage slot 1 — the source SMS. Present on pre-record events;
  /// still carried post-record as the lineage thread. See the dual
  /// anchor contract in the class doc comment.
  final String? smsId;

  /// Lineage slot 2 — the financial record. Null until
  /// transaction_created (its birth). Post-record events carry it.
  final String? transactionId;

  /// SHA-256 of the source message — the SAFE identity reference.
  /// Null only for context events with no message in scope.
  final String? smsHash;

  /// Safe metadata map (security rule in the class doc comment):
  /// parserVersion, confidence, failure-reason wire names, attempt
  /// numbers, serverTransactionId, reviewer identity, competing
  /// candidate ids. snake_case keys, JSON-safe values.
  final Map<String, Object?> metadata;

  @override
  List<Object?> get props => <Object?>[
        id,
        timestamp,
        type,
        deviceId,
        appVersion,
        actorRole,
        actorUserId,
        smsId,
        transactionId,
        smsHash,
        // Equatable performs deep map comparison.
        metadata,
      ];
}

/// WHO/WHAT produced an audit event.
///
/// Deliberately SEPARATE from [UserRole]: UserRole is about HUMAN
/// permission tiers (admin/operator/viewer); the audit actor is
/// about SYSTEM-vs-ADMIN provenance. Reusing UserRole here would be
/// a modeling error — "system" is not a permission tier. (The import
/// of UserRole above is used ONLY by the doc discussion; if the
/// analyzer flags it, drop that import — the enum below is
/// self-contained.)
enum AuditActorRole {
  /// The automated pipeline — the overwhelming majority of events.
  /// actorUserId is null for these.
  system('system'),

  /// An authenticated human with review authority acting through
  /// the UI (confirm/reject/approve-match). actorUserId is set.
  admin('admin');

  const AuditActorRole(this.wireName);

  /// Stable wire/serialization name — persisted in the local DB and
  /// exchanged with the backend. Never rename existing values.
  final String wireName;

  /// Parses a serialized actor role coming from local storage or
  /// the backend.
  ///
  /// STRICT — returns `null` for unknown values (persisted standing
  /// vocabulary): a wrong actor remap FALSIFIES the audit trail —
  /// it would attribute a decision to the wrong authority.
  static AuditActorRole? fromName(String? name) {
    if (name == null) {
      return null;
    }
    for (final AuditActorRole role in AuditActorRole.values) {
      if (role.wireName == name) {
        return role;
      }
    }
    return null;
  }
}