// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $BanksTableTable extends BanksTable
    with TableInfo<$BanksTableTable, BanksTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BanksTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: () => '',
  );
  static const VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<String> code = GeneratedColumn<String>(
    'code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _parserTypeMeta = const VerificationMeta(
    'parserType',
  );
  @override
  late final GeneratedColumn<String> parserType = GeneratedColumn<String>(
    'parser_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isEnabledMeta = const VerificationMeta(
    'isEnabled',
  );
  @override
  late final GeneratedColumn<bool> isEnabled = GeneratedColumn<bool>(
    'is_enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_enabled" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _parserVersionMeta = const VerificationMeta(
    'parserVersion',
  );
  @override
  late final GeneratedColumn<String> parserVersion = GeneratedColumn<String>(
    'parser_version',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _detectionKeywordsMeta = const VerificationMeta(
    'detectionKeywords',
  );
  @override
  late final GeneratedColumn<String> detectionKeywords =
      GeneratedColumn<String>(
        'detection_keywords',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant('[]'),
      );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    code,
    name,
    parserType,
    isEnabled,
    parserVersion,
    detectionKeywords,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'banks';
  @override
  VerificationContext validateIntegrity(
    Insertable<BanksTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('code')) {
      context.handle(
        _codeMeta,
        code.isAcceptableOrUnknown(data['code']!, _codeMeta),
      );
    } else if (isInserting) {
      context.missing(_codeMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('parser_type')) {
      context.handle(
        _parserTypeMeta,
        parserType.isAcceptableOrUnknown(data['parser_type']!, _parserTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_parserTypeMeta);
    }
    if (data.containsKey('is_enabled')) {
      context.handle(
        _isEnabledMeta,
        isEnabled.isAcceptableOrUnknown(data['is_enabled']!, _isEnabledMeta),
      );
    }
    if (data.containsKey('parser_version')) {
      context.handle(
        _parserVersionMeta,
        parserVersion.isAcceptableOrUnknown(
          data['parser_version']!,
          _parserVersionMeta,
        ),
      );
    }
    if (data.containsKey('detection_keywords')) {
      context.handle(
        _detectionKeywordsMeta,
        detectionKeywords.isAcceptableOrUnknown(
          data['detection_keywords']!,
          _detectionKeywordsMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BanksTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BanksTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      code: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}code'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      parserType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}parser_type'],
      )!,
      isEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_enabled'],
      )!,
      parserVersion: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}parser_version'],
      ),
      detectionKeywords: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}detection_keywords'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $BanksTableTable createAlias(String alias) {
    return $BanksTableTable(attachedDatabase, alias);
  }
}

class BanksTableData extends DataClass implements Insertable<BanksTableData> {
  /// Primary key — [Bank.id], the stable backend identifier.
  /// TEXT because bank rows are backend-authored (their UUIDs).
  /// Not auto-increment: config rows arrive with ids, never
  /// generated locally.
  final String id;

  /// Stable wire code ('MELLAT', 'MELLI', ...) — [Bank.code].
  /// Unique: two banks sharing a code would corrupt parser-registry
  /// lookup (one bank per code, by contract).
  final String code;

  /// Display name snapshot — [Bank.name]. Plain TEXT; Persian
  /// names stored/compared as-is (no case folding).
  final String name;

  /// Wire name of BankParserType ('dedicated' | 'configurable') —
  /// persisted as TEXT; model layer marshals the enum. Deliberately
  /// NOT an int-mapped enum: wire values arrive from backend sync.
  final String parserType;

  /// Whether the app processes SMS for this bank — [Bank.isEnabled].
  final bool isEnabled;

  /// Parser version tag — [Bank.parserVersion]. Nullable 1:1.
  final String? parserVersion;

  /// Detection keywords — [Bank.detectionKeywords] as a JSON array
  /// string ('["ملت","Mellat"]'). Empty array = no keyword fallback;
  /// NOT null (the entity's list is always present, possibly empty).
  final String detectionKeywords;

  /// Creation time (UTC) — [Bank.createdAt].
  final DateTime createdAt;

  /// Last-config-update time (UTC) — [Bank.updatedAt].
  final DateTime updatedAt;
  const BanksTableData({
    required this.id,
    required this.code,
    required this.name,
    required this.parserType,
    required this.isEnabled,
    this.parserVersion,
    required this.detectionKeywords,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['code'] = Variable<String>(code);
    map['name'] = Variable<String>(name);
    map['parser_type'] = Variable<String>(parserType);
    map['is_enabled'] = Variable<bool>(isEnabled);
    if (!nullToAbsent || parserVersion != null) {
      map['parser_version'] = Variable<String>(parserVersion);
    }
    map['detection_keywords'] = Variable<String>(detectionKeywords);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  BanksTableCompanion toCompanion(bool nullToAbsent) {
    return BanksTableCompanion(
      id: Value(id),
      code: Value(code),
      name: Value(name),
      parserType: Value(parserType),
      isEnabled: Value(isEnabled),
      parserVersion: parserVersion == null && nullToAbsent
          ? const Value.absent()
          : Value(parserVersion),
      detectionKeywords: Value(detectionKeywords),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory BanksTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BanksTableData(
      id: serializer.fromJson<String>(json['id']),
      code: serializer.fromJson<String>(json['code']),
      name: serializer.fromJson<String>(json['name']),
      parserType: serializer.fromJson<String>(json['parserType']),
      isEnabled: serializer.fromJson<bool>(json['isEnabled']),
      parserVersion: serializer.fromJson<String?>(json['parserVersion']),
      detectionKeywords: serializer.fromJson<String>(json['detectionKeywords']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'code': serializer.toJson<String>(code),
      'name': serializer.toJson<String>(name),
      'parserType': serializer.toJson<String>(parserType),
      'isEnabled': serializer.toJson<bool>(isEnabled),
      'parserVersion': serializer.toJson<String?>(parserVersion),
      'detectionKeywords': serializer.toJson<String>(detectionKeywords),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  BanksTableData copyWith({
    String? id,
    String? code,
    String? name,
    String? parserType,
    bool? isEnabled,
    Value<String?> parserVersion = const Value.absent(),
    String? detectionKeywords,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => BanksTableData(
    id: id ?? this.id,
    code: code ?? this.code,
    name: name ?? this.name,
    parserType: parserType ?? this.parserType,
    isEnabled: isEnabled ?? this.isEnabled,
    parserVersion: parserVersion.present
        ? parserVersion.value
        : this.parserVersion,
    detectionKeywords: detectionKeywords ?? this.detectionKeywords,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  BanksTableData copyWithCompanion(BanksTableCompanion data) {
    return BanksTableData(
      id: data.id.present ? data.id.value : this.id,
      code: data.code.present ? data.code.value : this.code,
      name: data.name.present ? data.name.value : this.name,
      parserType: data.parserType.present
          ? data.parserType.value
          : this.parserType,
      isEnabled: data.isEnabled.present ? data.isEnabled.value : this.isEnabled,
      parserVersion: data.parserVersion.present
          ? data.parserVersion.value
          : this.parserVersion,
      detectionKeywords: data.detectionKeywords.present
          ? data.detectionKeywords.value
          : this.detectionKeywords,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BanksTableData(')
          ..write('id: $id, ')
          ..write('code: $code, ')
          ..write('name: $name, ')
          ..write('parserType: $parserType, ')
          ..write('isEnabled: $isEnabled, ')
          ..write('parserVersion: $parserVersion, ')
          ..write('detectionKeywords: $detectionKeywords, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    code,
    name,
    parserType,
    isEnabled,
    parserVersion,
    detectionKeywords,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BanksTableData &&
          other.id == this.id &&
          other.code == this.code &&
          other.name == this.name &&
          other.parserType == this.parserType &&
          other.isEnabled == this.isEnabled &&
          other.parserVersion == this.parserVersion &&
          other.detectionKeywords == this.detectionKeywords &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class BanksTableCompanion extends UpdateCompanion<BanksTableData> {
  final Value<String> id;
  final Value<String> code;
  final Value<String> name;
  final Value<String> parserType;
  final Value<bool> isEnabled;
  final Value<String?> parserVersion;
  final Value<String> detectionKeywords;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const BanksTableCompanion({
    this.id = const Value.absent(),
    this.code = const Value.absent(),
    this.name = const Value.absent(),
    this.parserType = const Value.absent(),
    this.isEnabled = const Value.absent(),
    this.parserVersion = const Value.absent(),
    this.detectionKeywords = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BanksTableCompanion.insert({
    this.id = const Value.absent(),
    required String code,
    required String name,
    required String parserType,
    this.isEnabled = const Value.absent(),
    this.parserVersion = const Value.absent(),
    this.detectionKeywords = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : code = Value(code),
       name = Value(name),
       parserType = Value(parserType),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<BanksTableData> custom({
    Expression<String>? id,
    Expression<String>? code,
    Expression<String>? name,
    Expression<String>? parserType,
    Expression<bool>? isEnabled,
    Expression<String>? parserVersion,
    Expression<String>? detectionKeywords,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (code != null) 'code': code,
      if (name != null) 'name': name,
      if (parserType != null) 'parser_type': parserType,
      if (isEnabled != null) 'is_enabled': isEnabled,
      if (parserVersion != null) 'parser_version': parserVersion,
      if (detectionKeywords != null) 'detection_keywords': detectionKeywords,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BanksTableCompanion copyWith({
    Value<String>? id,
    Value<String>? code,
    Value<String>? name,
    Value<String>? parserType,
    Value<bool>? isEnabled,
    Value<String?>? parserVersion,
    Value<String>? detectionKeywords,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return BanksTableCompanion(
      id: id ?? this.id,
      code: code ?? this.code,
      name: name ?? this.name,
      parserType: parserType ?? this.parserType,
      isEnabled: isEnabled ?? this.isEnabled,
      parserVersion: parserVersion ?? this.parserVersion,
      detectionKeywords: detectionKeywords ?? this.detectionKeywords,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (parserType.present) {
      map['parser_type'] = Variable<String>(parserType.value);
    }
    if (isEnabled.present) {
      map['is_enabled'] = Variable<bool>(isEnabled.value);
    }
    if (parserVersion.present) {
      map['parser_version'] = Variable<String>(parserVersion.value);
    }
    if (detectionKeywords.present) {
      map['detection_keywords'] = Variable<String>(detectionKeywords.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BanksTableCompanion(')
          ..write('id: $id, ')
          ..write('code: $code, ')
          ..write('name: $name, ')
          ..write('parserType: $parserType, ')
          ..write('isEnabled: $isEnabled, ')
          ..write('parserVersion: $parserVersion, ')
          ..write('detectionKeywords: $detectionKeywords, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $BankSendersTableTable extends BankSendersTable
    with TableInfo<$BankSendersTableTable, BankSendersTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BankSendersTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: () => '',
  );
  static const VerificationMeta _bankIdMeta = const VerificationMeta('bankId');
  @override
  late final GeneratedColumn<String> bankId = GeneratedColumn<String>(
    'bank_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES banks (id) ON DELETE RESTRICT',
    ),
  );
  static const VerificationMeta _senderMeta = const VerificationMeta('sender');
  @override
  late final GeneratedColumn<String> sender = GeneratedColumn<String>(
    'sender',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _matchTypeMeta = const VerificationMeta(
    'matchType',
  );
  @override
  late final GeneratedColumn<String> matchType = GeneratedColumn<String>(
    'match_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isEnabledMeta = const VerificationMeta(
    'isEnabled',
  );
  @override
  late final GeneratedColumn<bool> isEnabled = GeneratedColumn<bool>(
    'is_enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_enabled" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _labelMeta = const VerificationMeta('label');
  @override
  late final GeneratedColumn<String> label = GeneratedColumn<String>(
    'label',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    bankId,
    sender,
    matchType,
    isEnabled,
    label,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'bank_senders';
  @override
  VerificationContext validateIntegrity(
    Insertable<BankSendersTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('bank_id')) {
      context.handle(
        _bankIdMeta,
        bankId.isAcceptableOrUnknown(data['bank_id']!, _bankIdMeta),
      );
    } else if (isInserting) {
      context.missing(_bankIdMeta);
    }
    if (data.containsKey('sender')) {
      context.handle(
        _senderMeta,
        sender.isAcceptableOrUnknown(data['sender']!, _senderMeta),
      );
    } else if (isInserting) {
      context.missing(_senderMeta);
    }
    if (data.containsKey('match_type')) {
      context.handle(
        _matchTypeMeta,
        matchType.isAcceptableOrUnknown(data['match_type']!, _matchTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_matchTypeMeta);
    }
    if (data.containsKey('is_enabled')) {
      context.handle(
        _isEnabledMeta,
        isEnabled.isAcceptableOrUnknown(data['is_enabled']!, _isEnabledMeta),
      );
    }
    if (data.containsKey('label')) {
      context.handle(
        _labelMeta,
        label.isAcceptableOrUnknown(data['label']!, _labelMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BankSendersTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BankSendersTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      bankId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}bank_id'],
      )!,
      sender: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sender'],
      )!,
      matchType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}match_type'],
      )!,
      isEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_enabled'],
      )!,
      label: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}label'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $BankSendersTableTable createAlias(String alias) {
    return $BankSendersTableTable(attachedDatabase, alias);
  }
}

class BankSendersTableData extends DataClass
    implements Insertable<BankSendersTableData> {
  /// Primary key — [BankSender.id], backend identifier. TEXT
  /// (config rows arrive with ids). Not auto-increment.
  final String id;

  /// Owning bank — banks.id. RESTRICT delete: no orphans; bank rows
  /// are never deleted anyway (retained for audit).
  final String bankId;

  /// Canonical sender address — already normalized by the time it is
  /// stored (see the class doc comment).
  final String sender;

  /// Wire name of BankSenderMatchType ('exact' | 'prefix') — model
  /// layer marshals the enum.
  final String matchType;

  /// Whether this sender participates in detection —
  /// [BankSender.isEnabled]. Default false: freshly synced rows are
  /// invisible until explicitly enabled (safe-by-default).
  final bool isEnabled;

  /// Optional human note — [BankSender.label]. Nullable 1:1.
  final String? label;

  /// Creation time (UTC) — [BankSender.createdAt].
  final DateTime createdAt;

  /// Last-update time (UTC) — [BankSender.updatedAt].
  final DateTime updatedAt;
  const BankSendersTableData({
    required this.id,
    required this.bankId,
    required this.sender,
    required this.matchType,
    required this.isEnabled,
    this.label,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['bank_id'] = Variable<String>(bankId);
    map['sender'] = Variable<String>(sender);
    map['match_type'] = Variable<String>(matchType);
    map['is_enabled'] = Variable<bool>(isEnabled);
    if (!nullToAbsent || label != null) {
      map['label'] = Variable<String>(label);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  BankSendersTableCompanion toCompanion(bool nullToAbsent) {
    return BankSendersTableCompanion(
      id: Value(id),
      bankId: Value(bankId),
      sender: Value(sender),
      matchType: Value(matchType),
      isEnabled: Value(isEnabled),
      label: label == null && nullToAbsent
          ? const Value.absent()
          : Value(label),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory BankSendersTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BankSendersTableData(
      id: serializer.fromJson<String>(json['id']),
      bankId: serializer.fromJson<String>(json['bankId']),
      sender: serializer.fromJson<String>(json['sender']),
      matchType: serializer.fromJson<String>(json['matchType']),
      isEnabled: serializer.fromJson<bool>(json['isEnabled']),
      label: serializer.fromJson<String?>(json['label']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'bankId': serializer.toJson<String>(bankId),
      'sender': serializer.toJson<String>(sender),
      'matchType': serializer.toJson<String>(matchType),
      'isEnabled': serializer.toJson<bool>(isEnabled),
      'label': serializer.toJson<String?>(label),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  BankSendersTableData copyWith({
    String? id,
    String? bankId,
    String? sender,
    String? matchType,
    bool? isEnabled,
    Value<String?> label = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => BankSendersTableData(
    id: id ?? this.id,
    bankId: bankId ?? this.bankId,
    sender: sender ?? this.sender,
    matchType: matchType ?? this.matchType,
    isEnabled: isEnabled ?? this.isEnabled,
    label: label.present ? label.value : this.label,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  BankSendersTableData copyWithCompanion(BankSendersTableCompanion data) {
    return BankSendersTableData(
      id: data.id.present ? data.id.value : this.id,
      bankId: data.bankId.present ? data.bankId.value : this.bankId,
      sender: data.sender.present ? data.sender.value : this.sender,
      matchType: data.matchType.present ? data.matchType.value : this.matchType,
      isEnabled: data.isEnabled.present ? data.isEnabled.value : this.isEnabled,
      label: data.label.present ? data.label.value : this.label,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BankSendersTableData(')
          ..write('id: $id, ')
          ..write('bankId: $bankId, ')
          ..write('sender: $sender, ')
          ..write('matchType: $matchType, ')
          ..write('isEnabled: $isEnabled, ')
          ..write('label: $label, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    bankId,
    sender,
    matchType,
    isEnabled,
    label,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BankSendersTableData &&
          other.id == this.id &&
          other.bankId == this.bankId &&
          other.sender == this.sender &&
          other.matchType == this.matchType &&
          other.isEnabled == this.isEnabled &&
          other.label == this.label &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class BankSendersTableCompanion extends UpdateCompanion<BankSendersTableData> {
  final Value<String> id;
  final Value<String> bankId;
  final Value<String> sender;
  final Value<String> matchType;
  final Value<bool> isEnabled;
  final Value<String?> label;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const BankSendersTableCompanion({
    this.id = const Value.absent(),
    this.bankId = const Value.absent(),
    this.sender = const Value.absent(),
    this.matchType = const Value.absent(),
    this.isEnabled = const Value.absent(),
    this.label = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BankSendersTableCompanion.insert({
    this.id = const Value.absent(),
    required String bankId,
    required String sender,
    required String matchType,
    this.isEnabled = const Value.absent(),
    this.label = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : bankId = Value(bankId),
       sender = Value(sender),
       matchType = Value(matchType),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<BankSendersTableData> custom({
    Expression<String>? id,
    Expression<String>? bankId,
    Expression<String>? sender,
    Expression<String>? matchType,
    Expression<bool>? isEnabled,
    Expression<String>? label,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (bankId != null) 'bank_id': bankId,
      if (sender != null) 'sender': sender,
      if (matchType != null) 'match_type': matchType,
      if (isEnabled != null) 'is_enabled': isEnabled,
      if (label != null) 'label': label,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BankSendersTableCompanion copyWith({
    Value<String>? id,
    Value<String>? bankId,
    Value<String>? sender,
    Value<String>? matchType,
    Value<bool>? isEnabled,
    Value<String?>? label,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return BankSendersTableCompanion(
      id: id ?? this.id,
      bankId: bankId ?? this.bankId,
      sender: sender ?? this.sender,
      matchType: matchType ?? this.matchType,
      isEnabled: isEnabled ?? this.isEnabled,
      label: label ?? this.label,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (bankId.present) {
      map['bank_id'] = Variable<String>(bankId.value);
    }
    if (sender.present) {
      map['sender'] = Variable<String>(sender.value);
    }
    if (matchType.present) {
      map['match_type'] = Variable<String>(matchType.value);
    }
    if (isEnabled.present) {
      map['is_enabled'] = Variable<bool>(isEnabled.value);
    }
    if (label.present) {
      map['label'] = Variable<String>(label.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BankSendersTableCompanion(')
          ..write('id: $id, ')
          ..write('bankId: $bankId, ')
          ..write('sender: $sender, ')
          ..write('matchType: $matchType, ')
          ..write('isEnabled: $isEnabled, ')
          ..write('label: $label, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ParserRulesTableTable extends ParserRulesTable
    with TableInfo<$ParserRulesTableTable, ParserRulesTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ParserRulesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: () => '',
  );
  static const VerificationMeta _bankIdMeta = const VerificationMeta('bankId');
  @override
  late final GeneratedColumn<String> bankId = GeneratedColumn<String>(
    'bank_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES banks (id) ON DELETE RESTRICT',
    ),
  );
  static const VerificationMeta _fieldMeta = const VerificationMeta('field');
  @override
  late final GeneratedColumn<String> field = GeneratedColumn<String>(
    'field',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _ruleTypeMeta = const VerificationMeta(
    'ruleType',
  );
  @override
  late final GeneratedColumn<String> ruleType = GeneratedColumn<String>(
    'rule_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _patternMeta = const VerificationMeta(
    'pattern',
  );
  @override
  late final GeneratedColumn<String> pattern = GeneratedColumn<String>(
    'pattern',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _extractionGroupMeta = const VerificationMeta(
    'extractionGroup',
  );
  @override
  late final GeneratedColumn<int> extractionGroup = GeneratedColumn<int>(
    'extraction_group',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _keywordsMeta = const VerificationMeta(
    'keywords',
  );
  @override
  late final GeneratedColumn<String> keywords = GeneratedColumn<String>(
    'keywords',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('[]'),
  );
  static const VerificationMeta _validationMeta = const VerificationMeta(
    'validation',
  );
  @override
  late final GeneratedColumn<String> validation = GeneratedColumn<String>(
    'validation',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('{}'),
  );
  static const VerificationMeta _priorityMeta = const VerificationMeta(
    'priority',
  );
  @override
  late final GeneratedColumn<int> priority = GeneratedColumn<int>(
    'priority',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(100),
  );
  static const VerificationMeta _isRequiredMeta = const VerificationMeta(
    'isRequired',
  );
  @override
  late final GeneratedColumn<bool> isRequired = GeneratedColumn<bool>(
    'is_required',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_required" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    bankId,
    field,
    ruleType,
    pattern,
    extractionGroup,
    keywords,
    validation,
    priority,
    isRequired,
    isActive,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'parser_rules';
  @override
  VerificationContext validateIntegrity(
    Insertable<ParserRulesTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('bank_id')) {
      context.handle(
        _bankIdMeta,
        bankId.isAcceptableOrUnknown(data['bank_id']!, _bankIdMeta),
      );
    } else if (isInserting) {
      context.missing(_bankIdMeta);
    }
    if (data.containsKey('field')) {
      context.handle(
        _fieldMeta,
        field.isAcceptableOrUnknown(data['field']!, _fieldMeta),
      );
    } else if (isInserting) {
      context.missing(_fieldMeta);
    }
    if (data.containsKey('rule_type')) {
      context.handle(
        _ruleTypeMeta,
        ruleType.isAcceptableOrUnknown(data['rule_type']!, _ruleTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_ruleTypeMeta);
    }
    if (data.containsKey('pattern')) {
      context.handle(
        _patternMeta,
        pattern.isAcceptableOrUnknown(data['pattern']!, _patternMeta),
      );
    }
    if (data.containsKey('extraction_group')) {
      context.handle(
        _extractionGroupMeta,
        extractionGroup.isAcceptableOrUnknown(
          data['extraction_group']!,
          _extractionGroupMeta,
        ),
      );
    }
    if (data.containsKey('keywords')) {
      context.handle(
        _keywordsMeta,
        keywords.isAcceptableOrUnknown(data['keywords']!, _keywordsMeta),
      );
    }
    if (data.containsKey('validation')) {
      context.handle(
        _validationMeta,
        validation.isAcceptableOrUnknown(data['validation']!, _validationMeta),
      );
    }
    if (data.containsKey('priority')) {
      context.handle(
        _priorityMeta,
        priority.isAcceptableOrUnknown(data['priority']!, _priorityMeta),
      );
    }
    if (data.containsKey('is_required')) {
      context.handle(
        _isRequiredMeta,
        isRequired.isAcceptableOrUnknown(data['is_required']!, _isRequiredMeta),
      );
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {bankId, field, priority},
  ];
  @override
  ParserRulesTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ParserRulesTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      bankId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}bank_id'],
      )!,
      field: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}field'],
      )!,
      ruleType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}rule_type'],
      )!,
      pattern: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}pattern'],
      ),
      extractionGroup: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}extraction_group'],
      )!,
      keywords: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}keywords'],
      )!,
      validation: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}validation'],
      )!,
      priority: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}priority'],
      )!,
      isRequired: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_required'],
      )!,
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $ParserRulesTableTable createAlias(String alias) {
    return $ParserRulesTableTable(attachedDatabase, alias);
  }
}

class ParserRulesTableData extends DataClass
    implements Insertable<ParserRulesTableData> {
  /// Primary key — [ParserRule.id], backend identifier. TEXT, not
  /// auto-increment (config rows arrive with ids).
  final String id;

  /// Owning bank — banks.id. RESTRICT delete: no orphans.
  final String bankId;

  /// Frozen wire name of ParserRuleField ('amount', 'card_number',
  /// 'transaction_type', ...). TEXT; model marshals.
  final String field;

  /// Frozen wire name of ParserRuleType ('regex' | 'keyword'). TEXT;
  /// model marshals.
  final String ruleType;

  /// Regex source — nullable 1:1 (keyword rules have no pattern).
  /// Stored verbatim; compiled only in the Phase 07 parser layer.
  final String? pattern;

  /// Capturing group index — default 0 (whole match).
  final int extractionGroup;

  /// Keywords — JSON array string, default '[]'. Always present;
  /// the entity's list is never null.
  final String keywords;

  /// Validation config — JSON object string; '{}' for
  /// ParserRuleValidation.empty. Model marshals the typed class.
  final String validation;

  /// Execution order — LOWER runs first. One rule per (bank, field,
  /// priority) slot — the entity's deterministic tie-break,
  /// enforced structurally at storage.
  final int priority;

  /// Whether a failed extraction from this rule fails the whole
  /// parse — [ParserRule.isRequired].
  final bool isRequired;

  /// Whether the rule participates in parsing — retained when off
  /// (rollback/history contract from Phase 02).
  final bool isActive;

  /// Creation time (UTC) — [ParserRule.createdAt].
  final DateTime createdAt;

  /// Last-update time (UTC) — [ParserRule.updatedAt].
  final DateTime updatedAt;
  const ParserRulesTableData({
    required this.id,
    required this.bankId,
    required this.field,
    required this.ruleType,
    this.pattern,
    required this.extractionGroup,
    required this.keywords,
    required this.validation,
    required this.priority,
    required this.isRequired,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['bank_id'] = Variable<String>(bankId);
    map['field'] = Variable<String>(field);
    map['rule_type'] = Variable<String>(ruleType);
    if (!nullToAbsent || pattern != null) {
      map['pattern'] = Variable<String>(pattern);
    }
    map['extraction_group'] = Variable<int>(extractionGroup);
    map['keywords'] = Variable<String>(keywords);
    map['validation'] = Variable<String>(validation);
    map['priority'] = Variable<int>(priority);
    map['is_required'] = Variable<bool>(isRequired);
    map['is_active'] = Variable<bool>(isActive);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  ParserRulesTableCompanion toCompanion(bool nullToAbsent) {
    return ParserRulesTableCompanion(
      id: Value(id),
      bankId: Value(bankId),
      field: Value(field),
      ruleType: Value(ruleType),
      pattern: pattern == null && nullToAbsent
          ? const Value.absent()
          : Value(pattern),
      extractionGroup: Value(extractionGroup),
      keywords: Value(keywords),
      validation: Value(validation),
      priority: Value(priority),
      isRequired: Value(isRequired),
      isActive: Value(isActive),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory ParserRulesTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ParserRulesTableData(
      id: serializer.fromJson<String>(json['id']),
      bankId: serializer.fromJson<String>(json['bankId']),
      field: serializer.fromJson<String>(json['field']),
      ruleType: serializer.fromJson<String>(json['ruleType']),
      pattern: serializer.fromJson<String?>(json['pattern']),
      extractionGroup: serializer.fromJson<int>(json['extractionGroup']),
      keywords: serializer.fromJson<String>(json['keywords']),
      validation: serializer.fromJson<String>(json['validation']),
      priority: serializer.fromJson<int>(json['priority']),
      isRequired: serializer.fromJson<bool>(json['isRequired']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'bankId': serializer.toJson<String>(bankId),
      'field': serializer.toJson<String>(field),
      'ruleType': serializer.toJson<String>(ruleType),
      'pattern': serializer.toJson<String?>(pattern),
      'extractionGroup': serializer.toJson<int>(extractionGroup),
      'keywords': serializer.toJson<String>(keywords),
      'validation': serializer.toJson<String>(validation),
      'priority': serializer.toJson<int>(priority),
      'isRequired': serializer.toJson<bool>(isRequired),
      'isActive': serializer.toJson<bool>(isActive),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  ParserRulesTableData copyWith({
    String? id,
    String? bankId,
    String? field,
    String? ruleType,
    Value<String?> pattern = const Value.absent(),
    int? extractionGroup,
    String? keywords,
    String? validation,
    int? priority,
    bool? isRequired,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => ParserRulesTableData(
    id: id ?? this.id,
    bankId: bankId ?? this.bankId,
    field: field ?? this.field,
    ruleType: ruleType ?? this.ruleType,
    pattern: pattern.present ? pattern.value : this.pattern,
    extractionGroup: extractionGroup ?? this.extractionGroup,
    keywords: keywords ?? this.keywords,
    validation: validation ?? this.validation,
    priority: priority ?? this.priority,
    isRequired: isRequired ?? this.isRequired,
    isActive: isActive ?? this.isActive,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  ParserRulesTableData copyWithCompanion(ParserRulesTableCompanion data) {
    return ParserRulesTableData(
      id: data.id.present ? data.id.value : this.id,
      bankId: data.bankId.present ? data.bankId.value : this.bankId,
      field: data.field.present ? data.field.value : this.field,
      ruleType: data.ruleType.present ? data.ruleType.value : this.ruleType,
      pattern: data.pattern.present ? data.pattern.value : this.pattern,
      extractionGroup: data.extractionGroup.present
          ? data.extractionGroup.value
          : this.extractionGroup,
      keywords: data.keywords.present ? data.keywords.value : this.keywords,
      validation: data.validation.present
          ? data.validation.value
          : this.validation,
      priority: data.priority.present ? data.priority.value : this.priority,
      isRequired: data.isRequired.present
          ? data.isRequired.value
          : this.isRequired,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ParserRulesTableData(')
          ..write('id: $id, ')
          ..write('bankId: $bankId, ')
          ..write('field: $field, ')
          ..write('ruleType: $ruleType, ')
          ..write('pattern: $pattern, ')
          ..write('extractionGroup: $extractionGroup, ')
          ..write('keywords: $keywords, ')
          ..write('validation: $validation, ')
          ..write('priority: $priority, ')
          ..write('isRequired: $isRequired, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    bankId,
    field,
    ruleType,
    pattern,
    extractionGroup,
    keywords,
    validation,
    priority,
    isRequired,
    isActive,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ParserRulesTableData &&
          other.id == this.id &&
          other.bankId == this.bankId &&
          other.field == this.field &&
          other.ruleType == this.ruleType &&
          other.pattern == this.pattern &&
          other.extractionGroup == this.extractionGroup &&
          other.keywords == this.keywords &&
          other.validation == this.validation &&
          other.priority == this.priority &&
          other.isRequired == this.isRequired &&
          other.isActive == this.isActive &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class ParserRulesTableCompanion extends UpdateCompanion<ParserRulesTableData> {
  final Value<String> id;
  final Value<String> bankId;
  final Value<String> field;
  final Value<String> ruleType;
  final Value<String?> pattern;
  final Value<int> extractionGroup;
  final Value<String> keywords;
  final Value<String> validation;
  final Value<int> priority;
  final Value<bool> isRequired;
  final Value<bool> isActive;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const ParserRulesTableCompanion({
    this.id = const Value.absent(),
    this.bankId = const Value.absent(),
    this.field = const Value.absent(),
    this.ruleType = const Value.absent(),
    this.pattern = const Value.absent(),
    this.extractionGroup = const Value.absent(),
    this.keywords = const Value.absent(),
    this.validation = const Value.absent(),
    this.priority = const Value.absent(),
    this.isRequired = const Value.absent(),
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ParserRulesTableCompanion.insert({
    this.id = const Value.absent(),
    required String bankId,
    required String field,
    required String ruleType,
    this.pattern = const Value.absent(),
    this.extractionGroup = const Value.absent(),
    this.keywords = const Value.absent(),
    this.validation = const Value.absent(),
    this.priority = const Value.absent(),
    this.isRequired = const Value.absent(),
    this.isActive = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : bankId = Value(bankId),
       field = Value(field),
       ruleType = Value(ruleType),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<ParserRulesTableData> custom({
    Expression<String>? id,
    Expression<String>? bankId,
    Expression<String>? field,
    Expression<String>? ruleType,
    Expression<String>? pattern,
    Expression<int>? extractionGroup,
    Expression<String>? keywords,
    Expression<String>? validation,
    Expression<int>? priority,
    Expression<bool>? isRequired,
    Expression<bool>? isActive,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (bankId != null) 'bank_id': bankId,
      if (field != null) 'field': field,
      if (ruleType != null) 'rule_type': ruleType,
      if (pattern != null) 'pattern': pattern,
      if (extractionGroup != null) 'extraction_group': extractionGroup,
      if (keywords != null) 'keywords': keywords,
      if (validation != null) 'validation': validation,
      if (priority != null) 'priority': priority,
      if (isRequired != null) 'is_required': isRequired,
      if (isActive != null) 'is_active': isActive,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ParserRulesTableCompanion copyWith({
    Value<String>? id,
    Value<String>? bankId,
    Value<String>? field,
    Value<String>? ruleType,
    Value<String?>? pattern,
    Value<int>? extractionGroup,
    Value<String>? keywords,
    Value<String>? validation,
    Value<int>? priority,
    Value<bool>? isRequired,
    Value<bool>? isActive,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return ParserRulesTableCompanion(
      id: id ?? this.id,
      bankId: bankId ?? this.bankId,
      field: field ?? this.field,
      ruleType: ruleType ?? this.ruleType,
      pattern: pattern ?? this.pattern,
      extractionGroup: extractionGroup ?? this.extractionGroup,
      keywords: keywords ?? this.keywords,
      validation: validation ?? this.validation,
      priority: priority ?? this.priority,
      isRequired: isRequired ?? this.isRequired,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (bankId.present) {
      map['bank_id'] = Variable<String>(bankId.value);
    }
    if (field.present) {
      map['field'] = Variable<String>(field.value);
    }
    if (ruleType.present) {
      map['rule_type'] = Variable<String>(ruleType.value);
    }
    if (pattern.present) {
      map['pattern'] = Variable<String>(pattern.value);
    }
    if (extractionGroup.present) {
      map['extraction_group'] = Variable<int>(extractionGroup.value);
    }
    if (keywords.present) {
      map['keywords'] = Variable<String>(keywords.value);
    }
    if (validation.present) {
      map['validation'] = Variable<String>(validation.value);
    }
    if (priority.present) {
      map['priority'] = Variable<int>(priority.value);
    }
    if (isRequired.present) {
      map['is_required'] = Variable<bool>(isRequired.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ParserRulesTableCompanion(')
          ..write('id: $id, ')
          ..write('bankId: $bankId, ')
          ..write('field: $field, ')
          ..write('ruleType: $ruleType, ')
          ..write('pattern: $pattern, ')
          ..write('extractionGroup: $extractionGroup, ')
          ..write('keywords: $keywords, ')
          ..write('validation: $validation, ')
          ..write('priority: $priority, ')
          ..write('isRequired: $isRequired, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SmsMessagesTableTable extends SmsMessagesTable
    with TableInfo<$SmsMessagesTableTable, SmsMessagesTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SmsMessagesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: () => '',
  );
  static const VerificationMeta _deviceIdMeta = const VerificationMeta(
    'deviceId',
  );
  @override
  late final GeneratedColumn<String> deviceId = GeneratedColumn<String>(
    'device_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _senderMeta = const VerificationMeta('sender');
  @override
  late final GeneratedColumn<String> sender = GeneratedColumn<String>(
    'sender',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _bodyMeta = const VerificationMeta('body');
  @override
  late final GeneratedColumn<String> body = GeneratedColumn<String>(
    'body',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _bodyHashMeta = const VerificationMeta(
    'bodyHash',
  );
  @override
  late final GeneratedColumn<String> bodyHash = GeneratedColumn<String>(
    'body_hash',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _receivedAtMeta = const VerificationMeta(
    'receivedAt',
  );
  @override
  late final GeneratedColumn<DateTime> receivedAt = GeneratedColumn<DateTime>(
    'received_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _processingStatusMeta = const VerificationMeta(
    'processingStatus',
  );
  @override
  late final GeneratedColumn<String> processingStatus = GeneratedColumn<String>(
    'processing_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sourceMeta = const VerificationMeta('source');
  @override
  late final GeneratedColumn<String> source = GeneratedColumn<String>(
    'source',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _normalizedBodyMeta = const VerificationMeta(
    'normalizedBody',
  );
  @override
  late final GeneratedColumn<String> normalizedBody = GeneratedColumn<String>(
    'normalized_body',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _processedAtMeta = const VerificationMeta(
    'processedAt',
  );
  @override
  late final GeneratedColumn<DateTime> processedAt = GeneratedColumn<DateTime>(
    'processed_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    deviceId,
    sender,
    body,
    bodyHash,
    receivedAt,
    processingStatus,
    source,
    createdAt,
    normalizedBody,
    processedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sms_messages';
  @override
  VerificationContext validateIntegrity(
    Insertable<SmsMessagesTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('device_id')) {
      context.handle(
        _deviceIdMeta,
        deviceId.isAcceptableOrUnknown(data['device_id']!, _deviceIdMeta),
      );
    } else if (isInserting) {
      context.missing(_deviceIdMeta);
    }
    if (data.containsKey('sender')) {
      context.handle(
        _senderMeta,
        sender.isAcceptableOrUnknown(data['sender']!, _senderMeta),
      );
    } else if (isInserting) {
      context.missing(_senderMeta);
    }
    if (data.containsKey('body')) {
      context.handle(
        _bodyMeta,
        body.isAcceptableOrUnknown(data['body']!, _bodyMeta),
      );
    } else if (isInserting) {
      context.missing(_bodyMeta);
    }
    if (data.containsKey('body_hash')) {
      context.handle(
        _bodyHashMeta,
        bodyHash.isAcceptableOrUnknown(data['body_hash']!, _bodyHashMeta),
      );
    } else if (isInserting) {
      context.missing(_bodyHashMeta);
    }
    if (data.containsKey('received_at')) {
      context.handle(
        _receivedAtMeta,
        receivedAt.isAcceptableOrUnknown(data['received_at']!, _receivedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_receivedAtMeta);
    }
    if (data.containsKey('processing_status')) {
      context.handle(
        _processingStatusMeta,
        processingStatus.isAcceptableOrUnknown(
          data['processing_status']!,
          _processingStatusMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_processingStatusMeta);
    }
    if (data.containsKey('source')) {
      context.handle(
        _sourceMeta,
        source.isAcceptableOrUnknown(data['source']!, _sourceMeta),
      );
    } else if (isInserting) {
      context.missing(_sourceMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('normalized_body')) {
      context.handle(
        _normalizedBodyMeta,
        normalizedBody.isAcceptableOrUnknown(
          data['normalized_body']!,
          _normalizedBodyMeta,
        ),
      );
    }
    if (data.containsKey('processed_at')) {
      context.handle(
        _processedAtMeta,
        processedAt.isAcceptableOrUnknown(
          data['processed_at']!,
          _processedAtMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SmsMessagesTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SmsMessagesTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      deviceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}device_id'],
      )!,
      sender: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sender'],
      )!,
      body: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}body'],
      )!,
      bodyHash: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}body_hash'],
      )!,
      receivedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}received_at'],
      )!,
      processingStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}processing_status'],
      )!,
      source: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      normalizedBody: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}normalized_body'],
      ),
      processedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}processed_at'],
      ),
    );
  }

  @override
  $SmsMessagesTableTable createAlias(String alias) {
    return $SmsMessagesTableTable(attachedDatabase, alias);
  }
}

class SmsMessagesTableData extends DataClass
    implements Insertable<SmsMessagesTableData> {
  /// Primary key — [SmsMessage.id], locally generated UUID at
  /// receive time. TEXT, not auto-increment.
  final String id;

  /// Capturing device — [SmsMessage.deviceId].
  final String deviceId;

  /// Sender EXACTLY as delivered by the native layer ('+98...',
  /// '5004'). The entity preserves the original for re-detection
  /// after config changes; canonical form is computed at detection
  /// time (Phase 07) — never stored here.
  final String sender;

  /// Raw message text — SENSITIVE; see the class doc comment. Stored
  /// verbatim; the normalization output goes to [normalizedBody].
  final String body;

  /// SHA-256 hex of body.trim() — [SmsMessage.bodyHash]. The dedup
  /// lookup key; see the index note in the class doc comment.
  final String bodyHash;

  /// Device-reported receipt time (UTC).
  final DateTime receivedAt;

  /// Wire name of SmsProcessingStatus — TEXT, model marshals.
  final String processingStatus;

  /// Wire name of SmsSource — TEXT, model marshals.
  final String source;

  /// When the local row was created (UTC).
  final DateTime createdAt;

  /// Normalized text (Phase 07 output) — nullable until the pipeline
  /// runs. Persisted so re-parsing skips re-normalization drift.
  final String? normalizedBody;

  /// Terminal-state time (UTC) — nullable until then.
  final DateTime? processedAt;
  const SmsMessagesTableData({
    required this.id,
    required this.deviceId,
    required this.sender,
    required this.body,
    required this.bodyHash,
    required this.receivedAt,
    required this.processingStatus,
    required this.source,
    required this.createdAt,
    this.normalizedBody,
    this.processedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['device_id'] = Variable<String>(deviceId);
    map['sender'] = Variable<String>(sender);
    map['body'] = Variable<String>(body);
    map['body_hash'] = Variable<String>(bodyHash);
    map['received_at'] = Variable<DateTime>(receivedAt);
    map['processing_status'] = Variable<String>(processingStatus);
    map['source'] = Variable<String>(source);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || normalizedBody != null) {
      map['normalized_body'] = Variable<String>(normalizedBody);
    }
    if (!nullToAbsent || processedAt != null) {
      map['processed_at'] = Variable<DateTime>(processedAt);
    }
    return map;
  }

  SmsMessagesTableCompanion toCompanion(bool nullToAbsent) {
    return SmsMessagesTableCompanion(
      id: Value(id),
      deviceId: Value(deviceId),
      sender: Value(sender),
      body: Value(body),
      bodyHash: Value(bodyHash),
      receivedAt: Value(receivedAt),
      processingStatus: Value(processingStatus),
      source: Value(source),
      createdAt: Value(createdAt),
      normalizedBody: normalizedBody == null && nullToAbsent
          ? const Value.absent()
          : Value(normalizedBody),
      processedAt: processedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(processedAt),
    );
  }

  factory SmsMessagesTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SmsMessagesTableData(
      id: serializer.fromJson<String>(json['id']),
      deviceId: serializer.fromJson<String>(json['deviceId']),
      sender: serializer.fromJson<String>(json['sender']),
      body: serializer.fromJson<String>(json['body']),
      bodyHash: serializer.fromJson<String>(json['bodyHash']),
      receivedAt: serializer.fromJson<DateTime>(json['receivedAt']),
      processingStatus: serializer.fromJson<String>(json['processingStatus']),
      source: serializer.fromJson<String>(json['source']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      normalizedBody: serializer.fromJson<String?>(json['normalizedBody']),
      processedAt: serializer.fromJson<DateTime?>(json['processedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'deviceId': serializer.toJson<String>(deviceId),
      'sender': serializer.toJson<String>(sender),
      'body': serializer.toJson<String>(body),
      'bodyHash': serializer.toJson<String>(bodyHash),
      'receivedAt': serializer.toJson<DateTime>(receivedAt),
      'processingStatus': serializer.toJson<String>(processingStatus),
      'source': serializer.toJson<String>(source),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'normalizedBody': serializer.toJson<String?>(normalizedBody),
      'processedAt': serializer.toJson<DateTime?>(processedAt),
    };
  }

  SmsMessagesTableData copyWith({
    String? id,
    String? deviceId,
    String? sender,
    String? body,
    String? bodyHash,
    DateTime? receivedAt,
    String? processingStatus,
    String? source,
    DateTime? createdAt,
    Value<String?> normalizedBody = const Value.absent(),
    Value<DateTime?> processedAt = const Value.absent(),
  }) => SmsMessagesTableData(
    id: id ?? this.id,
    deviceId: deviceId ?? this.deviceId,
    sender: sender ?? this.sender,
    body: body ?? this.body,
    bodyHash: bodyHash ?? this.bodyHash,
    receivedAt: receivedAt ?? this.receivedAt,
    processingStatus: processingStatus ?? this.processingStatus,
    source: source ?? this.source,
    createdAt: createdAt ?? this.createdAt,
    normalizedBody: normalizedBody.present
        ? normalizedBody.value
        : this.normalizedBody,
    processedAt: processedAt.present ? processedAt.value : this.processedAt,
  );
  SmsMessagesTableData copyWithCompanion(SmsMessagesTableCompanion data) {
    return SmsMessagesTableData(
      id: data.id.present ? data.id.value : this.id,
      deviceId: data.deviceId.present ? data.deviceId.value : this.deviceId,
      sender: data.sender.present ? data.sender.value : this.sender,
      body: data.body.present ? data.body.value : this.body,
      bodyHash: data.bodyHash.present ? data.bodyHash.value : this.bodyHash,
      receivedAt: data.receivedAt.present
          ? data.receivedAt.value
          : this.receivedAt,
      processingStatus: data.processingStatus.present
          ? data.processingStatus.value
          : this.processingStatus,
      source: data.source.present ? data.source.value : this.source,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      normalizedBody: data.normalizedBody.present
          ? data.normalizedBody.value
          : this.normalizedBody,
      processedAt: data.processedAt.present
          ? data.processedAt.value
          : this.processedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SmsMessagesTableData(')
          ..write('id: $id, ')
          ..write('deviceId: $deviceId, ')
          ..write('sender: $sender, ')
          ..write('body: $body, ')
          ..write('bodyHash: $bodyHash, ')
          ..write('receivedAt: $receivedAt, ')
          ..write('processingStatus: $processingStatus, ')
          ..write('source: $source, ')
          ..write('createdAt: $createdAt, ')
          ..write('normalizedBody: $normalizedBody, ')
          ..write('processedAt: $processedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    deviceId,
    sender,
    body,
    bodyHash,
    receivedAt,
    processingStatus,
    source,
    createdAt,
    normalizedBody,
    processedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SmsMessagesTableData &&
          other.id == this.id &&
          other.deviceId == this.deviceId &&
          other.sender == this.sender &&
          other.body == this.body &&
          other.bodyHash == this.bodyHash &&
          other.receivedAt == this.receivedAt &&
          other.processingStatus == this.processingStatus &&
          other.source == this.source &&
          other.createdAt == this.createdAt &&
          other.normalizedBody == this.normalizedBody &&
          other.processedAt == this.processedAt);
}

class SmsMessagesTableCompanion extends UpdateCompanion<SmsMessagesTableData> {
  final Value<String> id;
  final Value<String> deviceId;
  final Value<String> sender;
  final Value<String> body;
  final Value<String> bodyHash;
  final Value<DateTime> receivedAt;
  final Value<String> processingStatus;
  final Value<String> source;
  final Value<DateTime> createdAt;
  final Value<String?> normalizedBody;
  final Value<DateTime?> processedAt;
  final Value<int> rowid;
  const SmsMessagesTableCompanion({
    this.id = const Value.absent(),
    this.deviceId = const Value.absent(),
    this.sender = const Value.absent(),
    this.body = const Value.absent(),
    this.bodyHash = const Value.absent(),
    this.receivedAt = const Value.absent(),
    this.processingStatus = const Value.absent(),
    this.source = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.normalizedBody = const Value.absent(),
    this.processedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SmsMessagesTableCompanion.insert({
    this.id = const Value.absent(),
    required String deviceId,
    required String sender,
    required String body,
    required String bodyHash,
    required DateTime receivedAt,
    required String processingStatus,
    required String source,
    required DateTime createdAt,
    this.normalizedBody = const Value.absent(),
    this.processedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : deviceId = Value(deviceId),
       sender = Value(sender),
       body = Value(body),
       bodyHash = Value(bodyHash),
       receivedAt = Value(receivedAt),
       processingStatus = Value(processingStatus),
       source = Value(source),
       createdAt = Value(createdAt);
  static Insertable<SmsMessagesTableData> custom({
    Expression<String>? id,
    Expression<String>? deviceId,
    Expression<String>? sender,
    Expression<String>? body,
    Expression<String>? bodyHash,
    Expression<DateTime>? receivedAt,
    Expression<String>? processingStatus,
    Expression<String>? source,
    Expression<DateTime>? createdAt,
    Expression<String>? normalizedBody,
    Expression<DateTime>? processedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (deviceId != null) 'device_id': deviceId,
      if (sender != null) 'sender': sender,
      if (body != null) 'body': body,
      if (bodyHash != null) 'body_hash': bodyHash,
      if (receivedAt != null) 'received_at': receivedAt,
      if (processingStatus != null) 'processing_status': processingStatus,
      if (source != null) 'source': source,
      if (createdAt != null) 'created_at': createdAt,
      if (normalizedBody != null) 'normalized_body': normalizedBody,
      if (processedAt != null) 'processed_at': processedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SmsMessagesTableCompanion copyWith({
    Value<String>? id,
    Value<String>? deviceId,
    Value<String>? sender,
    Value<String>? body,
    Value<String>? bodyHash,
    Value<DateTime>? receivedAt,
    Value<String>? processingStatus,
    Value<String>? source,
    Value<DateTime>? createdAt,
    Value<String?>? normalizedBody,
    Value<DateTime?>? processedAt,
    Value<int>? rowid,
  }) {
    return SmsMessagesTableCompanion(
      id: id ?? this.id,
      deviceId: deviceId ?? this.deviceId,
      sender: sender ?? this.sender,
      body: body ?? this.body,
      bodyHash: bodyHash ?? this.bodyHash,
      receivedAt: receivedAt ?? this.receivedAt,
      processingStatus: processingStatus ?? this.processingStatus,
      source: source ?? this.source,
      createdAt: createdAt ?? this.createdAt,
      normalizedBody: normalizedBody ?? this.normalizedBody,
      processedAt: processedAt ?? this.processedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (deviceId.present) {
      map['device_id'] = Variable<String>(deviceId.value);
    }
    if (sender.present) {
      map['sender'] = Variable<String>(sender.value);
    }
    if (body.present) {
      map['body'] = Variable<String>(body.value);
    }
    if (bodyHash.present) {
      map['body_hash'] = Variable<String>(bodyHash.value);
    }
    if (receivedAt.present) {
      map['received_at'] = Variable<DateTime>(receivedAt.value);
    }
    if (processingStatus.present) {
      map['processing_status'] = Variable<String>(processingStatus.value);
    }
    if (source.present) {
      map['source'] = Variable<String>(source.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (normalizedBody.present) {
      map['normalized_body'] = Variable<String>(normalizedBody.value);
    }
    if (processedAt.present) {
      map['processed_at'] = Variable<DateTime>(processedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SmsMessagesTableCompanion(')
          ..write('id: $id, ')
          ..write('deviceId: $deviceId, ')
          ..write('sender: $sender, ')
          ..write('body: $body, ')
          ..write('bodyHash: $bodyHash, ')
          ..write('receivedAt: $receivedAt, ')
          ..write('processingStatus: $processingStatus, ')
          ..write('source: $source, ')
          ..write('createdAt: $createdAt, ')
          ..write('normalizedBody: $normalizedBody, ')
          ..write('processedAt: $processedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TransactionsTableTable extends TransactionsTable
    with TableInfo<$TransactionsTableTable, TransactionsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TransactionsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: () => '',
  );
  static const VerificationMeta _smsIdMeta = const VerificationMeta('smsId');
  @override
  late final GeneratedColumn<String> smsId = GeneratedColumn<String>(
    'sms_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES sms_messages (id) ON DELETE RESTRICT',
    ),
  );
  static const VerificationMeta _deviceIdMeta = const VerificationMeta(
    'deviceId',
  );
  @override
  late final GeneratedColumn<String> deviceId = GeneratedColumn<String>(
    'device_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _bankIdMeta = const VerificationMeta('bankId');
  @override
  late final GeneratedColumn<String> bankId = GeneratedColumn<String>(
    'bank_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES banks (id) ON DELETE RESTRICT',
    ),
  );
  static const VerificationMeta _bankCodeMeta = const VerificationMeta(
    'bankCode',
  );
  @override
  late final GeneratedColumn<String> bankCode = GeneratedColumn<String>(
    'bank_code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _bankNameMeta = const VerificationMeta(
    'bankName',
  );
  @override
  late final GeneratedColumn<String> bankName = GeneratedColumn<String>(
    'bank_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<int> amount = GeneratedColumn<int>(
    'amount',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _currencyMeta = const VerificationMeta(
    'currency',
  );
  @override
  late final GeneratedColumn<String> currency = GeneratedColumn<String>(
    'currency',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _timestampMeta = const VerificationMeta(
    'timestamp',
  );
  @override
  late final GeneratedColumn<DateTime> timestamp = GeneratedColumn<DateTime>(
    'timestamp',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _cardNumberMaskedMeta = const VerificationMeta(
    'cardNumberMasked',
  );
  @override
  late final GeneratedColumn<String> cardNumberMasked = GeneratedColumn<String>(
    'card_number_masked',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _accountNumberMeta = const VerificationMeta(
    'accountNumber',
  );
  @override
  late final GeneratedColumn<String> accountNumber = GeneratedColumn<String>(
    'account_number',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _referenceNumberMeta = const VerificationMeta(
    'referenceNumber',
  );
  @override
  late final GeneratedColumn<String> referenceNumber = GeneratedColumn<String>(
    'reference_number',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _traceNumberMeta = const VerificationMeta(
    'traceNumber',
  );
  @override
  late final GeneratedColumn<String> traceNumber = GeneratedColumn<String>(
    'trace_number',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _balanceMeta = const VerificationMeta(
    'balance',
  );
  @override
  late final GeneratedColumn<int> balance = GeneratedColumn<int>(
    'balance',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _confidenceScoreMeta = const VerificationMeta(
    'confidenceScore',
  );
  @override
  late final GeneratedColumn<double> confidenceScore = GeneratedColumn<double>(
    'confidence_score',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dedupKeyMeta = const VerificationMeta(
    'dedupKey',
  );
  @override
  late final GeneratedColumn<String> dedupKey = GeneratedColumn<String>(
    'dedup_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _sourceSmsHashMeta = const VerificationMeta(
    'sourceSmsHash',
  );
  @override
  late final GeneratedColumn<String> sourceSmsHash = GeneratedColumn<String>(
    'source_sms_hash',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _parserVersionMeta = const VerificationMeta(
    'parserVersion',
  );
  @override
  late final GeneratedColumn<String> parserVersion = GeneratedColumn<String>(
    'parser_version',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _serverTransactionIdMeta =
      const VerificationMeta('serverTransactionId');
  @override
  late final GeneratedColumn<String> serverTransactionId =
      GeneratedColumn<String>(
        'server_transaction_id',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
      );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    smsId,
    deviceId,
    bankId,
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
    status,
    dedupKey,
    sourceSmsHash,
    parserVersion,
    serverTransactionId,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'transactions';
  @override
  VerificationContext validateIntegrity(
    Insertable<TransactionsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('sms_id')) {
      context.handle(
        _smsIdMeta,
        smsId.isAcceptableOrUnknown(data['sms_id']!, _smsIdMeta),
      );
    } else if (isInserting) {
      context.missing(_smsIdMeta);
    }
    if (data.containsKey('device_id')) {
      context.handle(
        _deviceIdMeta,
        deviceId.isAcceptableOrUnknown(data['device_id']!, _deviceIdMeta),
      );
    } else if (isInserting) {
      context.missing(_deviceIdMeta);
    }
    if (data.containsKey('bank_id')) {
      context.handle(
        _bankIdMeta,
        bankId.isAcceptableOrUnknown(data['bank_id']!, _bankIdMeta),
      );
    } else if (isInserting) {
      context.missing(_bankIdMeta);
    }
    if (data.containsKey('bank_code')) {
      context.handle(
        _bankCodeMeta,
        bankCode.isAcceptableOrUnknown(data['bank_code']!, _bankCodeMeta),
      );
    } else if (isInserting) {
      context.missing(_bankCodeMeta);
    }
    if (data.containsKey('bank_name')) {
      context.handle(
        _bankNameMeta,
        bankName.isAcceptableOrUnknown(data['bank_name']!, _bankNameMeta),
      );
    } else if (isInserting) {
      context.missing(_bankNameMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('currency')) {
      context.handle(
        _currencyMeta,
        currency.isAcceptableOrUnknown(data['currency']!, _currencyMeta),
      );
    } else if (isInserting) {
      context.missing(_currencyMeta);
    }
    if (data.containsKey('timestamp')) {
      context.handle(
        _timestampMeta,
        timestamp.isAcceptableOrUnknown(data['timestamp']!, _timestampMeta),
      );
    } else if (isInserting) {
      context.missing(_timestampMeta);
    }
    if (data.containsKey('card_number_masked')) {
      context.handle(
        _cardNumberMaskedMeta,
        cardNumberMasked.isAcceptableOrUnknown(
          data['card_number_masked']!,
          _cardNumberMaskedMeta,
        ),
      );
    }
    if (data.containsKey('account_number')) {
      context.handle(
        _accountNumberMeta,
        accountNumber.isAcceptableOrUnknown(
          data['account_number']!,
          _accountNumberMeta,
        ),
      );
    }
    if (data.containsKey('reference_number')) {
      context.handle(
        _referenceNumberMeta,
        referenceNumber.isAcceptableOrUnknown(
          data['reference_number']!,
          _referenceNumberMeta,
        ),
      );
    }
    if (data.containsKey('trace_number')) {
      context.handle(
        _traceNumberMeta,
        traceNumber.isAcceptableOrUnknown(
          data['trace_number']!,
          _traceNumberMeta,
        ),
      );
    }
    if (data.containsKey('balance')) {
      context.handle(
        _balanceMeta,
        balance.isAcceptableOrUnknown(data['balance']!, _balanceMeta),
      );
    }
    if (data.containsKey('confidence_score')) {
      context.handle(
        _confidenceScoreMeta,
        confidenceScore.isAcceptableOrUnknown(
          data['confidence_score']!,
          _confidenceScoreMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_confidenceScoreMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('dedup_key')) {
      context.handle(
        _dedupKeyMeta,
        dedupKey.isAcceptableOrUnknown(data['dedup_key']!, _dedupKeyMeta),
      );
    } else if (isInserting) {
      context.missing(_dedupKeyMeta);
    }
    if (data.containsKey('source_sms_hash')) {
      context.handle(
        _sourceSmsHashMeta,
        sourceSmsHash.isAcceptableOrUnknown(
          data['source_sms_hash']!,
          _sourceSmsHashMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_sourceSmsHashMeta);
    }
    if (data.containsKey('parser_version')) {
      context.handle(
        _parserVersionMeta,
        parserVersion.isAcceptableOrUnknown(
          data['parser_version']!,
          _parserVersionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_parserVersionMeta);
    }
    if (data.containsKey('server_transaction_id')) {
      context.handle(
        _serverTransactionIdMeta,
        serverTransactionId.isAcceptableOrUnknown(
          data['server_transaction_id']!,
          _serverTransactionIdMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TransactionsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TransactionsTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      smsId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sms_id'],
      )!,
      deviceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}device_id'],
      )!,
      bankId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}bank_id'],
      )!,
      bankCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}bank_code'],
      )!,
      bankName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}bank_name'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}amount'],
      )!,
      currency: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}currency'],
      )!,
      timestamp: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}timestamp'],
      )!,
      cardNumberMasked: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}card_number_masked'],
      ),
      accountNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}account_number'],
      ),
      referenceNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reference_number'],
      ),
      traceNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}trace_number'],
      ),
      balance: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}balance'],
      ),
      confidenceScore: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}confidence_score'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      dedupKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}dedup_key'],
      )!,
      sourceSmsHash: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source_sms_hash'],
      )!,
      parserVersion: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}parser_version'],
      )!,
      serverTransactionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}server_transaction_id'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $TransactionsTableTable createAlias(String alias) {
    return $TransactionsTableTable(attachedDatabase, alias);
  }
}

class TransactionsTableData extends DataClass
    implements Insertable<TransactionsTableData> {
  /// Primary key — [Transaction.id], locally generated UUID. Also
  /// the Idempotency-Key of the send path (Phase 09). TEXT, not
  /// auto-increment.
  final String id;

  /// Source SMS — sms_messages.id. RESTRICT delete (messages are
  /// audit-retained anyway). UNIQUE: one SMS → at most one record.
  final String smsId;

  /// Capturing device — [Transaction.deviceId].
  final String deviceId;

  /// Bank config row — banks.id. RESTRICT delete. Soft reference for
  /// local relations; the RESILIENCE identity is [bankCode].
  final String bankId;

  /// Stable bank wire code ('MELLAT') — survives bank-row re-syncs;
  /// powers the API bank_code payload.
  final String bankCode;

  /// Bank display name SNAPSHOT at creation — lists render without
  /// a join; historical records keep the name that was true then.
  final String bankName;

  /// Wire name of TransactionType ('deposit', ...) — model marshals.
  final String type;

  /// Amount in the smallest unit (rials) — non-negative integer;
  /// sign implied by type (never stored separately).
  final int amount;

  /// ISO-4217 style code ('IRR') — model marshals.
  final String currency;

  /// Transaction time (UTC) — from the message body or receive-time
  /// fallback. Indexed: default sort of the transactions screens.
  final DateTime timestamp;

  /// Already-masked card ('6037********1234') — masked at the
  /// extraction boundary; a full PAN never existed past the parser.
  final String? cardNumberMasked;

  /// Account number, verbatim — nullable 1:1.
  final String? accountNumber;

  /// Bank reference, verbatim (leading zeros kept) — nullable 1:1.
  /// Indexed: findByReference lookup.
  final String? referenceNumber;

  /// Bank trace, verbatim — nullable 1:1.
  final String? traceNumber;

  /// Post-transaction balance (smallest unit) — nullable 1:1.
  final int? balance;

  /// Deterministic parse score 0.0..1.0 — the number sent as
  /// "confidence" in the API payload.
  final double confidenceScore;

  /// Wire name of TransactionStatus ('pending'|'confirmed'|
  /// 'rejected') — model marshals. Created only as 'pending'.
  final String status;

  /// Canonical duplicate-prevention key (DeduplicationEngine,
  /// Phase 08) — UNIQUE: the storage-level last line of defense.
  final String dedupKey;

  /// SHA-256 of the source SMS — the safe lineage reference; the
  /// raw body never travels past this table's inputs.
  final String sourceSmsHash;

  /// Parser version SNAPSHOT at creation — the parser-config audit
  /// chain.
  final String parserVersion;

  /// Backend identifier — set ONCE on acceptance; immutable after.
  /// Nullable-UNIQUE (SQLite: many NULLs allowed) — two records can
  /// never claim the same server identity.
  final String? serverTransactionId;

  /// When the record was created (UTC).
  final DateTime createdAt;

  /// When last mutated (UTC) — refreshed by any standing/lineage
  /// change.
  final DateTime updatedAt;
  const TransactionsTableData({
    required this.id,
    required this.smsId,
    required this.deviceId,
    required this.bankId,
    required this.bankCode,
    required this.bankName,
    required this.type,
    required this.amount,
    required this.currency,
    required this.timestamp,
    this.cardNumberMasked,
    this.accountNumber,
    this.referenceNumber,
    this.traceNumber,
    this.balance,
    required this.confidenceScore,
    required this.status,
    required this.dedupKey,
    required this.sourceSmsHash,
    required this.parserVersion,
    this.serverTransactionId,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['sms_id'] = Variable<String>(smsId);
    map['device_id'] = Variable<String>(deviceId);
    map['bank_id'] = Variable<String>(bankId);
    map['bank_code'] = Variable<String>(bankCode);
    map['bank_name'] = Variable<String>(bankName);
    map['type'] = Variable<String>(type);
    map['amount'] = Variable<int>(amount);
    map['currency'] = Variable<String>(currency);
    map['timestamp'] = Variable<DateTime>(timestamp);
    if (!nullToAbsent || cardNumberMasked != null) {
      map['card_number_masked'] = Variable<String>(cardNumberMasked);
    }
    if (!nullToAbsent || accountNumber != null) {
      map['account_number'] = Variable<String>(accountNumber);
    }
    if (!nullToAbsent || referenceNumber != null) {
      map['reference_number'] = Variable<String>(referenceNumber);
    }
    if (!nullToAbsent || traceNumber != null) {
      map['trace_number'] = Variable<String>(traceNumber);
    }
    if (!nullToAbsent || balance != null) {
      map['balance'] = Variable<int>(balance);
    }
    map['confidence_score'] = Variable<double>(confidenceScore);
    map['status'] = Variable<String>(status);
    map['dedup_key'] = Variable<String>(dedupKey);
    map['source_sms_hash'] = Variable<String>(sourceSmsHash);
    map['parser_version'] = Variable<String>(parserVersion);
    if (!nullToAbsent || serverTransactionId != null) {
      map['server_transaction_id'] = Variable<String>(serverTransactionId);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  TransactionsTableCompanion toCompanion(bool nullToAbsent) {
    return TransactionsTableCompanion(
      id: Value(id),
      smsId: Value(smsId),
      deviceId: Value(deviceId),
      bankId: Value(bankId),
      bankCode: Value(bankCode),
      bankName: Value(bankName),
      type: Value(type),
      amount: Value(amount),
      currency: Value(currency),
      timestamp: Value(timestamp),
      cardNumberMasked: cardNumberMasked == null && nullToAbsent
          ? const Value.absent()
          : Value(cardNumberMasked),
      accountNumber: accountNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(accountNumber),
      referenceNumber: referenceNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(referenceNumber),
      traceNumber: traceNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(traceNumber),
      balance: balance == null && nullToAbsent
          ? const Value.absent()
          : Value(balance),
      confidenceScore: Value(confidenceScore),
      status: Value(status),
      dedupKey: Value(dedupKey),
      sourceSmsHash: Value(sourceSmsHash),
      parserVersion: Value(parserVersion),
      serverTransactionId: serverTransactionId == null && nullToAbsent
          ? const Value.absent()
          : Value(serverTransactionId),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory TransactionsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TransactionsTableData(
      id: serializer.fromJson<String>(json['id']),
      smsId: serializer.fromJson<String>(json['smsId']),
      deviceId: serializer.fromJson<String>(json['deviceId']),
      bankId: serializer.fromJson<String>(json['bankId']),
      bankCode: serializer.fromJson<String>(json['bankCode']),
      bankName: serializer.fromJson<String>(json['bankName']),
      type: serializer.fromJson<String>(json['type']),
      amount: serializer.fromJson<int>(json['amount']),
      currency: serializer.fromJson<String>(json['currency']),
      timestamp: serializer.fromJson<DateTime>(json['timestamp']),
      cardNumberMasked: serializer.fromJson<String?>(json['cardNumberMasked']),
      accountNumber: serializer.fromJson<String?>(json['accountNumber']),
      referenceNumber: serializer.fromJson<String?>(json['referenceNumber']),
      traceNumber: serializer.fromJson<String?>(json['traceNumber']),
      balance: serializer.fromJson<int?>(json['balance']),
      confidenceScore: serializer.fromJson<double>(json['confidenceScore']),
      status: serializer.fromJson<String>(json['status']),
      dedupKey: serializer.fromJson<String>(json['dedupKey']),
      sourceSmsHash: serializer.fromJson<String>(json['sourceSmsHash']),
      parserVersion: serializer.fromJson<String>(json['parserVersion']),
      serverTransactionId: serializer.fromJson<String?>(
        json['serverTransactionId'],
      ),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'smsId': serializer.toJson<String>(smsId),
      'deviceId': serializer.toJson<String>(deviceId),
      'bankId': serializer.toJson<String>(bankId),
      'bankCode': serializer.toJson<String>(bankCode),
      'bankName': serializer.toJson<String>(bankName),
      'type': serializer.toJson<String>(type),
      'amount': serializer.toJson<int>(amount),
      'currency': serializer.toJson<String>(currency),
      'timestamp': serializer.toJson<DateTime>(timestamp),
      'cardNumberMasked': serializer.toJson<String?>(cardNumberMasked),
      'accountNumber': serializer.toJson<String?>(accountNumber),
      'referenceNumber': serializer.toJson<String?>(referenceNumber),
      'traceNumber': serializer.toJson<String?>(traceNumber),
      'balance': serializer.toJson<int?>(balance),
      'confidenceScore': serializer.toJson<double>(confidenceScore),
      'status': serializer.toJson<String>(status),
      'dedupKey': serializer.toJson<String>(dedupKey),
      'sourceSmsHash': serializer.toJson<String>(sourceSmsHash),
      'parserVersion': serializer.toJson<String>(parserVersion),
      'serverTransactionId': serializer.toJson<String?>(serverTransactionId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  TransactionsTableData copyWith({
    String? id,
    String? smsId,
    String? deviceId,
    String? bankId,
    String? bankCode,
    String? bankName,
    String? type,
    int? amount,
    String? currency,
    DateTime? timestamp,
    Value<String?> cardNumberMasked = const Value.absent(),
    Value<String?> accountNumber = const Value.absent(),
    Value<String?> referenceNumber = const Value.absent(),
    Value<String?> traceNumber = const Value.absent(),
    Value<int?> balance = const Value.absent(),
    double? confidenceScore,
    String? status,
    String? dedupKey,
    String? sourceSmsHash,
    String? parserVersion,
    Value<String?> serverTransactionId = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => TransactionsTableData(
    id: id ?? this.id,
    smsId: smsId ?? this.smsId,
    deviceId: deviceId ?? this.deviceId,
    bankId: bankId ?? this.bankId,
    bankCode: bankCode ?? this.bankCode,
    bankName: bankName ?? this.bankName,
    type: type ?? this.type,
    amount: amount ?? this.amount,
    currency: currency ?? this.currency,
    timestamp: timestamp ?? this.timestamp,
    cardNumberMasked: cardNumberMasked.present
        ? cardNumberMasked.value
        : this.cardNumberMasked,
    accountNumber: accountNumber.present
        ? accountNumber.value
        : this.accountNumber,
    referenceNumber: referenceNumber.present
        ? referenceNumber.value
        : this.referenceNumber,
    traceNumber: traceNumber.present ? traceNumber.value : this.traceNumber,
    balance: balance.present ? balance.value : this.balance,
    confidenceScore: confidenceScore ?? this.confidenceScore,
    status: status ?? this.status,
    dedupKey: dedupKey ?? this.dedupKey,
    sourceSmsHash: sourceSmsHash ?? this.sourceSmsHash,
    parserVersion: parserVersion ?? this.parserVersion,
    serverTransactionId: serverTransactionId.present
        ? serverTransactionId.value
        : this.serverTransactionId,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  TransactionsTableData copyWithCompanion(TransactionsTableCompanion data) {
    return TransactionsTableData(
      id: data.id.present ? data.id.value : this.id,
      smsId: data.smsId.present ? data.smsId.value : this.smsId,
      deviceId: data.deviceId.present ? data.deviceId.value : this.deviceId,
      bankId: data.bankId.present ? data.bankId.value : this.bankId,
      bankCode: data.bankCode.present ? data.bankCode.value : this.bankCode,
      bankName: data.bankName.present ? data.bankName.value : this.bankName,
      type: data.type.present ? data.type.value : this.type,
      amount: data.amount.present ? data.amount.value : this.amount,
      currency: data.currency.present ? data.currency.value : this.currency,
      timestamp: data.timestamp.present ? data.timestamp.value : this.timestamp,
      cardNumberMasked: data.cardNumberMasked.present
          ? data.cardNumberMasked.value
          : this.cardNumberMasked,
      accountNumber: data.accountNumber.present
          ? data.accountNumber.value
          : this.accountNumber,
      referenceNumber: data.referenceNumber.present
          ? data.referenceNumber.value
          : this.referenceNumber,
      traceNumber: data.traceNumber.present
          ? data.traceNumber.value
          : this.traceNumber,
      balance: data.balance.present ? data.balance.value : this.balance,
      confidenceScore: data.confidenceScore.present
          ? data.confidenceScore.value
          : this.confidenceScore,
      status: data.status.present ? data.status.value : this.status,
      dedupKey: data.dedupKey.present ? data.dedupKey.value : this.dedupKey,
      sourceSmsHash: data.sourceSmsHash.present
          ? data.sourceSmsHash.value
          : this.sourceSmsHash,
      parserVersion: data.parserVersion.present
          ? data.parserVersion.value
          : this.parserVersion,
      serverTransactionId: data.serverTransactionId.present
          ? data.serverTransactionId.value
          : this.serverTransactionId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TransactionsTableData(')
          ..write('id: $id, ')
          ..write('smsId: $smsId, ')
          ..write('deviceId: $deviceId, ')
          ..write('bankId: $bankId, ')
          ..write('bankCode: $bankCode, ')
          ..write('bankName: $bankName, ')
          ..write('type: $type, ')
          ..write('amount: $amount, ')
          ..write('currency: $currency, ')
          ..write('timestamp: $timestamp, ')
          ..write('cardNumberMasked: $cardNumberMasked, ')
          ..write('accountNumber: $accountNumber, ')
          ..write('referenceNumber: $referenceNumber, ')
          ..write('traceNumber: $traceNumber, ')
          ..write('balance: $balance, ')
          ..write('confidenceScore: $confidenceScore, ')
          ..write('status: $status, ')
          ..write('dedupKey: $dedupKey, ')
          ..write('sourceSmsHash: $sourceSmsHash, ')
          ..write('parserVersion: $parserVersion, ')
          ..write('serverTransactionId: $serverTransactionId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    id,
    smsId,
    deviceId,
    bankId,
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
    status,
    dedupKey,
    sourceSmsHash,
    parserVersion,
    serverTransactionId,
    createdAt,
    updatedAt,
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TransactionsTableData &&
          other.id == this.id &&
          other.smsId == this.smsId &&
          other.deviceId == this.deviceId &&
          other.bankId == this.bankId &&
          other.bankCode == this.bankCode &&
          other.bankName == this.bankName &&
          other.type == this.type &&
          other.amount == this.amount &&
          other.currency == this.currency &&
          other.timestamp == this.timestamp &&
          other.cardNumberMasked == this.cardNumberMasked &&
          other.accountNumber == this.accountNumber &&
          other.referenceNumber == this.referenceNumber &&
          other.traceNumber == this.traceNumber &&
          other.balance == this.balance &&
          other.confidenceScore == this.confidenceScore &&
          other.status == this.status &&
          other.dedupKey == this.dedupKey &&
          other.sourceSmsHash == this.sourceSmsHash &&
          other.parserVersion == this.parserVersion &&
          other.serverTransactionId == this.serverTransactionId &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class TransactionsTableCompanion
    extends UpdateCompanion<TransactionsTableData> {
  final Value<String> id;
  final Value<String> smsId;
  final Value<String> deviceId;
  final Value<String> bankId;
  final Value<String> bankCode;
  final Value<String> bankName;
  final Value<String> type;
  final Value<int> amount;
  final Value<String> currency;
  final Value<DateTime> timestamp;
  final Value<String?> cardNumberMasked;
  final Value<String?> accountNumber;
  final Value<String?> referenceNumber;
  final Value<String?> traceNumber;
  final Value<int?> balance;
  final Value<double> confidenceScore;
  final Value<String> status;
  final Value<String> dedupKey;
  final Value<String> sourceSmsHash;
  final Value<String> parserVersion;
  final Value<String?> serverTransactionId;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const TransactionsTableCompanion({
    this.id = const Value.absent(),
    this.smsId = const Value.absent(),
    this.deviceId = const Value.absent(),
    this.bankId = const Value.absent(),
    this.bankCode = const Value.absent(),
    this.bankName = const Value.absent(),
    this.type = const Value.absent(),
    this.amount = const Value.absent(),
    this.currency = const Value.absent(),
    this.timestamp = const Value.absent(),
    this.cardNumberMasked = const Value.absent(),
    this.accountNumber = const Value.absent(),
    this.referenceNumber = const Value.absent(),
    this.traceNumber = const Value.absent(),
    this.balance = const Value.absent(),
    this.confidenceScore = const Value.absent(),
    this.status = const Value.absent(),
    this.dedupKey = const Value.absent(),
    this.sourceSmsHash = const Value.absent(),
    this.parserVersion = const Value.absent(),
    this.serverTransactionId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TransactionsTableCompanion.insert({
    this.id = const Value.absent(),
    required String smsId,
    required String deviceId,
    required String bankId,
    required String bankCode,
    required String bankName,
    required String type,
    required int amount,
    required String currency,
    required DateTime timestamp,
    this.cardNumberMasked = const Value.absent(),
    this.accountNumber = const Value.absent(),
    this.referenceNumber = const Value.absent(),
    this.traceNumber = const Value.absent(),
    this.balance = const Value.absent(),
    required double confidenceScore,
    required String status,
    required String dedupKey,
    required String sourceSmsHash,
    required String parserVersion,
    this.serverTransactionId = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : smsId = Value(smsId),
       deviceId = Value(deviceId),
       bankId = Value(bankId),
       bankCode = Value(bankCode),
       bankName = Value(bankName),
       type = Value(type),
       amount = Value(amount),
       currency = Value(currency),
       timestamp = Value(timestamp),
       confidenceScore = Value(confidenceScore),
       status = Value(status),
       dedupKey = Value(dedupKey),
       sourceSmsHash = Value(sourceSmsHash),
       parserVersion = Value(parserVersion),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<TransactionsTableData> custom({
    Expression<String>? id,
    Expression<String>? smsId,
    Expression<String>? deviceId,
    Expression<String>? bankId,
    Expression<String>? bankCode,
    Expression<String>? bankName,
    Expression<String>? type,
    Expression<int>? amount,
    Expression<String>? currency,
    Expression<DateTime>? timestamp,
    Expression<String>? cardNumberMasked,
    Expression<String>? accountNumber,
    Expression<String>? referenceNumber,
    Expression<String>? traceNumber,
    Expression<int>? balance,
    Expression<double>? confidenceScore,
    Expression<String>? status,
    Expression<String>? dedupKey,
    Expression<String>? sourceSmsHash,
    Expression<String>? parserVersion,
    Expression<String>? serverTransactionId,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (smsId != null) 'sms_id': smsId,
      if (deviceId != null) 'device_id': deviceId,
      if (bankId != null) 'bank_id': bankId,
      if (bankCode != null) 'bank_code': bankCode,
      if (bankName != null) 'bank_name': bankName,
      if (type != null) 'type': type,
      if (amount != null) 'amount': amount,
      if (currency != null) 'currency': currency,
      if (timestamp != null) 'timestamp': timestamp,
      if (cardNumberMasked != null) 'card_number_masked': cardNumberMasked,
      if (accountNumber != null) 'account_number': accountNumber,
      if (referenceNumber != null) 'reference_number': referenceNumber,
      if (traceNumber != null) 'trace_number': traceNumber,
      if (balance != null) 'balance': balance,
      if (confidenceScore != null) 'confidence_score': confidenceScore,
      if (status != null) 'status': status,
      if (dedupKey != null) 'dedup_key': dedupKey,
      if (sourceSmsHash != null) 'source_sms_hash': sourceSmsHash,
      if (parserVersion != null) 'parser_version': parserVersion,
      if (serverTransactionId != null)
        'server_transaction_id': serverTransactionId,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TransactionsTableCompanion copyWith({
    Value<String>? id,
    Value<String>? smsId,
    Value<String>? deviceId,
    Value<String>? bankId,
    Value<String>? bankCode,
    Value<String>? bankName,
    Value<String>? type,
    Value<int>? amount,
    Value<String>? currency,
    Value<DateTime>? timestamp,
    Value<String?>? cardNumberMasked,
    Value<String?>? accountNumber,
    Value<String?>? referenceNumber,
    Value<String?>? traceNumber,
    Value<int?>? balance,
    Value<double>? confidenceScore,
    Value<String>? status,
    Value<String>? dedupKey,
    Value<String>? sourceSmsHash,
    Value<String>? parserVersion,
    Value<String?>? serverTransactionId,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return TransactionsTableCompanion(
      id: id ?? this.id,
      smsId: smsId ?? this.smsId,
      deviceId: deviceId ?? this.deviceId,
      bankId: bankId ?? this.bankId,
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
      status: status ?? this.status,
      dedupKey: dedupKey ?? this.dedupKey,
      sourceSmsHash: sourceSmsHash ?? this.sourceSmsHash,
      parserVersion: parserVersion ?? this.parserVersion,
      serverTransactionId: serverTransactionId ?? this.serverTransactionId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (smsId.present) {
      map['sms_id'] = Variable<String>(smsId.value);
    }
    if (deviceId.present) {
      map['device_id'] = Variable<String>(deviceId.value);
    }
    if (bankId.present) {
      map['bank_id'] = Variable<String>(bankId.value);
    }
    if (bankCode.present) {
      map['bank_code'] = Variable<String>(bankCode.value);
    }
    if (bankName.present) {
      map['bank_name'] = Variable<String>(bankName.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (amount.present) {
      map['amount'] = Variable<int>(amount.value);
    }
    if (currency.present) {
      map['currency'] = Variable<String>(currency.value);
    }
    if (timestamp.present) {
      map['timestamp'] = Variable<DateTime>(timestamp.value);
    }
    if (cardNumberMasked.present) {
      map['card_number_masked'] = Variable<String>(cardNumberMasked.value);
    }
    if (accountNumber.present) {
      map['account_number'] = Variable<String>(accountNumber.value);
    }
    if (referenceNumber.present) {
      map['reference_number'] = Variable<String>(referenceNumber.value);
    }
    if (traceNumber.present) {
      map['trace_number'] = Variable<String>(traceNumber.value);
    }
    if (balance.present) {
      map['balance'] = Variable<int>(balance.value);
    }
    if (confidenceScore.present) {
      map['confidence_score'] = Variable<double>(confidenceScore.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (dedupKey.present) {
      map['dedup_key'] = Variable<String>(dedupKey.value);
    }
    if (sourceSmsHash.present) {
      map['source_sms_hash'] = Variable<String>(sourceSmsHash.value);
    }
    if (parserVersion.present) {
      map['parser_version'] = Variable<String>(parserVersion.value);
    }
    if (serverTransactionId.present) {
      map['server_transaction_id'] = Variable<String>(
        serverTransactionId.value,
      );
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TransactionsTableCompanion(')
          ..write('id: $id, ')
          ..write('smsId: $smsId, ')
          ..write('deviceId: $deviceId, ')
          ..write('bankId: $bankId, ')
          ..write('bankCode: $bankCode, ')
          ..write('bankName: $bankName, ')
          ..write('type: $type, ')
          ..write('amount: $amount, ')
          ..write('currency: $currency, ')
          ..write('timestamp: $timestamp, ')
          ..write('cardNumberMasked: $cardNumberMasked, ')
          ..write('accountNumber: $accountNumber, ')
          ..write('referenceNumber: $referenceNumber, ')
          ..write('traceNumber: $traceNumber, ')
          ..write('balance: $balance, ')
          ..write('confidenceScore: $confidenceScore, ')
          ..write('status: $status, ')
          ..write('dedupKey: $dedupKey, ')
          ..write('sourceSmsHash: $sourceSmsHash, ')
          ..write('parserVersion: $parserVersion, ')
          ..write('serverTransactionId: $serverTransactionId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PendingTransactionsTableTable extends PendingTransactionsTable
    with
        TableInfo<
          $PendingTransactionsTableTable,
          PendingTransactionsTableData
        > {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PendingTransactionsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: () => '',
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<int> amount = GeneratedColumn<int>(
    'amount',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _currencyMeta = const VerificationMeta(
    'currency',
  );
  @override
  late final GeneratedColumn<String> currency = GeneratedColumn<String>(
    'currency',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _bankCodeMeta = const VerificationMeta(
    'bankCode',
  );
  @override
  late final GeneratedColumn<String> bankCode = GeneratedColumn<String>(
    'bank_code',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _cardHintMeta = const VerificationMeta(
    'cardHint',
  );
  @override
  late final GeneratedColumn<String> cardHint = GeneratedColumn<String>(
    'card_hint',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _referenceHintMeta = const VerificationMeta(
    'referenceHint',
  );
  @override
  late final GeneratedColumn<String> referenceHint = GeneratedColumn<String>(
    'reference_hint',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _validFromMeta = const VerificationMeta(
    'validFrom',
  );
  @override
  late final GeneratedColumn<DateTime> validFrom = GeneratedColumn<DateTime>(
    'valid_from',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _validUntilMeta = const VerificationMeta(
    'validUntil',
  );
  @override
  late final GeneratedColumn<DateTime> validUntil = GeneratedColumn<DateTime>(
    'valid_until',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    title,
    type,
    amount,
    currency,
    bankCode,
    cardHint,
    referenceHint,
    validFrom,
    validUntil,
    status,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'pending_transactions';
  @override
  VerificationContext validateIntegrity(
    Insertable<PendingTransactionsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('currency')) {
      context.handle(
        _currencyMeta,
        currency.isAcceptableOrUnknown(data['currency']!, _currencyMeta),
      );
    } else if (isInserting) {
      context.missing(_currencyMeta);
    }
    if (data.containsKey('bank_code')) {
      context.handle(
        _bankCodeMeta,
        bankCode.isAcceptableOrUnknown(data['bank_code']!, _bankCodeMeta),
      );
    }
    if (data.containsKey('card_hint')) {
      context.handle(
        _cardHintMeta,
        cardHint.isAcceptableOrUnknown(data['card_hint']!, _cardHintMeta),
      );
    }
    if (data.containsKey('reference_hint')) {
      context.handle(
        _referenceHintMeta,
        referenceHint.isAcceptableOrUnknown(
          data['reference_hint']!,
          _referenceHintMeta,
        ),
      );
    }
    if (data.containsKey('valid_from')) {
      context.handle(
        _validFromMeta,
        validFrom.isAcceptableOrUnknown(data['valid_from']!, _validFromMeta),
      );
    }
    if (data.containsKey('valid_until')) {
      context.handle(
        _validUntilMeta,
        validUntil.isAcceptableOrUnknown(data['valid_until']!, _validUntilMeta),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PendingTransactionsTableData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PendingTransactionsTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}amount'],
      )!,
      currency: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}currency'],
      )!,
      bankCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}bank_code'],
      ),
      cardHint: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}card_hint'],
      ),
      referenceHint: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reference_hint'],
      ),
      validFrom: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}valid_from'],
      ),
      validUntil: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}valid_until'],
      ),
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $PendingTransactionsTableTable createAlias(String alias) {
    return $PendingTransactionsTableTable(attachedDatabase, alias);
  }
}

class PendingTransactionsTableData extends DataClass
    implements Insertable<PendingTransactionsTableData> {
  /// Primary key — [PendingTransaction.id], the BACKEND identifier
  /// (not a local UUID). TEXT; rows arrive by sync with their ids.
  final String id;

  /// Display label authored on the backend (e.g.
  /// 'سفارش ۱۲۳۴ — علی'). Plain TEXT.
  final String title;

  /// Wire name of TransactionType ('deposit', ...) — model marshals.
  final String type;

  /// Expected amount in the smallest unit (rials) — non-negative
  /// integer; sign implied by type.
  final int amount;

  /// ISO-4217 style code ('IRR') — model marshals.
  final String currency;

  /// Optional bank constraint ([Bank.code]) — null = any bank.
  final String? bankCode;

  /// Optional masked-form / last-digits hint for CardMatcher —
  /// null = unconstrained.
  final String? cardHint;

  /// Optional reference hint, verbatim — null = unconstrained.
  final String? referenceHint;

  /// Window start (UTC) — null = no lower bound.
  final DateTime? validFrom;

  /// Window deadline (UTC) — null = no upper bound.
  final DateTime? validUntil;

  /// Wire name of PendingTransactionStatus ('active' |
  /// 'fulfilled' | 'cancelled') — model marshals. NO 'expired'
  /// value exists (Phase 02: expiry is a time-window judgment
  /// owned by TimeMatcher, not a standing).
  final String status;

  /// Backend creation time (UTC).
  final DateTime createdAt;

  /// Last change (UTC) — backend edits AND local standing
  /// mutations (approved match → fulfilled).
  final DateTime updatedAt;
  const PendingTransactionsTableData({
    required this.id,
    required this.title,
    required this.type,
    required this.amount,
    required this.currency,
    this.bankCode,
    this.cardHint,
    this.referenceHint,
    this.validFrom,
    this.validUntil,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    map['type'] = Variable<String>(type);
    map['amount'] = Variable<int>(amount);
    map['currency'] = Variable<String>(currency);
    if (!nullToAbsent || bankCode != null) {
      map['bank_code'] = Variable<String>(bankCode);
    }
    if (!nullToAbsent || cardHint != null) {
      map['card_hint'] = Variable<String>(cardHint);
    }
    if (!nullToAbsent || referenceHint != null) {
      map['reference_hint'] = Variable<String>(referenceHint);
    }
    if (!nullToAbsent || validFrom != null) {
      map['valid_from'] = Variable<DateTime>(validFrom);
    }
    if (!nullToAbsent || validUntil != null) {
      map['valid_until'] = Variable<DateTime>(validUntil);
    }
    map['status'] = Variable<String>(status);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  PendingTransactionsTableCompanion toCompanion(bool nullToAbsent) {
    return PendingTransactionsTableCompanion(
      id: Value(id),
      title: Value(title),
      type: Value(type),
      amount: Value(amount),
      currency: Value(currency),
      bankCode: bankCode == null && nullToAbsent
          ? const Value.absent()
          : Value(bankCode),
      cardHint: cardHint == null && nullToAbsent
          ? const Value.absent()
          : Value(cardHint),
      referenceHint: referenceHint == null && nullToAbsent
          ? const Value.absent()
          : Value(referenceHint),
      validFrom: validFrom == null && nullToAbsent
          ? const Value.absent()
          : Value(validFrom),
      validUntil: validUntil == null && nullToAbsent
          ? const Value.absent()
          : Value(validUntil),
      status: Value(status),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory PendingTransactionsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PendingTransactionsTableData(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      type: serializer.fromJson<String>(json['type']),
      amount: serializer.fromJson<int>(json['amount']),
      currency: serializer.fromJson<String>(json['currency']),
      bankCode: serializer.fromJson<String?>(json['bankCode']),
      cardHint: serializer.fromJson<String?>(json['cardHint']),
      referenceHint: serializer.fromJson<String?>(json['referenceHint']),
      validFrom: serializer.fromJson<DateTime?>(json['validFrom']),
      validUntil: serializer.fromJson<DateTime?>(json['validUntil']),
      status: serializer.fromJson<String>(json['status']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'type': serializer.toJson<String>(type),
      'amount': serializer.toJson<int>(amount),
      'currency': serializer.toJson<String>(currency),
      'bankCode': serializer.toJson<String?>(bankCode),
      'cardHint': serializer.toJson<String?>(cardHint),
      'referenceHint': serializer.toJson<String?>(referenceHint),
      'validFrom': serializer.toJson<DateTime?>(validFrom),
      'validUntil': serializer.toJson<DateTime?>(validUntil),
      'status': serializer.toJson<String>(status),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  PendingTransactionsTableData copyWith({
    String? id,
    String? title,
    String? type,
    int? amount,
    String? currency,
    Value<String?> bankCode = const Value.absent(),
    Value<String?> cardHint = const Value.absent(),
    Value<String?> referenceHint = const Value.absent(),
    Value<DateTime?> validFrom = const Value.absent(),
    Value<DateTime?> validUntil = const Value.absent(),
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => PendingTransactionsTableData(
    id: id ?? this.id,
    title: title ?? this.title,
    type: type ?? this.type,
    amount: amount ?? this.amount,
    currency: currency ?? this.currency,
    bankCode: bankCode.present ? bankCode.value : this.bankCode,
    cardHint: cardHint.present ? cardHint.value : this.cardHint,
    referenceHint: referenceHint.present
        ? referenceHint.value
        : this.referenceHint,
    validFrom: validFrom.present ? validFrom.value : this.validFrom,
    validUntil: validUntil.present ? validUntil.value : this.validUntil,
    status: status ?? this.status,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  PendingTransactionsTableData copyWithCompanion(
    PendingTransactionsTableCompanion data,
  ) {
    return PendingTransactionsTableData(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      type: data.type.present ? data.type.value : this.type,
      amount: data.amount.present ? data.amount.value : this.amount,
      currency: data.currency.present ? data.currency.value : this.currency,
      bankCode: data.bankCode.present ? data.bankCode.value : this.bankCode,
      cardHint: data.cardHint.present ? data.cardHint.value : this.cardHint,
      referenceHint: data.referenceHint.present
          ? data.referenceHint.value
          : this.referenceHint,
      validFrom: data.validFrom.present ? data.validFrom.value : this.validFrom,
      validUntil: data.validUntil.present
          ? data.validUntil.value
          : this.validUntil,
      status: data.status.present ? data.status.value : this.status,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PendingTransactionsTableData(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('type: $type, ')
          ..write('amount: $amount, ')
          ..write('currency: $currency, ')
          ..write('bankCode: $bankCode, ')
          ..write('cardHint: $cardHint, ')
          ..write('referenceHint: $referenceHint, ')
          ..write('validFrom: $validFrom, ')
          ..write('validUntil: $validUntil, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    title,
    type,
    amount,
    currency,
    bankCode,
    cardHint,
    referenceHint,
    validFrom,
    validUntil,
    status,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PendingTransactionsTableData &&
          other.id == this.id &&
          other.title == this.title &&
          other.type == this.type &&
          other.amount == this.amount &&
          other.currency == this.currency &&
          other.bankCode == this.bankCode &&
          other.cardHint == this.cardHint &&
          other.referenceHint == this.referenceHint &&
          other.validFrom == this.validFrom &&
          other.validUntil == this.validUntil &&
          other.status == this.status &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class PendingTransactionsTableCompanion
    extends UpdateCompanion<PendingTransactionsTableData> {
  final Value<String> id;
  final Value<String> title;
  final Value<String> type;
  final Value<int> amount;
  final Value<String> currency;
  final Value<String?> bankCode;
  final Value<String?> cardHint;
  final Value<String?> referenceHint;
  final Value<DateTime?> validFrom;
  final Value<DateTime?> validUntil;
  final Value<String> status;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const PendingTransactionsTableCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.type = const Value.absent(),
    this.amount = const Value.absent(),
    this.currency = const Value.absent(),
    this.bankCode = const Value.absent(),
    this.cardHint = const Value.absent(),
    this.referenceHint = const Value.absent(),
    this.validFrom = const Value.absent(),
    this.validUntil = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PendingTransactionsTableCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    required String type,
    required int amount,
    required String currency,
    this.bankCode = const Value.absent(),
    this.cardHint = const Value.absent(),
    this.referenceHint = const Value.absent(),
    this.validFrom = const Value.absent(),
    this.validUntil = const Value.absent(),
    required String status,
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : title = Value(title),
       type = Value(type),
       amount = Value(amount),
       currency = Value(currency),
       status = Value(status),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<PendingTransactionsTableData> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<String>? type,
    Expression<int>? amount,
    Expression<String>? currency,
    Expression<String>? bankCode,
    Expression<String>? cardHint,
    Expression<String>? referenceHint,
    Expression<DateTime>? validFrom,
    Expression<DateTime>? validUntil,
    Expression<String>? status,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (type != null) 'type': type,
      if (amount != null) 'amount': amount,
      if (currency != null) 'currency': currency,
      if (bankCode != null) 'bank_code': bankCode,
      if (cardHint != null) 'card_hint': cardHint,
      if (referenceHint != null) 'reference_hint': referenceHint,
      if (validFrom != null) 'valid_from': validFrom,
      if (validUntil != null) 'valid_until': validUntil,
      if (status != null) 'status': status,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PendingTransactionsTableCompanion copyWith({
    Value<String>? id,
    Value<String>? title,
    Value<String>? type,
    Value<int>? amount,
    Value<String>? currency,
    Value<String?>? bankCode,
    Value<String?>? cardHint,
    Value<String?>? referenceHint,
    Value<DateTime?>? validFrom,
    Value<DateTime?>? validUntil,
    Value<String>? status,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return PendingTransactionsTableCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      type: type ?? this.type,
      amount: amount ?? this.amount,
      currency: currency ?? this.currency,
      bankCode: bankCode ?? this.bankCode,
      cardHint: cardHint ?? this.cardHint,
      referenceHint: referenceHint ?? this.referenceHint,
      validFrom: validFrom ?? this.validFrom,
      validUntil: validUntil ?? this.validUntil,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (amount.present) {
      map['amount'] = Variable<int>(amount.value);
    }
    if (currency.present) {
      map['currency'] = Variable<String>(currency.value);
    }
    if (bankCode.present) {
      map['bank_code'] = Variable<String>(bankCode.value);
    }
    if (cardHint.present) {
      map['card_hint'] = Variable<String>(cardHint.value);
    }
    if (referenceHint.present) {
      map['reference_hint'] = Variable<String>(referenceHint.value);
    }
    if (validFrom.present) {
      map['valid_from'] = Variable<DateTime>(validFrom.value);
    }
    if (validUntil.present) {
      map['valid_until'] = Variable<DateTime>(validUntil.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PendingTransactionsTableCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('type: $type, ')
          ..write('amount: $amount, ')
          ..write('currency: $currency, ')
          ..write('bankCode: $bankCode, ')
          ..write('cardHint: $cardHint, ')
          ..write('referenceHint: $referenceHint, ')
          ..write('validFrom: $validFrom, ')
          ..write('validUntil: $validUntil, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MatchingRecordsTableTable extends MatchingRecordsTable
    with TableInfo<$MatchingRecordsTableTable, MatchingRecordsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MatchingRecordsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: () => '',
  );
  static const VerificationMeta _transactionIdMeta = const VerificationMeta(
    'transactionId',
  );
  @override
  late final GeneratedColumn<String> transactionId = GeneratedColumn<String>(
    'transaction_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _pendingTransactionIdMeta =
      const VerificationMeta('pendingTransactionId');
  @override
  late final GeneratedColumn<String> pendingTransactionId =
      GeneratedColumn<String>(
        'pending_transaction_id',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _matchStatusMeta = const VerificationMeta(
    'matchStatus',
  );
  @override
  late final GeneratedColumn<String> matchStatus = GeneratedColumn<String>(
    'match_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _scoreMeta = const VerificationMeta('score');
  @override
  late final GeneratedColumn<double> score = GeneratedColumn<double>(
    'score',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _payloadMeta = const VerificationMeta(
    'payload',
  );
  @override
  late final GeneratedColumn<String> payload = GeneratedColumn<String>(
    'payload',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('{}'),
  );
  static const VerificationMeta _decisionSourceMeta = const VerificationMeta(
    'decisionSource',
  );
  @override
  late final GeneratedColumn<String> decisionSource = GeneratedColumn<String>(
    'decision_source',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('engine'),
  );
  static const VerificationMeta _decidedByMeta = const VerificationMeta(
    'decidedBy',
  );
  @override
  late final GeneratedColumn<String> decidedBy = GeneratedColumn<String>(
    'decided_by',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _decidedAtMeta = const VerificationMeta(
    'decidedAt',
  );
  @override
  late final GeneratedColumn<DateTime> decidedAt = GeneratedColumn<DateTime>(
    'decided_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    transactionId,
    pendingTransactionId,
    matchStatus,
    score,
    payload,
    decisionSource,
    decidedBy,
    decidedAt,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'matching_records';
  @override
  VerificationContext validateIntegrity(
    Insertable<MatchingRecordsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('transaction_id')) {
      context.handle(
        _transactionIdMeta,
        transactionId.isAcceptableOrUnknown(
          data['transaction_id']!,
          _transactionIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_transactionIdMeta);
    }
    if (data.containsKey('pending_transaction_id')) {
      context.handle(
        _pendingTransactionIdMeta,
        pendingTransactionId.isAcceptableOrUnknown(
          data['pending_transaction_id']!,
          _pendingTransactionIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_pendingTransactionIdMeta);
    }
    if (data.containsKey('match_status')) {
      context.handle(
        _matchStatusMeta,
        matchStatus.isAcceptableOrUnknown(
          data['match_status']!,
          _matchStatusMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_matchStatusMeta);
    }
    if (data.containsKey('score')) {
      context.handle(
        _scoreMeta,
        score.isAcceptableOrUnknown(data['score']!, _scoreMeta),
      );
    } else if (isInserting) {
      context.missing(_scoreMeta);
    }
    if (data.containsKey('payload')) {
      context.handle(
        _payloadMeta,
        payload.isAcceptableOrUnknown(data['payload']!, _payloadMeta),
      );
    }
    if (data.containsKey('decision_source')) {
      context.handle(
        _decisionSourceMeta,
        decisionSource.isAcceptableOrUnknown(
          data['decision_source']!,
          _decisionSourceMeta,
        ),
      );
    }
    if (data.containsKey('decided_by')) {
      context.handle(
        _decidedByMeta,
        decidedBy.isAcceptableOrUnknown(data['decided_by']!, _decidedByMeta),
      );
    }
    if (data.containsKey('decided_at')) {
      context.handle(
        _decidedAtMeta,
        decidedAt.isAcceptableOrUnknown(data['decided_at']!, _decidedAtMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {transactionId, pendingTransactionId},
  ];
  @override
  MatchingRecordsTableData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MatchingRecordsTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      transactionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}transaction_id'],
      )!,
      pendingTransactionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}pending_transaction_id'],
      )!,
      matchStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}match_status'],
      )!,
      score: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}score'],
      )!,
      payload: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payload'],
      )!,
      decisionSource: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}decision_source'],
      )!,
      decidedBy: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}decided_by'],
      ),
      decidedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}decided_at'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $MatchingRecordsTableTable createAlias(String alias) {
    return $MatchingRecordsTableTable(attachedDatabase, alias);
  }
}

class MatchingRecordsTableData extends DataClass
    implements Insertable<MatchingRecordsTableData> {
  /// Primary key — locally generated UUID (match rows are
  /// local-origin records). TEXT, not auto-increment.
  final String id;

  /// The evaluated financial record — transactions.id. SOFT
  /// reference (no FK): see the class doc comment.
  final String transactionId;

  /// The evaluated expectation — pending_transactions.id. SOFT
  /// reference (no FK): backend-owned mirror, match history
  /// outlives cancellations.
  final String pendingTransactionId;

  /// Wire name of the match status ('matched' | 'needs_review' |
  /// 'rejected') — model marshals. Ambiguity lands here as
  /// needs_review, never auto-resolved.
  final String matchStatus;

  /// Engine confidence for this pair, 0.0..1.0 — deterministic
  /// matcher output (the matching feature phase owns the formula).
  final double score;

  /// Safe JSON payload — per-matcher scores, competing candidate
  /// ids, masked hints. Never raw SMS / unmasked values.
  final String payload;

  /// Who set the current status — 'engine' (auto evaluation) |
  /// 'admin' (review decision). Model marshals.
  final String decisionSource;

  /// Acting admin user id — set only on review decisions
  /// (approve/reject/resolve); null on engine-evaluated rows.
  final String? decidedBy;

  /// Decision time (UTC) — null on engine-evaluated rows.
  final DateTime? decidedAt;

  /// First evaluation time (UTC).
  final DateTime createdAt;

  /// Last status/payload mutation (UTC) — re-runs UPDATE this row,
  /// never duplicate it (pair uniqueness).
  final DateTime updatedAt;
  const MatchingRecordsTableData({
    required this.id,
    required this.transactionId,
    required this.pendingTransactionId,
    required this.matchStatus,
    required this.score,
    required this.payload,
    required this.decisionSource,
    this.decidedBy,
    this.decidedAt,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['transaction_id'] = Variable<String>(transactionId);
    map['pending_transaction_id'] = Variable<String>(pendingTransactionId);
    map['match_status'] = Variable<String>(matchStatus);
    map['score'] = Variable<double>(score);
    map['payload'] = Variable<String>(payload);
    map['decision_source'] = Variable<String>(decisionSource);
    if (!nullToAbsent || decidedBy != null) {
      map['decided_by'] = Variable<String>(decidedBy);
    }
    if (!nullToAbsent || decidedAt != null) {
      map['decided_at'] = Variable<DateTime>(decidedAt);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  MatchingRecordsTableCompanion toCompanion(bool nullToAbsent) {
    return MatchingRecordsTableCompanion(
      id: Value(id),
      transactionId: Value(transactionId),
      pendingTransactionId: Value(pendingTransactionId),
      matchStatus: Value(matchStatus),
      score: Value(score),
      payload: Value(payload),
      decisionSource: Value(decisionSource),
      decidedBy: decidedBy == null && nullToAbsent
          ? const Value.absent()
          : Value(decidedBy),
      decidedAt: decidedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(decidedAt),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory MatchingRecordsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MatchingRecordsTableData(
      id: serializer.fromJson<String>(json['id']),
      transactionId: serializer.fromJson<String>(json['transactionId']),
      pendingTransactionId: serializer.fromJson<String>(
        json['pendingTransactionId'],
      ),
      matchStatus: serializer.fromJson<String>(json['matchStatus']),
      score: serializer.fromJson<double>(json['score']),
      payload: serializer.fromJson<String>(json['payload']),
      decisionSource: serializer.fromJson<String>(json['decisionSource']),
      decidedBy: serializer.fromJson<String?>(json['decidedBy']),
      decidedAt: serializer.fromJson<DateTime?>(json['decidedAt']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'transactionId': serializer.toJson<String>(transactionId),
      'pendingTransactionId': serializer.toJson<String>(pendingTransactionId),
      'matchStatus': serializer.toJson<String>(matchStatus),
      'score': serializer.toJson<double>(score),
      'payload': serializer.toJson<String>(payload),
      'decisionSource': serializer.toJson<String>(decisionSource),
      'decidedBy': serializer.toJson<String?>(decidedBy),
      'decidedAt': serializer.toJson<DateTime?>(decidedAt),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  MatchingRecordsTableData copyWith({
    String? id,
    String? transactionId,
    String? pendingTransactionId,
    String? matchStatus,
    double? score,
    String? payload,
    String? decisionSource,
    Value<String?> decidedBy = const Value.absent(),
    Value<DateTime?> decidedAt = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => MatchingRecordsTableData(
    id: id ?? this.id,
    transactionId: transactionId ?? this.transactionId,
    pendingTransactionId: pendingTransactionId ?? this.pendingTransactionId,
    matchStatus: matchStatus ?? this.matchStatus,
    score: score ?? this.score,
    payload: payload ?? this.payload,
    decisionSource: decisionSource ?? this.decisionSource,
    decidedBy: decidedBy.present ? decidedBy.value : this.decidedBy,
    decidedAt: decidedAt.present ? decidedAt.value : this.decidedAt,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  MatchingRecordsTableData copyWithCompanion(
    MatchingRecordsTableCompanion data,
  ) {
    return MatchingRecordsTableData(
      id: data.id.present ? data.id.value : this.id,
      transactionId: data.transactionId.present
          ? data.transactionId.value
          : this.transactionId,
      pendingTransactionId: data.pendingTransactionId.present
          ? data.pendingTransactionId.value
          : this.pendingTransactionId,
      matchStatus: data.matchStatus.present
          ? data.matchStatus.value
          : this.matchStatus,
      score: data.score.present ? data.score.value : this.score,
      payload: data.payload.present ? data.payload.value : this.payload,
      decisionSource: data.decisionSource.present
          ? data.decisionSource.value
          : this.decisionSource,
      decidedBy: data.decidedBy.present ? data.decidedBy.value : this.decidedBy,
      decidedAt: data.decidedAt.present ? data.decidedAt.value : this.decidedAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MatchingRecordsTableData(')
          ..write('id: $id, ')
          ..write('transactionId: $transactionId, ')
          ..write('pendingTransactionId: $pendingTransactionId, ')
          ..write('matchStatus: $matchStatus, ')
          ..write('score: $score, ')
          ..write('payload: $payload, ')
          ..write('decisionSource: $decisionSource, ')
          ..write('decidedBy: $decidedBy, ')
          ..write('decidedAt: $decidedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    transactionId,
    pendingTransactionId,
    matchStatus,
    score,
    payload,
    decisionSource,
    decidedBy,
    decidedAt,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MatchingRecordsTableData &&
          other.id == this.id &&
          other.transactionId == this.transactionId &&
          other.pendingTransactionId == this.pendingTransactionId &&
          other.matchStatus == this.matchStatus &&
          other.score == this.score &&
          other.payload == this.payload &&
          other.decisionSource == this.decisionSource &&
          other.decidedBy == this.decidedBy &&
          other.decidedAt == this.decidedAt &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class MatchingRecordsTableCompanion
    extends UpdateCompanion<MatchingRecordsTableData> {
  final Value<String> id;
  final Value<String> transactionId;
  final Value<String> pendingTransactionId;
  final Value<String> matchStatus;
  final Value<double> score;
  final Value<String> payload;
  final Value<String> decisionSource;
  final Value<String?> decidedBy;
  final Value<DateTime?> decidedAt;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const MatchingRecordsTableCompanion({
    this.id = const Value.absent(),
    this.transactionId = const Value.absent(),
    this.pendingTransactionId = const Value.absent(),
    this.matchStatus = const Value.absent(),
    this.score = const Value.absent(),
    this.payload = const Value.absent(),
    this.decisionSource = const Value.absent(),
    this.decidedBy = const Value.absent(),
    this.decidedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MatchingRecordsTableCompanion.insert({
    this.id = const Value.absent(),
    required String transactionId,
    required String pendingTransactionId,
    required String matchStatus,
    required double score,
    this.payload = const Value.absent(),
    this.decisionSource = const Value.absent(),
    this.decidedBy = const Value.absent(),
    this.decidedAt = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : transactionId = Value(transactionId),
       pendingTransactionId = Value(pendingTransactionId),
       matchStatus = Value(matchStatus),
       score = Value(score),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<MatchingRecordsTableData> custom({
    Expression<String>? id,
    Expression<String>? transactionId,
    Expression<String>? pendingTransactionId,
    Expression<String>? matchStatus,
    Expression<double>? score,
    Expression<String>? payload,
    Expression<String>? decisionSource,
    Expression<String>? decidedBy,
    Expression<DateTime>? decidedAt,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (transactionId != null) 'transaction_id': transactionId,
      if (pendingTransactionId != null)
        'pending_transaction_id': pendingTransactionId,
      if (matchStatus != null) 'match_status': matchStatus,
      if (score != null) 'score': score,
      if (payload != null) 'payload': payload,
      if (decisionSource != null) 'decision_source': decisionSource,
      if (decidedBy != null) 'decided_by': decidedBy,
      if (decidedAt != null) 'decided_at': decidedAt,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MatchingRecordsTableCompanion copyWith({
    Value<String>? id,
    Value<String>? transactionId,
    Value<String>? pendingTransactionId,
    Value<String>? matchStatus,
    Value<double>? score,
    Value<String>? payload,
    Value<String>? decisionSource,
    Value<String?>? decidedBy,
    Value<DateTime?>? decidedAt,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return MatchingRecordsTableCompanion(
      id: id ?? this.id,
      transactionId: transactionId ?? this.transactionId,
      pendingTransactionId: pendingTransactionId ?? this.pendingTransactionId,
      matchStatus: matchStatus ?? this.matchStatus,
      score: score ?? this.score,
      payload: payload ?? this.payload,
      decisionSource: decisionSource ?? this.decisionSource,
      decidedBy: decidedBy ?? this.decidedBy,
      decidedAt: decidedAt ?? this.decidedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (transactionId.present) {
      map['transaction_id'] = Variable<String>(transactionId.value);
    }
    if (pendingTransactionId.present) {
      map['pending_transaction_id'] = Variable<String>(
        pendingTransactionId.value,
      );
    }
    if (matchStatus.present) {
      map['match_status'] = Variable<String>(matchStatus.value);
    }
    if (score.present) {
      map['score'] = Variable<double>(score.value);
    }
    if (payload.present) {
      map['payload'] = Variable<String>(payload.value);
    }
    if (decisionSource.present) {
      map['decision_source'] = Variable<String>(decisionSource.value);
    }
    if (decidedBy.present) {
      map['decided_by'] = Variable<String>(decidedBy.value);
    }
    if (decidedAt.present) {
      map['decided_at'] = Variable<DateTime>(decidedAt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MatchingRecordsTableCompanion(')
          ..write('id: $id, ')
          ..write('transactionId: $transactionId, ')
          ..write('pendingTransactionId: $pendingTransactionId, ')
          ..write('matchStatus: $matchStatus, ')
          ..write('score: $score, ')
          ..write('payload: $payload, ')
          ..write('decisionSource: $decisionSource, ')
          ..write('decidedBy: $decidedBy, ')
          ..write('decidedAt: $decidedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SyncQueueTableTable extends SyncQueueTable
    with TableInfo<$SyncQueueTableTable, SyncQueueTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SyncQueueTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: () => '',
  );
  static const VerificationMeta _entityTypeMeta = const VerificationMeta(
    'entityType',
  );
  @override
  late final GeneratedColumn<String> entityType = GeneratedColumn<String>(
    'entity_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _entityIdMeta = const VerificationMeta(
    'entityId',
  );
  @override
  late final GeneratedColumn<String> entityId = GeneratedColumn<String>(
    'entity_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _operationMeta = const VerificationMeta(
    'operation',
  );
  @override
  late final GeneratedColumn<String> operation = GeneratedColumn<String>(
    'operation',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _payloadMeta = const VerificationMeta(
    'payload',
  );
  @override
  late final GeneratedColumn<String> payload = GeneratedColumn<String>(
    'payload',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _payloadVersionMeta = const VerificationMeta(
    'payloadVersion',
  );
  @override
  late final GeneratedColumn<int> payloadVersion = GeneratedColumn<int>(
    'payload_version',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _retryCountMeta = const VerificationMeta(
    'retryCount',
  );
  @override
  late final GeneratedColumn<int> retryCount = GeneratedColumn<int>(
    'retry_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _nextRetryAtMeta = const VerificationMeta(
    'nextRetryAt',
  );
  @override
  late final GeneratedColumn<DateTime> nextRetryAt = GeneratedColumn<DateTime>(
    'next_retry_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _failureClassMeta = const VerificationMeta(
    'failureClass',
  );
  @override
  late final GeneratedColumn<String> failureClass = GeneratedColumn<String>(
    'failure_class',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lastErrorMeta = const VerificationMeta(
    'lastError',
  );
  @override
  late final GeneratedColumn<String> lastError = GeneratedColumn<String>(
    'last_error',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _attemptStartedAtMeta = const VerificationMeta(
    'attemptStartedAt',
  );
  @override
  late final GeneratedColumn<DateTime> attemptStartedAt =
      GeneratedColumn<DateTime>(
        'attempt_started_at',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _completedAtMeta = const VerificationMeta(
    'completedAt',
  );
  @override
  late final GeneratedColumn<DateTime> completedAt = GeneratedColumn<DateTime>(
    'completed_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    entityType,
    entityId,
    operation,
    payload,
    payloadVersion,
    status,
    retryCount,
    nextRetryAt,
    failureClass,
    lastError,
    attemptStartedAt,
    completedAt,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sync_queue';
  @override
  VerificationContext validateIntegrity(
    Insertable<SyncQueueTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('entity_type')) {
      context.handle(
        _entityTypeMeta,
        entityType.isAcceptableOrUnknown(data['entity_type']!, _entityTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_entityTypeMeta);
    }
    if (data.containsKey('entity_id')) {
      context.handle(
        _entityIdMeta,
        entityId.isAcceptableOrUnknown(data['entity_id']!, _entityIdMeta),
      );
    } else if (isInserting) {
      context.missing(_entityIdMeta);
    }
    if (data.containsKey('operation')) {
      context.handle(
        _operationMeta,
        operation.isAcceptableOrUnknown(data['operation']!, _operationMeta),
      );
    } else if (isInserting) {
      context.missing(_operationMeta);
    }
    if (data.containsKey('payload')) {
      context.handle(
        _payloadMeta,
        payload.isAcceptableOrUnknown(data['payload']!, _payloadMeta),
      );
    } else if (isInserting) {
      context.missing(_payloadMeta);
    }
    if (data.containsKey('payload_version')) {
      context.handle(
        _payloadVersionMeta,
        payloadVersion.isAcceptableOrUnknown(
          data['payload_version']!,
          _payloadVersionMeta,
        ),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('retry_count')) {
      context.handle(
        _retryCountMeta,
        retryCount.isAcceptableOrUnknown(data['retry_count']!, _retryCountMeta),
      );
    }
    if (data.containsKey('next_retry_at')) {
      context.handle(
        _nextRetryAtMeta,
        nextRetryAt.isAcceptableOrUnknown(
          data['next_retry_at']!,
          _nextRetryAtMeta,
        ),
      );
    }
    if (data.containsKey('failure_class')) {
      context.handle(
        _failureClassMeta,
        failureClass.isAcceptableOrUnknown(
          data['failure_class']!,
          _failureClassMeta,
        ),
      );
    }
    if (data.containsKey('last_error')) {
      context.handle(
        _lastErrorMeta,
        lastError.isAcceptableOrUnknown(data['last_error']!, _lastErrorMeta),
      );
    }
    if (data.containsKey('attempt_started_at')) {
      context.handle(
        _attemptStartedAtMeta,
        attemptStartedAt.isAcceptableOrUnknown(
          data['attempt_started_at']!,
          _attemptStartedAtMeta,
        ),
      );
    }
    if (data.containsKey('completed_at')) {
      context.handle(
        _completedAtMeta,
        completedAt.isAcceptableOrUnknown(
          data['completed_at']!,
          _completedAtMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SyncQueueTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SyncQueueTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      entityType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}entity_type'],
      )!,
      entityId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}entity_id'],
      )!,
      operation: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}operation'],
      )!,
      payload: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payload'],
      )!,
      payloadVersion: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}payload_version'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      retryCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}retry_count'],
      )!,
      nextRetryAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}next_retry_at'],
      ),
      failureClass: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}failure_class'],
      ),
      lastError: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_error'],
      ),
      attemptStartedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}attempt_started_at'],
      ),
      completedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}completed_at'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $SyncQueueTableTable createAlias(String alias) {
    return $SyncQueueTableTable(attachedDatabase, alias);
  }
}

class SyncQueueTableData extends DataClass
    implements Insertable<SyncQueueTableData> {
  /// Primary key — [SyncQueueItem.id], locally generated UUID. The
  /// operation idempotency handle of the sync path. TEXT, not
  /// auto-increment.
  final String id;

  /// Snake-case entity discriminator ('transaction' |
  /// 'pending_transaction' | future kinds). Unknown kinds:
  /// log + skip — never crash the queue.
  final String entityType;

  /// Local id of the carried record — together with [entityType]
  /// the polymorphic address (no FK; see the class doc comment).
  final String entityId;

  /// Wire name of SyncOperation ('create' | 'update') — the
  /// upsert-only vocabulary. Model marshals.
  final String operation;

  /// Immutable marshaled JSON body — byte-identical replays.
  /// TEXT (JSON string), never re-marshaled between attempts.
  final String payload;

  /// Payload contract version tag (e.g. 1) — lets the backend
  /// route/migrate old payloads.
  final int payloadVersion;

  /// Wire name of SyncStatus ('pending' | 'inFlight' | 'synced' |
  /// 'failed') — model marshals. NOTE the single-word 'inFlight'
  /// wire value (the Phase 02.6 lock).
  final String status;

  /// Spent attempts — a crash mid-attempt counts (conservative
  /// accounting, Phase 02.6).
  final int retryCount;

  /// Backoff gate — earliest next attempt (UTC); null while no
  /// retry is scheduled.
  final DateTime? nextRetryAt;

  /// Wire name of SyncFailureClass ('retryable' | 'permanent') —
  /// the last attempt's classification. Model marshals.
  final String? failureClass;

  /// SHORT safe technical message from the last attempt — never raw
  /// SMS / unmasked values (Phase 02.6 security lock).
  final String? lastError;

  /// Claim marker — when the current attempt started (UTC). Set on
  /// pending→inFlight; CLEARED on requeue-for-retry (the
  /// reset-on-requeue rule). Null while unclaimed.
  final DateTime? attemptStartedAt;

  /// Terminal time (UTC) — set only on genuine backend
  /// acknowledgment (synced) or permanent failure (failed). Never
  /// before real success.
  final DateTime? completedAt;

  /// When the entry was enqueued (UTC).
  final DateTime createdAt;
  const SyncQueueTableData({
    required this.id,
    required this.entityType,
    required this.entityId,
    required this.operation,
    required this.payload,
    required this.payloadVersion,
    required this.status,
    required this.retryCount,
    this.nextRetryAt,
    this.failureClass,
    this.lastError,
    this.attemptStartedAt,
    this.completedAt,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['entity_type'] = Variable<String>(entityType);
    map['entity_id'] = Variable<String>(entityId);
    map['operation'] = Variable<String>(operation);
    map['payload'] = Variable<String>(payload);
    map['payload_version'] = Variable<int>(payloadVersion);
    map['status'] = Variable<String>(status);
    map['retry_count'] = Variable<int>(retryCount);
    if (!nullToAbsent || nextRetryAt != null) {
      map['next_retry_at'] = Variable<DateTime>(nextRetryAt);
    }
    if (!nullToAbsent || failureClass != null) {
      map['failure_class'] = Variable<String>(failureClass);
    }
    if (!nullToAbsent || lastError != null) {
      map['last_error'] = Variable<String>(lastError);
    }
    if (!nullToAbsent || attemptStartedAt != null) {
      map['attempt_started_at'] = Variable<DateTime>(attemptStartedAt);
    }
    if (!nullToAbsent || completedAt != null) {
      map['completed_at'] = Variable<DateTime>(completedAt);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  SyncQueueTableCompanion toCompanion(bool nullToAbsent) {
    return SyncQueueTableCompanion(
      id: Value(id),
      entityType: Value(entityType),
      entityId: Value(entityId),
      operation: Value(operation),
      payload: Value(payload),
      payloadVersion: Value(payloadVersion),
      status: Value(status),
      retryCount: Value(retryCount),
      nextRetryAt: nextRetryAt == null && nullToAbsent
          ? const Value.absent()
          : Value(nextRetryAt),
      failureClass: failureClass == null && nullToAbsent
          ? const Value.absent()
          : Value(failureClass),
      lastError: lastError == null && nullToAbsent
          ? const Value.absent()
          : Value(lastError),
      attemptStartedAt: attemptStartedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(attemptStartedAt),
      completedAt: completedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(completedAt),
      createdAt: Value(createdAt),
    );
  }

  factory SyncQueueTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SyncQueueTableData(
      id: serializer.fromJson<String>(json['id']),
      entityType: serializer.fromJson<String>(json['entityType']),
      entityId: serializer.fromJson<String>(json['entityId']),
      operation: serializer.fromJson<String>(json['operation']),
      payload: serializer.fromJson<String>(json['payload']),
      payloadVersion: serializer.fromJson<int>(json['payloadVersion']),
      status: serializer.fromJson<String>(json['status']),
      retryCount: serializer.fromJson<int>(json['retryCount']),
      nextRetryAt: serializer.fromJson<DateTime?>(json['nextRetryAt']),
      failureClass: serializer.fromJson<String?>(json['failureClass']),
      lastError: serializer.fromJson<String?>(json['lastError']),
      attemptStartedAt: serializer.fromJson<DateTime?>(
        json['attemptStartedAt'],
      ),
      completedAt: serializer.fromJson<DateTime?>(json['completedAt']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'entityType': serializer.toJson<String>(entityType),
      'entityId': serializer.toJson<String>(entityId),
      'operation': serializer.toJson<String>(operation),
      'payload': serializer.toJson<String>(payload),
      'payloadVersion': serializer.toJson<int>(payloadVersion),
      'status': serializer.toJson<String>(status),
      'retryCount': serializer.toJson<int>(retryCount),
      'nextRetryAt': serializer.toJson<DateTime?>(nextRetryAt),
      'failureClass': serializer.toJson<String?>(failureClass),
      'lastError': serializer.toJson<String?>(lastError),
      'attemptStartedAt': serializer.toJson<DateTime?>(attemptStartedAt),
      'completedAt': serializer.toJson<DateTime?>(completedAt),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  SyncQueueTableData copyWith({
    String? id,
    String? entityType,
    String? entityId,
    String? operation,
    String? payload,
    int? payloadVersion,
    String? status,
    int? retryCount,
    Value<DateTime?> nextRetryAt = const Value.absent(),
    Value<String?> failureClass = const Value.absent(),
    Value<String?> lastError = const Value.absent(),
    Value<DateTime?> attemptStartedAt = const Value.absent(),
    Value<DateTime?> completedAt = const Value.absent(),
    DateTime? createdAt,
  }) => SyncQueueTableData(
    id: id ?? this.id,
    entityType: entityType ?? this.entityType,
    entityId: entityId ?? this.entityId,
    operation: operation ?? this.operation,
    payload: payload ?? this.payload,
    payloadVersion: payloadVersion ?? this.payloadVersion,
    status: status ?? this.status,
    retryCount: retryCount ?? this.retryCount,
    nextRetryAt: nextRetryAt.present ? nextRetryAt.value : this.nextRetryAt,
    failureClass: failureClass.present ? failureClass.value : this.failureClass,
    lastError: lastError.present ? lastError.value : this.lastError,
    attemptStartedAt: attemptStartedAt.present
        ? attemptStartedAt.value
        : this.attemptStartedAt,
    completedAt: completedAt.present ? completedAt.value : this.completedAt,
    createdAt: createdAt ?? this.createdAt,
  );
  SyncQueueTableData copyWithCompanion(SyncQueueTableCompanion data) {
    return SyncQueueTableData(
      id: data.id.present ? data.id.value : this.id,
      entityType: data.entityType.present
          ? data.entityType.value
          : this.entityType,
      entityId: data.entityId.present ? data.entityId.value : this.entityId,
      operation: data.operation.present ? data.operation.value : this.operation,
      payload: data.payload.present ? data.payload.value : this.payload,
      payloadVersion: data.payloadVersion.present
          ? data.payloadVersion.value
          : this.payloadVersion,
      status: data.status.present ? data.status.value : this.status,
      retryCount: data.retryCount.present
          ? data.retryCount.value
          : this.retryCount,
      nextRetryAt: data.nextRetryAt.present
          ? data.nextRetryAt.value
          : this.nextRetryAt,
      failureClass: data.failureClass.present
          ? data.failureClass.value
          : this.failureClass,
      lastError: data.lastError.present ? data.lastError.value : this.lastError,
      attemptStartedAt: data.attemptStartedAt.present
          ? data.attemptStartedAt.value
          : this.attemptStartedAt,
      completedAt: data.completedAt.present
          ? data.completedAt.value
          : this.completedAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SyncQueueTableData(')
          ..write('id: $id, ')
          ..write('entityType: $entityType, ')
          ..write('entityId: $entityId, ')
          ..write('operation: $operation, ')
          ..write('payload: $payload, ')
          ..write('payloadVersion: $payloadVersion, ')
          ..write('status: $status, ')
          ..write('retryCount: $retryCount, ')
          ..write('nextRetryAt: $nextRetryAt, ')
          ..write('failureClass: $failureClass, ')
          ..write('lastError: $lastError, ')
          ..write('attemptStartedAt: $attemptStartedAt, ')
          ..write('completedAt: $completedAt, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    entityType,
    entityId,
    operation,
    payload,
    payloadVersion,
    status,
    retryCount,
    nextRetryAt,
    failureClass,
    lastError,
    attemptStartedAt,
    completedAt,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SyncQueueTableData &&
          other.id == this.id &&
          other.entityType == this.entityType &&
          other.entityId == this.entityId &&
          other.operation == this.operation &&
          other.payload == this.payload &&
          other.payloadVersion == this.payloadVersion &&
          other.status == this.status &&
          other.retryCount == this.retryCount &&
          other.nextRetryAt == this.nextRetryAt &&
          other.failureClass == this.failureClass &&
          other.lastError == this.lastError &&
          other.attemptStartedAt == this.attemptStartedAt &&
          other.completedAt == this.completedAt &&
          other.createdAt == this.createdAt);
}

class SyncQueueTableCompanion extends UpdateCompanion<SyncQueueTableData> {
  final Value<String> id;
  final Value<String> entityType;
  final Value<String> entityId;
  final Value<String> operation;
  final Value<String> payload;
  final Value<int> payloadVersion;
  final Value<String> status;
  final Value<int> retryCount;
  final Value<DateTime?> nextRetryAt;
  final Value<String?> failureClass;
  final Value<String?> lastError;
  final Value<DateTime?> attemptStartedAt;
  final Value<DateTime?> completedAt;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const SyncQueueTableCompanion({
    this.id = const Value.absent(),
    this.entityType = const Value.absent(),
    this.entityId = const Value.absent(),
    this.operation = const Value.absent(),
    this.payload = const Value.absent(),
    this.payloadVersion = const Value.absent(),
    this.status = const Value.absent(),
    this.retryCount = const Value.absent(),
    this.nextRetryAt = const Value.absent(),
    this.failureClass = const Value.absent(),
    this.lastError = const Value.absent(),
    this.attemptStartedAt = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SyncQueueTableCompanion.insert({
    this.id = const Value.absent(),
    required String entityType,
    required String entityId,
    required String operation,
    required String payload,
    this.payloadVersion = const Value.absent(),
    required String status,
    this.retryCount = const Value.absent(),
    this.nextRetryAt = const Value.absent(),
    this.failureClass = const Value.absent(),
    this.lastError = const Value.absent(),
    this.attemptStartedAt = const Value.absent(),
    this.completedAt = const Value.absent(),
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : entityType = Value(entityType),
       entityId = Value(entityId),
       operation = Value(operation),
       payload = Value(payload),
       status = Value(status),
       createdAt = Value(createdAt);
  static Insertable<SyncQueueTableData> custom({
    Expression<String>? id,
    Expression<String>? entityType,
    Expression<String>? entityId,
    Expression<String>? operation,
    Expression<String>? payload,
    Expression<int>? payloadVersion,
    Expression<String>? status,
    Expression<int>? retryCount,
    Expression<DateTime>? nextRetryAt,
    Expression<String>? failureClass,
    Expression<String>? lastError,
    Expression<DateTime>? attemptStartedAt,
    Expression<DateTime>? completedAt,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (entityType != null) 'entity_type': entityType,
      if (entityId != null) 'entity_id': entityId,
      if (operation != null) 'operation': operation,
      if (payload != null) 'payload': payload,
      if (payloadVersion != null) 'payload_version': payloadVersion,
      if (status != null) 'status': status,
      if (retryCount != null) 'retry_count': retryCount,
      if (nextRetryAt != null) 'next_retry_at': nextRetryAt,
      if (failureClass != null) 'failure_class': failureClass,
      if (lastError != null) 'last_error': lastError,
      if (attemptStartedAt != null) 'attempt_started_at': attemptStartedAt,
      if (completedAt != null) 'completed_at': completedAt,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SyncQueueTableCompanion copyWith({
    Value<String>? id,
    Value<String>? entityType,
    Value<String>? entityId,
    Value<String>? operation,
    Value<String>? payload,
    Value<int>? payloadVersion,
    Value<String>? status,
    Value<int>? retryCount,
    Value<DateTime?>? nextRetryAt,
    Value<String?>? failureClass,
    Value<String?>? lastError,
    Value<DateTime?>? attemptStartedAt,
    Value<DateTime?>? completedAt,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return SyncQueueTableCompanion(
      id: id ?? this.id,
      entityType: entityType ?? this.entityType,
      entityId: entityId ?? this.entityId,
      operation: operation ?? this.operation,
      payload: payload ?? this.payload,
      payloadVersion: payloadVersion ?? this.payloadVersion,
      status: status ?? this.status,
      retryCount: retryCount ?? this.retryCount,
      nextRetryAt: nextRetryAt ?? this.nextRetryAt,
      failureClass: failureClass ?? this.failureClass,
      lastError: lastError ?? this.lastError,
      attemptStartedAt: attemptStartedAt ?? this.attemptStartedAt,
      completedAt: completedAt ?? this.completedAt,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (entityType.present) {
      map['entity_type'] = Variable<String>(entityType.value);
    }
    if (entityId.present) {
      map['entity_id'] = Variable<String>(entityId.value);
    }
    if (operation.present) {
      map['operation'] = Variable<String>(operation.value);
    }
    if (payload.present) {
      map['payload'] = Variable<String>(payload.value);
    }
    if (payloadVersion.present) {
      map['payload_version'] = Variable<int>(payloadVersion.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (retryCount.present) {
      map['retry_count'] = Variable<int>(retryCount.value);
    }
    if (nextRetryAt.present) {
      map['next_retry_at'] = Variable<DateTime>(nextRetryAt.value);
    }
    if (failureClass.present) {
      map['failure_class'] = Variable<String>(failureClass.value);
    }
    if (lastError.present) {
      map['last_error'] = Variable<String>(lastError.value);
    }
    if (attemptStartedAt.present) {
      map['attempt_started_at'] = Variable<DateTime>(attemptStartedAt.value);
    }
    if (completedAt.present) {
      map['completed_at'] = Variable<DateTime>(completedAt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SyncQueueTableCompanion(')
          ..write('id: $id, ')
          ..write('entityType: $entityType, ')
          ..write('entityId: $entityId, ')
          ..write('operation: $operation, ')
          ..write('payload: $payload, ')
          ..write('payloadVersion: $payloadVersion, ')
          ..write('status: $status, ')
          ..write('retryCount: $retryCount, ')
          ..write('nextRetryAt: $nextRetryAt, ')
          ..write('failureClass: $failureClass, ')
          ..write('lastError: $lastError, ')
          ..write('attemptStartedAt: $attemptStartedAt, ')
          ..write('completedAt: $completedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LogsTableTable extends LogsTable
    with TableInfo<$LogsTableTable, LogsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LogsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: () => '',
  );
  static const VerificationMeta _timestampMeta = const VerificationMeta(
    'timestamp',
  );
  @override
  late final GeneratedColumn<DateTime> timestamp = GeneratedColumn<DateTime>(
    'timestamp',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _levelMeta = const VerificationMeta('level');
  @override
  late final GeneratedColumn<String> level = GeneratedColumn<String>(
    'level',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _moduleMeta = const VerificationMeta('module');
  @override
  late final GeneratedColumn<String> module = GeneratedColumn<String>(
    'module',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _eventMeta = const VerificationMeta('event');
  @override
  late final GeneratedColumn<String> event = GeneratedColumn<String>(
    'event',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _messageMeta = const VerificationMeta(
    'message',
  );
  @override
  late final GeneratedColumn<String> message = GeneratedColumn<String>(
    'message',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _errorCodeMeta = const VerificationMeta(
    'errorCode',
  );
  @override
  late final GeneratedColumn<String> errorCode = GeneratedColumn<String>(
    'error_code',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _stackTraceMeta = const VerificationMeta(
    'stackTrace',
  );
  @override
  late final GeneratedColumn<String> stackTrace = GeneratedColumn<String>(
    'stack_trace',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('null'),
  );
  static const VerificationMeta _detailsMeta = const VerificationMeta(
    'details',
  );
  @override
  late final GeneratedColumn<String> details = GeneratedColumn<String>(
    'details',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('null'),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    timestamp,
    level,
    module,
    event,
    message,
    errorCode,
    stackTrace,
    details,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'logs';
  @override
  VerificationContext validateIntegrity(
    Insertable<LogsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('timestamp')) {
      context.handle(
        _timestampMeta,
        timestamp.isAcceptableOrUnknown(data['timestamp']!, _timestampMeta),
      );
    } else if (isInserting) {
      context.missing(_timestampMeta);
    }
    if (data.containsKey('level')) {
      context.handle(
        _levelMeta,
        level.isAcceptableOrUnknown(data['level']!, _levelMeta),
      );
    } else if (isInserting) {
      context.missing(_levelMeta);
    }
    if (data.containsKey('module')) {
      context.handle(
        _moduleMeta,
        module.isAcceptableOrUnknown(data['module']!, _moduleMeta),
      );
    } else if (isInserting) {
      context.missing(_moduleMeta);
    }
    if (data.containsKey('event')) {
      context.handle(
        _eventMeta,
        event.isAcceptableOrUnknown(data['event']!, _eventMeta),
      );
    } else if (isInserting) {
      context.missing(_eventMeta);
    }
    if (data.containsKey('message')) {
      context.handle(
        _messageMeta,
        message.isAcceptableOrUnknown(data['message']!, _messageMeta),
      );
    } else if (isInserting) {
      context.missing(_messageMeta);
    }
    if (data.containsKey('error_code')) {
      context.handle(
        _errorCodeMeta,
        errorCode.isAcceptableOrUnknown(data['error_code']!, _errorCodeMeta),
      );
    }
    if (data.containsKey('stack_trace')) {
      context.handle(
        _stackTraceMeta,
        stackTrace.isAcceptableOrUnknown(data['stack_trace']!, _stackTraceMeta),
      );
    }
    if (data.containsKey('details')) {
      context.handle(
        _detailsMeta,
        details.isAcceptableOrUnknown(data['details']!, _detailsMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LogsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LogsTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      timestamp: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}timestamp'],
      )!,
      level: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}level'],
      )!,
      module: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}module'],
      )!,
      event: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}event'],
      )!,
      message: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}message'],
      )!,
      errorCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}error_code'],
      ),
      stackTrace: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}stack_trace'],
      )!,
      details: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}details'],
      )!,
    );
  }

  @override
  $LogsTableTable createAlias(String alias) {
    return $LogsTableTable(attachedDatabase, alias);
  }
}

class LogsTableData extends DataClass implements Insertable<LogsTableData> {
  /// Primary key — [LogEvent.id], UUID at log time. TEXT, not
  /// auto-increment.
  final String id;

  /// When the event was logged (UTC).
  final DateTime timestamp;

  /// LogLevel wire name ('debug'|'info'|'warning'|'error'|
  /// 'critical') — model marshals. Indexed: the minimum-level
  /// filter reads it.
  final String level;

  /// Origin subsystem dot-path ('core.db.migration') — see the
  /// LogEvent content rules.
  final String module;

  /// Stable short event name within the module ('open_failed').
  final String event;

  /// Human-readable entry — SAFE references only (the LogEvent
  /// security contract; enforced by convention + tests at the
  /// logger layer).
  final String message;

  /// Machine-readable code ('DB-001') — nullable 1:1.
  final String? errorCode;

  /// StackTraceData JSON object string; 'null' when absent —
  /// model marshals the structured value object.
  final String stackTrace;

  /// Safe-metadata JSON object string; 'null' when absent.
  final String details;
  const LogsTableData({
    required this.id,
    required this.timestamp,
    required this.level,
    required this.module,
    required this.event,
    required this.message,
    this.errorCode,
    required this.stackTrace,
    required this.details,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['timestamp'] = Variable<DateTime>(timestamp);
    map['level'] = Variable<String>(level);
    map['module'] = Variable<String>(module);
    map['event'] = Variable<String>(event);
    map['message'] = Variable<String>(message);
    if (!nullToAbsent || errorCode != null) {
      map['error_code'] = Variable<String>(errorCode);
    }
    map['stack_trace'] = Variable<String>(stackTrace);
    map['details'] = Variable<String>(details);
    return map;
  }

  LogsTableCompanion toCompanion(bool nullToAbsent) {
    return LogsTableCompanion(
      id: Value(id),
      timestamp: Value(timestamp),
      level: Value(level),
      module: Value(module),
      event: Value(event),
      message: Value(message),
      errorCode: errorCode == null && nullToAbsent
          ? const Value.absent()
          : Value(errorCode),
      stackTrace: Value(stackTrace),
      details: Value(details),
    );
  }

  factory LogsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LogsTableData(
      id: serializer.fromJson<String>(json['id']),
      timestamp: serializer.fromJson<DateTime>(json['timestamp']),
      level: serializer.fromJson<String>(json['level']),
      module: serializer.fromJson<String>(json['module']),
      event: serializer.fromJson<String>(json['event']),
      message: serializer.fromJson<String>(json['message']),
      errorCode: serializer.fromJson<String?>(json['errorCode']),
      stackTrace: serializer.fromJson<String>(json['stackTrace']),
      details: serializer.fromJson<String>(json['details']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'timestamp': serializer.toJson<DateTime>(timestamp),
      'level': serializer.toJson<String>(level),
      'module': serializer.toJson<String>(module),
      'event': serializer.toJson<String>(event),
      'message': serializer.toJson<String>(message),
      'errorCode': serializer.toJson<String?>(errorCode),
      'stackTrace': serializer.toJson<String>(stackTrace),
      'details': serializer.toJson<String>(details),
    };
  }

  LogsTableData copyWith({
    String? id,
    DateTime? timestamp,
    String? level,
    String? module,
    String? event,
    String? message,
    Value<String?> errorCode = const Value.absent(),
    String? stackTrace,
    String? details,
  }) => LogsTableData(
    id: id ?? this.id,
    timestamp: timestamp ?? this.timestamp,
    level: level ?? this.level,
    module: module ?? this.module,
    event: event ?? this.event,
    message: message ?? this.message,
    errorCode: errorCode.present ? errorCode.value : this.errorCode,
    stackTrace: stackTrace ?? this.stackTrace,
    details: details ?? this.details,
  );
  LogsTableData copyWithCompanion(LogsTableCompanion data) {
    return LogsTableData(
      id: data.id.present ? data.id.value : this.id,
      timestamp: data.timestamp.present ? data.timestamp.value : this.timestamp,
      level: data.level.present ? data.level.value : this.level,
      module: data.module.present ? data.module.value : this.module,
      event: data.event.present ? data.event.value : this.event,
      message: data.message.present ? data.message.value : this.message,
      errorCode: data.errorCode.present ? data.errorCode.value : this.errorCode,
      stackTrace: data.stackTrace.present
          ? data.stackTrace.value
          : this.stackTrace,
      details: data.details.present ? data.details.value : this.details,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LogsTableData(')
          ..write('id: $id, ')
          ..write('timestamp: $timestamp, ')
          ..write('level: $level, ')
          ..write('module: $module, ')
          ..write('event: $event, ')
          ..write('message: $message, ')
          ..write('errorCode: $errorCode, ')
          ..write('stackTrace: $stackTrace, ')
          ..write('details: $details')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    timestamp,
    level,
    module,
    event,
    message,
    errorCode,
    stackTrace,
    details,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LogsTableData &&
          other.id == this.id &&
          other.timestamp == this.timestamp &&
          other.level == this.level &&
          other.module == this.module &&
          other.event == this.event &&
          other.message == this.message &&
          other.errorCode == this.errorCode &&
          other.stackTrace == this.stackTrace &&
          other.details == this.details);
}

class LogsTableCompanion extends UpdateCompanion<LogsTableData> {
  final Value<String> id;
  final Value<DateTime> timestamp;
  final Value<String> level;
  final Value<String> module;
  final Value<String> event;
  final Value<String> message;
  final Value<String?> errorCode;
  final Value<String> stackTrace;
  final Value<String> details;
  final Value<int> rowid;
  const LogsTableCompanion({
    this.id = const Value.absent(),
    this.timestamp = const Value.absent(),
    this.level = const Value.absent(),
    this.module = const Value.absent(),
    this.event = const Value.absent(),
    this.message = const Value.absent(),
    this.errorCode = const Value.absent(),
    this.stackTrace = const Value.absent(),
    this.details = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LogsTableCompanion.insert({
    this.id = const Value.absent(),
    required DateTime timestamp,
    required String level,
    required String module,
    required String event,
    required String message,
    this.errorCode = const Value.absent(),
    this.stackTrace = const Value.absent(),
    this.details = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : timestamp = Value(timestamp),
       level = Value(level),
       module = Value(module),
       event = Value(event),
       message = Value(message);
  static Insertable<LogsTableData> custom({
    Expression<String>? id,
    Expression<DateTime>? timestamp,
    Expression<String>? level,
    Expression<String>? module,
    Expression<String>? event,
    Expression<String>? message,
    Expression<String>? errorCode,
    Expression<String>? stackTrace,
    Expression<String>? details,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (timestamp != null) 'timestamp': timestamp,
      if (level != null) 'level': level,
      if (module != null) 'module': module,
      if (event != null) 'event': event,
      if (message != null) 'message': message,
      if (errorCode != null) 'error_code': errorCode,
      if (stackTrace != null) 'stack_trace': stackTrace,
      if (details != null) 'details': details,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LogsTableCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? timestamp,
    Value<String>? level,
    Value<String>? module,
    Value<String>? event,
    Value<String>? message,
    Value<String?>? errorCode,
    Value<String>? stackTrace,
    Value<String>? details,
    Value<int>? rowid,
  }) {
    return LogsTableCompanion(
      id: id ?? this.id,
      timestamp: timestamp ?? this.timestamp,
      level: level ?? this.level,
      module: module ?? this.module,
      event: event ?? this.event,
      message: message ?? this.message,
      errorCode: errorCode ?? this.errorCode,
      stackTrace: stackTrace ?? this.stackTrace,
      details: details ?? this.details,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (timestamp.present) {
      map['timestamp'] = Variable<DateTime>(timestamp.value);
    }
    if (level.present) {
      map['level'] = Variable<String>(level.value);
    }
    if (module.present) {
      map['module'] = Variable<String>(module.value);
    }
    if (event.present) {
      map['event'] = Variable<String>(event.value);
    }
    if (message.present) {
      map['message'] = Variable<String>(message.value);
    }
    if (errorCode.present) {
      map['error_code'] = Variable<String>(errorCode.value);
    }
    if (stackTrace.present) {
      map['stack_trace'] = Variable<String>(stackTrace.value);
    }
    if (details.present) {
      map['details'] = Variable<String>(details.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LogsTableCompanion(')
          ..write('id: $id, ')
          ..write('timestamp: $timestamp, ')
          ..write('level: $level, ')
          ..write('module: $module, ')
          ..write('event: $event, ')
          ..write('message: $message, ')
          ..write('errorCode: $errorCode, ')
          ..write('stackTrace: $stackTrace, ')
          ..write('details: $details, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AuditEventsTableTable extends AuditEventsTable
    with TableInfo<$AuditEventsTableTable, AuditEventsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AuditEventsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: () => '',
  );
  static const VerificationMeta _timestampMeta = const VerificationMeta(
    'timestamp',
  );
  @override
  late final GeneratedColumn<DateTime> timestamp = GeneratedColumn<DateTime>(
    'timestamp',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deviceIdMeta = const VerificationMeta(
    'deviceId',
  );
  @override
  late final GeneratedColumn<String> deviceId = GeneratedColumn<String>(
    'device_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _appVersionMeta = const VerificationMeta(
    'appVersion',
  );
  @override
  late final GeneratedColumn<String> appVersion = GeneratedColumn<String>(
    'app_version',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _actorRoleMeta = const VerificationMeta(
    'actorRole',
  );
  @override
  late final GeneratedColumn<String> actorRole = GeneratedColumn<String>(
    'actor_role',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _actorUserIdMeta = const VerificationMeta(
    'actorUserId',
  );
  @override
  late final GeneratedColumn<String> actorUserId = GeneratedColumn<String>(
    'actor_user_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _smsIdMeta = const VerificationMeta('smsId');
  @override
  late final GeneratedColumn<String> smsId = GeneratedColumn<String>(
    'sms_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _transactionIdMeta = const VerificationMeta(
    'transactionId',
  );
  @override
  late final GeneratedColumn<String> transactionId = GeneratedColumn<String>(
    'transaction_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _smsHashMeta = const VerificationMeta(
    'smsHash',
  );
  @override
  late final GeneratedColumn<String> smsHash = GeneratedColumn<String>(
    'sms_hash',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _metadataMeta = const VerificationMeta(
    'metadata',
  );
  @override
  late final GeneratedColumn<String> metadata = GeneratedColumn<String>(
    'metadata',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('{}'),
  );
  @override
  List<GeneratedColumn> get $columns => [
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
    metadata,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'audit_events';
  @override
  VerificationContext validateIntegrity(
    Insertable<AuditEventsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('timestamp')) {
      context.handle(
        _timestampMeta,
        timestamp.isAcceptableOrUnknown(data['timestamp']!, _timestampMeta),
      );
    } else if (isInserting) {
      context.missing(_timestampMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('device_id')) {
      context.handle(
        _deviceIdMeta,
        deviceId.isAcceptableOrUnknown(data['device_id']!, _deviceIdMeta),
      );
    } else if (isInserting) {
      context.missing(_deviceIdMeta);
    }
    if (data.containsKey('app_version')) {
      context.handle(
        _appVersionMeta,
        appVersion.isAcceptableOrUnknown(data['app_version']!, _appVersionMeta),
      );
    } else if (isInserting) {
      context.missing(_appVersionMeta);
    }
    if (data.containsKey('actor_role')) {
      context.handle(
        _actorRoleMeta,
        actorRole.isAcceptableOrUnknown(data['actor_role']!, _actorRoleMeta),
      );
    } else if (isInserting) {
      context.missing(_actorRoleMeta);
    }
    if (data.containsKey('actor_user_id')) {
      context.handle(
        _actorUserIdMeta,
        actorUserId.isAcceptableOrUnknown(
          data['actor_user_id']!,
          _actorUserIdMeta,
        ),
      );
    }
    if (data.containsKey('sms_id')) {
      context.handle(
        _smsIdMeta,
        smsId.isAcceptableOrUnknown(data['sms_id']!, _smsIdMeta),
      );
    }
    if (data.containsKey('transaction_id')) {
      context.handle(
        _transactionIdMeta,
        transactionId.isAcceptableOrUnknown(
          data['transaction_id']!,
          _transactionIdMeta,
        ),
      );
    }
    if (data.containsKey('sms_hash')) {
      context.handle(
        _smsHashMeta,
        smsHash.isAcceptableOrUnknown(data['sms_hash']!, _smsHashMeta),
      );
    }
    if (data.containsKey('metadata')) {
      context.handle(
        _metadataMeta,
        metadata.isAcceptableOrUnknown(data['metadata']!, _metadataMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AuditEventsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AuditEventsTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      timestamp: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}timestamp'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      deviceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}device_id'],
      )!,
      appVersion: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}app_version'],
      )!,
      actorRole: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}actor_role'],
      )!,
      actorUserId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}actor_user_id'],
      ),
      smsId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sms_id'],
      ),
      transactionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}transaction_id'],
      ),
      smsHash: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sms_hash'],
      ),
      metadata: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}metadata'],
      )!,
    );
  }

  @override
  $AuditEventsTableTable createAlias(String alias) {
    return $AuditEventsTableTable(attachedDatabase, alias);
  }
}

class AuditEventsTableData extends DataClass
    implements Insertable<AuditEventsTableData> {
  /// Primary key — [AuditEvent.id], UUID at emission time. TEXT,
  /// not auto-increment.
  final String id;

  /// When the event happened (UTC).
  final DateTime timestamp;

  /// AuditEventType wire name ('sms_received', ... — the frozen
  /// snake_case vocabulary) — model marshals. Indexed: the audit
  /// screen's facet filter.
  final String type;

  /// Device that produced the event.
  final String deviceId;

  /// App version at emission time — anchors every decision to the
  /// exact build.
  final String appVersion;

  /// AuditActorRole wire name ('system' | 'admin') — model marshals.
  final String actorRole;

  /// Acting human user id — null for system events. Nullable 1:1.
  final String? actorUserId;

  /// Anchor slot 1 — the source SMS (sms_messages.id). SOFT
  /// reference; see the class doc comment.
  final String? smsId;

  /// Anchor slot 2 — the financial record (transactions.id). SOFT
  /// reference; null until transaction_created.
  final String? transactionId;

  /// SHA-256 of the source message — the SAFE identity reference.
  final String? smsHash;

  /// Safe-metadata JSON object string; default '{}' (the entity's
  /// map is always present, possibly empty) — model marshals.
  final String metadata;
  const AuditEventsTableData({
    required this.id,
    required this.timestamp,
    required this.type,
    required this.deviceId,
    required this.appVersion,
    required this.actorRole,
    this.actorUserId,
    this.smsId,
    this.transactionId,
    this.smsHash,
    required this.metadata,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['timestamp'] = Variable<DateTime>(timestamp);
    map['type'] = Variable<String>(type);
    map['device_id'] = Variable<String>(deviceId);
    map['app_version'] = Variable<String>(appVersion);
    map['actor_role'] = Variable<String>(actorRole);
    if (!nullToAbsent || actorUserId != null) {
      map['actor_user_id'] = Variable<String>(actorUserId);
    }
    if (!nullToAbsent || smsId != null) {
      map['sms_id'] = Variable<String>(smsId);
    }
    if (!nullToAbsent || transactionId != null) {
      map['transaction_id'] = Variable<String>(transactionId);
    }
    if (!nullToAbsent || smsHash != null) {
      map['sms_hash'] = Variable<String>(smsHash);
    }
    map['metadata'] = Variable<String>(metadata);
    return map;
  }

  AuditEventsTableCompanion toCompanion(bool nullToAbsent) {
    return AuditEventsTableCompanion(
      id: Value(id),
      timestamp: Value(timestamp),
      type: Value(type),
      deviceId: Value(deviceId),
      appVersion: Value(appVersion),
      actorRole: Value(actorRole),
      actorUserId: actorUserId == null && nullToAbsent
          ? const Value.absent()
          : Value(actorUserId),
      smsId: smsId == null && nullToAbsent
          ? const Value.absent()
          : Value(smsId),
      transactionId: transactionId == null && nullToAbsent
          ? const Value.absent()
          : Value(transactionId),
      smsHash: smsHash == null && nullToAbsent
          ? const Value.absent()
          : Value(smsHash),
      metadata: Value(metadata),
    );
  }

  factory AuditEventsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AuditEventsTableData(
      id: serializer.fromJson<String>(json['id']),
      timestamp: serializer.fromJson<DateTime>(json['timestamp']),
      type: serializer.fromJson<String>(json['type']),
      deviceId: serializer.fromJson<String>(json['deviceId']),
      appVersion: serializer.fromJson<String>(json['appVersion']),
      actorRole: serializer.fromJson<String>(json['actorRole']),
      actorUserId: serializer.fromJson<String?>(json['actorUserId']),
      smsId: serializer.fromJson<String?>(json['smsId']),
      transactionId: serializer.fromJson<String?>(json['transactionId']),
      smsHash: serializer.fromJson<String?>(json['smsHash']),
      metadata: serializer.fromJson<String>(json['metadata']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'timestamp': serializer.toJson<DateTime>(timestamp),
      'type': serializer.toJson<String>(type),
      'deviceId': serializer.toJson<String>(deviceId),
      'appVersion': serializer.toJson<String>(appVersion),
      'actorRole': serializer.toJson<String>(actorRole),
      'actorUserId': serializer.toJson<String?>(actorUserId),
      'smsId': serializer.toJson<String?>(smsId),
      'transactionId': serializer.toJson<String?>(transactionId),
      'smsHash': serializer.toJson<String?>(smsHash),
      'metadata': serializer.toJson<String>(metadata),
    };
  }

  AuditEventsTableData copyWith({
    String? id,
    DateTime? timestamp,
    String? type,
    String? deviceId,
    String? appVersion,
    String? actorRole,
    Value<String?> actorUserId = const Value.absent(),
    Value<String?> smsId = const Value.absent(),
    Value<String?> transactionId = const Value.absent(),
    Value<String?> smsHash = const Value.absent(),
    String? metadata,
  }) => AuditEventsTableData(
    id: id ?? this.id,
    timestamp: timestamp ?? this.timestamp,
    type: type ?? this.type,
    deviceId: deviceId ?? this.deviceId,
    appVersion: appVersion ?? this.appVersion,
    actorRole: actorRole ?? this.actorRole,
    actorUserId: actorUserId.present ? actorUserId.value : this.actorUserId,
    smsId: smsId.present ? smsId.value : this.smsId,
    transactionId: transactionId.present
        ? transactionId.value
        : this.transactionId,
    smsHash: smsHash.present ? smsHash.value : this.smsHash,
    metadata: metadata ?? this.metadata,
  );
  AuditEventsTableData copyWithCompanion(AuditEventsTableCompanion data) {
    return AuditEventsTableData(
      id: data.id.present ? data.id.value : this.id,
      timestamp: data.timestamp.present ? data.timestamp.value : this.timestamp,
      type: data.type.present ? data.type.value : this.type,
      deviceId: data.deviceId.present ? data.deviceId.value : this.deviceId,
      appVersion: data.appVersion.present
          ? data.appVersion.value
          : this.appVersion,
      actorRole: data.actorRole.present ? data.actorRole.value : this.actorRole,
      actorUserId: data.actorUserId.present
          ? data.actorUserId.value
          : this.actorUserId,
      smsId: data.smsId.present ? data.smsId.value : this.smsId,
      transactionId: data.transactionId.present
          ? data.transactionId.value
          : this.transactionId,
      smsHash: data.smsHash.present ? data.smsHash.value : this.smsHash,
      metadata: data.metadata.present ? data.metadata.value : this.metadata,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AuditEventsTableData(')
          ..write('id: $id, ')
          ..write('timestamp: $timestamp, ')
          ..write('type: $type, ')
          ..write('deviceId: $deviceId, ')
          ..write('appVersion: $appVersion, ')
          ..write('actorRole: $actorRole, ')
          ..write('actorUserId: $actorUserId, ')
          ..write('smsId: $smsId, ')
          ..write('transactionId: $transactionId, ')
          ..write('smsHash: $smsHash, ')
          ..write('metadata: $metadata')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
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
    metadata,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AuditEventsTableData &&
          other.id == this.id &&
          other.timestamp == this.timestamp &&
          other.type == this.type &&
          other.deviceId == this.deviceId &&
          other.appVersion == this.appVersion &&
          other.actorRole == this.actorRole &&
          other.actorUserId == this.actorUserId &&
          other.smsId == this.smsId &&
          other.transactionId == this.transactionId &&
          other.smsHash == this.smsHash &&
          other.metadata == this.metadata);
}

class AuditEventsTableCompanion extends UpdateCompanion<AuditEventsTableData> {
  final Value<String> id;
  final Value<DateTime> timestamp;
  final Value<String> type;
  final Value<String> deviceId;
  final Value<String> appVersion;
  final Value<String> actorRole;
  final Value<String?> actorUserId;
  final Value<String?> smsId;
  final Value<String?> transactionId;
  final Value<String?> smsHash;
  final Value<String> metadata;
  final Value<int> rowid;
  const AuditEventsTableCompanion({
    this.id = const Value.absent(),
    this.timestamp = const Value.absent(),
    this.type = const Value.absent(),
    this.deviceId = const Value.absent(),
    this.appVersion = const Value.absent(),
    this.actorRole = const Value.absent(),
    this.actorUserId = const Value.absent(),
    this.smsId = const Value.absent(),
    this.transactionId = const Value.absent(),
    this.smsHash = const Value.absent(),
    this.metadata = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AuditEventsTableCompanion.insert({
    this.id = const Value.absent(),
    required DateTime timestamp,
    required String type,
    required String deviceId,
    required String appVersion,
    required String actorRole,
    this.actorUserId = const Value.absent(),
    this.smsId = const Value.absent(),
    this.transactionId = const Value.absent(),
    this.smsHash = const Value.absent(),
    this.metadata = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : timestamp = Value(timestamp),
       type = Value(type),
       deviceId = Value(deviceId),
       appVersion = Value(appVersion),
       actorRole = Value(actorRole);
  static Insertable<AuditEventsTableData> custom({
    Expression<String>? id,
    Expression<DateTime>? timestamp,
    Expression<String>? type,
    Expression<String>? deviceId,
    Expression<String>? appVersion,
    Expression<String>? actorRole,
    Expression<String>? actorUserId,
    Expression<String>? smsId,
    Expression<String>? transactionId,
    Expression<String>? smsHash,
    Expression<String>? metadata,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (timestamp != null) 'timestamp': timestamp,
      if (type != null) 'type': type,
      if (deviceId != null) 'device_id': deviceId,
      if (appVersion != null) 'app_version': appVersion,
      if (actorRole != null) 'actor_role': actorRole,
      if (actorUserId != null) 'actor_user_id': actorUserId,
      if (smsId != null) 'sms_id': smsId,
      if (transactionId != null) 'transaction_id': transactionId,
      if (smsHash != null) 'sms_hash': smsHash,
      if (metadata != null) 'metadata': metadata,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AuditEventsTableCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? timestamp,
    Value<String>? type,
    Value<String>? deviceId,
    Value<String>? appVersion,
    Value<String>? actorRole,
    Value<String?>? actorUserId,
    Value<String?>? smsId,
    Value<String?>? transactionId,
    Value<String?>? smsHash,
    Value<String>? metadata,
    Value<int>? rowid,
  }) {
    return AuditEventsTableCompanion(
      id: id ?? this.id,
      timestamp: timestamp ?? this.timestamp,
      type: type ?? this.type,
      deviceId: deviceId ?? this.deviceId,
      appVersion: appVersion ?? this.appVersion,
      actorRole: actorRole ?? this.actorRole,
      actorUserId: actorUserId ?? this.actorUserId,
      smsId: smsId ?? this.smsId,
      transactionId: transactionId ?? this.transactionId,
      smsHash: smsHash ?? this.smsHash,
      metadata: metadata ?? this.metadata,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (timestamp.present) {
      map['timestamp'] = Variable<DateTime>(timestamp.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (deviceId.present) {
      map['device_id'] = Variable<String>(deviceId.value);
    }
    if (appVersion.present) {
      map['app_version'] = Variable<String>(appVersion.value);
    }
    if (actorRole.present) {
      map['actor_role'] = Variable<String>(actorRole.value);
    }
    if (actorUserId.present) {
      map['actor_user_id'] = Variable<String>(actorUserId.value);
    }
    if (smsId.present) {
      map['sms_id'] = Variable<String>(smsId.value);
    }
    if (transactionId.present) {
      map['transaction_id'] = Variable<String>(transactionId.value);
    }
    if (smsHash.present) {
      map['sms_hash'] = Variable<String>(smsHash.value);
    }
    if (metadata.present) {
      map['metadata'] = Variable<String>(metadata.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AuditEventsTableCompanion(')
          ..write('id: $id, ')
          ..write('timestamp: $timestamp, ')
          ..write('type: $type, ')
          ..write('deviceId: $deviceId, ')
          ..write('appVersion: $appVersion, ')
          ..write('actorRole: $actorRole, ')
          ..write('actorUserId: $actorUserId, ')
          ..write('smsId: $smsId, ')
          ..write('transactionId: $transactionId, ')
          ..write('smsHash: $smsHash, ')
          ..write('metadata: $metadata, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $BanksTableTable banksTable = $BanksTableTable(this);
  late final $BankSendersTableTable bankSendersTable = $BankSendersTableTable(
    this,
  );
  late final $ParserRulesTableTable parserRulesTable = $ParserRulesTableTable(
    this,
  );
  late final $SmsMessagesTableTable smsMessagesTable = $SmsMessagesTableTable(
    this,
  );
  late final $TransactionsTableTable transactionsTable =
      $TransactionsTableTable(this);
  late final $PendingTransactionsTableTable pendingTransactionsTable =
      $PendingTransactionsTableTable(this);
  late final $MatchingRecordsTableTable matchingRecordsTable =
      $MatchingRecordsTableTable(this);
  late final $SyncQueueTableTable syncQueueTable = $SyncQueueTableTable(this);
  late final $LogsTableTable logsTable = $LogsTableTable(this);
  late final $AuditEventsTableTable auditEventsTable = $AuditEventsTableTable(
    this,
  );
  late final Index ixSmsMessagesBodyHash = Index(
    'ix_sms_messages_body_hash',
    'CREATE INDEX ix_sms_messages_body_hash ON sms_messages (body_hash)',
  );
  late final Index ixTransactionsTimestamp = Index(
    'ix_transactions_timestamp',
    'CREATE INDEX ix_transactions_timestamp ON transactions (timestamp)',
  );
  late final Index ixTransactionsReferenceNumber = Index(
    'ix_transactions_reference_number',
    'CREATE INDEX ix_transactions_reference_number ON transactions (reference_number)',
  );
  late final Index ixPendingTransactionsStatus = Index(
    'ix_pending_transactions_status',
    'CREATE INDEX ix_pending_transactions_status ON pending_transactions (status)',
  );
  late final Index ixMatchingRecordsStatus = Index(
    'ix_matching_records_status',
    'CREATE INDEX ix_matching_records_status ON matching_records (match_status)',
  );
  late final Index ixMatchingRecordsTransactionId = Index(
    'ix_matching_records_transaction_id',
    'CREATE INDEX ix_matching_records_transaction_id ON matching_records (transaction_id)',
  );
  late final Index ixSyncQueueClaimable = Index(
    'ix_sync_queue_claimable',
    'CREATE INDEX ix_sync_queue_claimable ON sync_queue (status, next_retry_at)',
  );
  late final Index ixSyncQueueEntity = Index(
    'ix_sync_queue_entity',
    'CREATE INDEX ix_sync_queue_entity ON sync_queue (entity_type, entity_id)',
  );
  late final Index ixLogsModuleEvent = Index(
    'ix_logs_module_event',
    'CREATE INDEX ix_logs_module_event ON logs (module, event)',
  );
  late final Index ixLogsLevel = Index(
    'ix_logs_level',
    'CREATE INDEX ix_logs_level ON logs (level)',
  );
  late final Index ixAuditEventsType = Index(
    'ix_audit_events_type',
    'CREATE INDEX ix_audit_events_type ON audit_events (type)',
  );
  late final Index ixAuditEventsTransactionId = Index(
    'ix_audit_events_transaction_id',
    'CREATE INDEX ix_audit_events_transaction_id ON audit_events (transaction_id)',
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    banksTable,
    bankSendersTable,
    parserRulesTable,
    smsMessagesTable,
    transactionsTable,
    pendingTransactionsTable,
    matchingRecordsTable,
    syncQueueTable,
    logsTable,
    auditEventsTable,
    ixSmsMessagesBodyHash,
    ixTransactionsTimestamp,
    ixTransactionsReferenceNumber,
    ixPendingTransactionsStatus,
    ixMatchingRecordsStatus,
    ixMatchingRecordsTransactionId,
    ixSyncQueueClaimable,
    ixSyncQueueEntity,
    ixLogsModuleEvent,
    ixLogsLevel,
    ixAuditEventsType,
    ixAuditEventsTransactionId,
  ];
}

typedef $$BanksTableTableCreateCompanionBuilder =
    BanksTableCompanion Function({
      Value<String> id,
      required String code,
      required String name,
      required String parserType,
      Value<bool> isEnabled,
      Value<String?> parserVersion,
      Value<String> detectionKeywords,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$BanksTableTableUpdateCompanionBuilder =
    BanksTableCompanion Function({
      Value<String> id,
      Value<String> code,
      Value<String> name,
      Value<String> parserType,
      Value<bool> isEnabled,
      Value<String?> parserVersion,
      Value<String> detectionKeywords,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

final class $$BanksTableTableReferences
    extends BaseReferences<_$AppDatabase, $BanksTableTable, BanksTableData> {
  $$BanksTableTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$BankSendersTableTable, List<BankSendersTableData>>
  _bankSendersTableRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.bankSendersTable,
    aliasName: $_aliasNameGenerator(
      db.banksTable.id,
      db.bankSendersTable.bankId,
    ),
  );

  $$BankSendersTableTableProcessedTableManager get bankSendersTableRefs {
    final manager = $$BankSendersTableTableTableManager(
      $_db,
      $_db.bankSendersTable,
    ).filter((f) => f.bankId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _bankSendersTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ParserRulesTableTable, List<ParserRulesTableData>>
  _parserRulesTableRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.parserRulesTable,
    aliasName: $_aliasNameGenerator(
      db.banksTable.id,
      db.parserRulesTable.bankId,
    ),
  );

  $$ParserRulesTableTableProcessedTableManager get parserRulesTableRefs {
    final manager = $$ParserRulesTableTableTableManager(
      $_db,
      $_db.parserRulesTable,
    ).filter((f) => f.bankId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _parserRulesTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $TransactionsTableTable,
    List<TransactionsTableData>
  >
  _transactionsTableRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.transactionsTable,
        aliasName: $_aliasNameGenerator(
          db.banksTable.id,
          db.transactionsTable.bankId,
        ),
      );

  $$TransactionsTableTableProcessedTableManager get transactionsTableRefs {
    final manager = $$TransactionsTableTableTableManager(
      $_db,
      $_db.transactionsTable,
    ).filter((f) => f.bankId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _transactionsTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$BanksTableTableFilterComposer
    extends Composer<_$AppDatabase, $BanksTableTable> {
  $$BanksTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get parserType => $composableBuilder(
    column: $table.parserType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isEnabled => $composableBuilder(
    column: $table.isEnabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get parserVersion => $composableBuilder(
    column: $table.parserVersion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get detectionKeywords => $composableBuilder(
    column: $table.detectionKeywords,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> bankSendersTableRefs(
    Expression<bool> Function($$BankSendersTableTableFilterComposer f) f,
  ) {
    final $$BankSendersTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.bankSendersTable,
      getReferencedColumn: (t) => t.bankId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BankSendersTableTableFilterComposer(
            $db: $db,
            $table: $db.bankSendersTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> parserRulesTableRefs(
    Expression<bool> Function($$ParserRulesTableTableFilterComposer f) f,
  ) {
    final $$ParserRulesTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.parserRulesTable,
      getReferencedColumn: (t) => t.bankId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ParserRulesTableTableFilterComposer(
            $db: $db,
            $table: $db.parserRulesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> transactionsTableRefs(
    Expression<bool> Function($$TransactionsTableTableFilterComposer f) f,
  ) {
    final $$TransactionsTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.transactionsTable,
      getReferencedColumn: (t) => t.bankId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TransactionsTableTableFilterComposer(
            $db: $db,
            $table: $db.transactionsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$BanksTableTableOrderingComposer
    extends Composer<_$AppDatabase, $BanksTableTable> {
  $$BanksTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get parserType => $composableBuilder(
    column: $table.parserType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isEnabled => $composableBuilder(
    column: $table.isEnabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get parserVersion => $composableBuilder(
    column: $table.parserVersion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get detectionKeywords => $composableBuilder(
    column: $table.detectionKeywords,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$BanksTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $BanksTableTable> {
  $$BanksTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get code =>
      $composableBuilder(column: $table.code, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get parserType => $composableBuilder(
    column: $table.parserType,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isEnabled =>
      $composableBuilder(column: $table.isEnabled, builder: (column) => column);

  GeneratedColumn<String> get parserVersion => $composableBuilder(
    column: $table.parserVersion,
    builder: (column) => column,
  );

  GeneratedColumn<String> get detectionKeywords => $composableBuilder(
    column: $table.detectionKeywords,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> bankSendersTableRefs<T extends Object>(
    Expression<T> Function($$BankSendersTableTableAnnotationComposer a) f,
  ) {
    final $$BankSendersTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.bankSendersTable,
      getReferencedColumn: (t) => t.bankId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BankSendersTableTableAnnotationComposer(
            $db: $db,
            $table: $db.bankSendersTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> parserRulesTableRefs<T extends Object>(
    Expression<T> Function($$ParserRulesTableTableAnnotationComposer a) f,
  ) {
    final $$ParserRulesTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.parserRulesTable,
      getReferencedColumn: (t) => t.bankId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ParserRulesTableTableAnnotationComposer(
            $db: $db,
            $table: $db.parserRulesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> transactionsTableRefs<T extends Object>(
    Expression<T> Function($$TransactionsTableTableAnnotationComposer a) f,
  ) {
    final $$TransactionsTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.transactionsTable,
          getReferencedColumn: (t) => t.bankId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$TransactionsTableTableAnnotationComposer(
                $db: $db,
                $table: $db.transactionsTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$BanksTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BanksTableTable,
          BanksTableData,
          $$BanksTableTableFilterComposer,
          $$BanksTableTableOrderingComposer,
          $$BanksTableTableAnnotationComposer,
          $$BanksTableTableCreateCompanionBuilder,
          $$BanksTableTableUpdateCompanionBuilder,
          (BanksTableData, $$BanksTableTableReferences),
          BanksTableData,
          PrefetchHooks Function({
            bool bankSendersTableRefs,
            bool parserRulesTableRefs,
            bool transactionsTableRefs,
          })
        > {
  $$BanksTableTableTableManager(_$AppDatabase db, $BanksTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BanksTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BanksTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BanksTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> code = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> parserType = const Value.absent(),
                Value<bool> isEnabled = const Value.absent(),
                Value<String?> parserVersion = const Value.absent(),
                Value<String> detectionKeywords = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BanksTableCompanion(
                id: id,
                code: code,
                name: name,
                parserType: parserType,
                isEnabled: isEnabled,
                parserVersion: parserVersion,
                detectionKeywords: detectionKeywords,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                required String code,
                required String name,
                required String parserType,
                Value<bool> isEnabled = const Value.absent(),
                Value<String?> parserVersion = const Value.absent(),
                Value<String> detectionKeywords = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => BanksTableCompanion.insert(
                id: id,
                code: code,
                name: name,
                parserType: parserType,
                isEnabled: isEnabled,
                parserVersion: parserVersion,
                detectionKeywords: detectionKeywords,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$BanksTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                bankSendersTableRefs = false,
                parserRulesTableRefs = false,
                transactionsTableRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (bankSendersTableRefs) db.bankSendersTable,
                    if (parserRulesTableRefs) db.parserRulesTable,
                    if (transactionsTableRefs) db.transactionsTable,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (bankSendersTableRefs)
                        await $_getPrefetchedData<
                          BanksTableData,
                          $BanksTableTable,
                          BankSendersTableData
                        >(
                          currentTable: table,
                          referencedTable: $$BanksTableTableReferences
                              ._bankSendersTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$BanksTableTableReferences(
                                db,
                                table,
                                p0,
                              ).bankSendersTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.bankId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (parserRulesTableRefs)
                        await $_getPrefetchedData<
                          BanksTableData,
                          $BanksTableTable,
                          ParserRulesTableData
                        >(
                          currentTable: table,
                          referencedTable: $$BanksTableTableReferences
                              ._parserRulesTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$BanksTableTableReferences(
                                db,
                                table,
                                p0,
                              ).parserRulesTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.bankId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (transactionsTableRefs)
                        await $_getPrefetchedData<
                          BanksTableData,
                          $BanksTableTable,
                          TransactionsTableData
                        >(
                          currentTable: table,
                          referencedTable: $$BanksTableTableReferences
                              ._transactionsTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$BanksTableTableReferences(
                                db,
                                table,
                                p0,
                              ).transactionsTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.bankId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$BanksTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BanksTableTable,
      BanksTableData,
      $$BanksTableTableFilterComposer,
      $$BanksTableTableOrderingComposer,
      $$BanksTableTableAnnotationComposer,
      $$BanksTableTableCreateCompanionBuilder,
      $$BanksTableTableUpdateCompanionBuilder,
      (BanksTableData, $$BanksTableTableReferences),
      BanksTableData,
      PrefetchHooks Function({
        bool bankSendersTableRefs,
        bool parserRulesTableRefs,
        bool transactionsTableRefs,
      })
    >;
typedef $$BankSendersTableTableCreateCompanionBuilder =
    BankSendersTableCompanion Function({
      Value<String> id,
      required String bankId,
      required String sender,
      required String matchType,
      Value<bool> isEnabled,
      Value<String?> label,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$BankSendersTableTableUpdateCompanionBuilder =
    BankSendersTableCompanion Function({
      Value<String> id,
      Value<String> bankId,
      Value<String> sender,
      Value<String> matchType,
      Value<bool> isEnabled,
      Value<String?> label,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

final class $$BankSendersTableTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $BankSendersTableTable,
          BankSendersTableData
        > {
  $$BankSendersTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $BanksTableTable _bankIdTable(_$AppDatabase db) =>
      db.banksTable.createAlias(
        $_aliasNameGenerator(db.bankSendersTable.bankId, db.banksTable.id),
      );

  $$BanksTableTableProcessedTableManager get bankId {
    final $_column = $_itemColumn<String>('bank_id')!;

    final manager = $$BanksTableTableTableManager(
      $_db,
      $_db.banksTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_bankIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$BankSendersTableTableFilterComposer
    extends Composer<_$AppDatabase, $BankSendersTableTable> {
  $$BankSendersTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sender => $composableBuilder(
    column: $table.sender,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get matchType => $composableBuilder(
    column: $table.matchType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isEnabled => $composableBuilder(
    column: $table.isEnabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get label => $composableBuilder(
    column: $table.label,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$BanksTableTableFilterComposer get bankId {
    final $$BanksTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.bankId,
      referencedTable: $db.banksTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BanksTableTableFilterComposer(
            $db: $db,
            $table: $db.banksTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$BankSendersTableTableOrderingComposer
    extends Composer<_$AppDatabase, $BankSendersTableTable> {
  $$BankSendersTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sender => $composableBuilder(
    column: $table.sender,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get matchType => $composableBuilder(
    column: $table.matchType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isEnabled => $composableBuilder(
    column: $table.isEnabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get label => $composableBuilder(
    column: $table.label,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$BanksTableTableOrderingComposer get bankId {
    final $$BanksTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.bankId,
      referencedTable: $db.banksTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BanksTableTableOrderingComposer(
            $db: $db,
            $table: $db.banksTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$BankSendersTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $BankSendersTableTable> {
  $$BankSendersTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get sender =>
      $composableBuilder(column: $table.sender, builder: (column) => column);

  GeneratedColumn<String> get matchType =>
      $composableBuilder(column: $table.matchType, builder: (column) => column);

  GeneratedColumn<bool> get isEnabled =>
      $composableBuilder(column: $table.isEnabled, builder: (column) => column);

  GeneratedColumn<String> get label =>
      $composableBuilder(column: $table.label, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$BanksTableTableAnnotationComposer get bankId {
    final $$BanksTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.bankId,
      referencedTable: $db.banksTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BanksTableTableAnnotationComposer(
            $db: $db,
            $table: $db.banksTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$BankSendersTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BankSendersTableTable,
          BankSendersTableData,
          $$BankSendersTableTableFilterComposer,
          $$BankSendersTableTableOrderingComposer,
          $$BankSendersTableTableAnnotationComposer,
          $$BankSendersTableTableCreateCompanionBuilder,
          $$BankSendersTableTableUpdateCompanionBuilder,
          (BankSendersTableData, $$BankSendersTableTableReferences),
          BankSendersTableData,
          PrefetchHooks Function({bool bankId})
        > {
  $$BankSendersTableTableTableManager(
    _$AppDatabase db,
    $BankSendersTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BankSendersTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BankSendersTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BankSendersTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> bankId = const Value.absent(),
                Value<String> sender = const Value.absent(),
                Value<String> matchType = const Value.absent(),
                Value<bool> isEnabled = const Value.absent(),
                Value<String?> label = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BankSendersTableCompanion(
                id: id,
                bankId: bankId,
                sender: sender,
                matchType: matchType,
                isEnabled: isEnabled,
                label: label,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                required String bankId,
                required String sender,
                required String matchType,
                Value<bool> isEnabled = const Value.absent(),
                Value<String?> label = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => BankSendersTableCompanion.insert(
                id: id,
                bankId: bankId,
                sender: sender,
                matchType: matchType,
                isEnabled: isEnabled,
                label: label,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$BankSendersTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({bankId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (bankId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.bankId,
                                referencedTable:
                                    $$BankSendersTableTableReferences
                                        ._bankIdTable(db),
                                referencedColumn:
                                    $$BankSendersTableTableReferences
                                        ._bankIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$BankSendersTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BankSendersTableTable,
      BankSendersTableData,
      $$BankSendersTableTableFilterComposer,
      $$BankSendersTableTableOrderingComposer,
      $$BankSendersTableTableAnnotationComposer,
      $$BankSendersTableTableCreateCompanionBuilder,
      $$BankSendersTableTableUpdateCompanionBuilder,
      (BankSendersTableData, $$BankSendersTableTableReferences),
      BankSendersTableData,
      PrefetchHooks Function({bool bankId})
    >;
typedef $$ParserRulesTableTableCreateCompanionBuilder =
    ParserRulesTableCompanion Function({
      Value<String> id,
      required String bankId,
      required String field,
      required String ruleType,
      Value<String?> pattern,
      Value<int> extractionGroup,
      Value<String> keywords,
      Value<String> validation,
      Value<int> priority,
      Value<bool> isRequired,
      Value<bool> isActive,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$ParserRulesTableTableUpdateCompanionBuilder =
    ParserRulesTableCompanion Function({
      Value<String> id,
      Value<String> bankId,
      Value<String> field,
      Value<String> ruleType,
      Value<String?> pattern,
      Value<int> extractionGroup,
      Value<String> keywords,
      Value<String> validation,
      Value<int> priority,
      Value<bool> isRequired,
      Value<bool> isActive,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

final class $$ParserRulesTableTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $ParserRulesTableTable,
          ParserRulesTableData
        > {
  $$ParserRulesTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $BanksTableTable _bankIdTable(_$AppDatabase db) =>
      db.banksTable.createAlias(
        $_aliasNameGenerator(db.parserRulesTable.bankId, db.banksTable.id),
      );

  $$BanksTableTableProcessedTableManager get bankId {
    final $_column = $_itemColumn<String>('bank_id')!;

    final manager = $$BanksTableTableTableManager(
      $_db,
      $_db.banksTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_bankIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ParserRulesTableTableFilterComposer
    extends Composer<_$AppDatabase, $ParserRulesTableTable> {
  $$ParserRulesTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get field => $composableBuilder(
    column: $table.field,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get ruleType => $composableBuilder(
    column: $table.ruleType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get pattern => $composableBuilder(
    column: $table.pattern,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get extractionGroup => $composableBuilder(
    column: $table.extractionGroup,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get keywords => $composableBuilder(
    column: $table.keywords,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get validation => $composableBuilder(
    column: $table.validation,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get priority => $composableBuilder(
    column: $table.priority,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isRequired => $composableBuilder(
    column: $table.isRequired,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$BanksTableTableFilterComposer get bankId {
    final $$BanksTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.bankId,
      referencedTable: $db.banksTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BanksTableTableFilterComposer(
            $db: $db,
            $table: $db.banksTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ParserRulesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $ParserRulesTableTable> {
  $$ParserRulesTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get field => $composableBuilder(
    column: $table.field,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get ruleType => $composableBuilder(
    column: $table.ruleType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get pattern => $composableBuilder(
    column: $table.pattern,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get extractionGroup => $composableBuilder(
    column: $table.extractionGroup,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get keywords => $composableBuilder(
    column: $table.keywords,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get validation => $composableBuilder(
    column: $table.validation,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get priority => $composableBuilder(
    column: $table.priority,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isRequired => $composableBuilder(
    column: $table.isRequired,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$BanksTableTableOrderingComposer get bankId {
    final $$BanksTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.bankId,
      referencedTable: $db.banksTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BanksTableTableOrderingComposer(
            $db: $db,
            $table: $db.banksTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ParserRulesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $ParserRulesTableTable> {
  $$ParserRulesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get field =>
      $composableBuilder(column: $table.field, builder: (column) => column);

  GeneratedColumn<String> get ruleType =>
      $composableBuilder(column: $table.ruleType, builder: (column) => column);

  GeneratedColumn<String> get pattern =>
      $composableBuilder(column: $table.pattern, builder: (column) => column);

  GeneratedColumn<int> get extractionGroup => $composableBuilder(
    column: $table.extractionGroup,
    builder: (column) => column,
  );

  GeneratedColumn<String> get keywords =>
      $composableBuilder(column: $table.keywords, builder: (column) => column);

  GeneratedColumn<String> get validation => $composableBuilder(
    column: $table.validation,
    builder: (column) => column,
  );

  GeneratedColumn<int> get priority =>
      $composableBuilder(column: $table.priority, builder: (column) => column);

  GeneratedColumn<bool> get isRequired => $composableBuilder(
    column: $table.isRequired,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$BanksTableTableAnnotationComposer get bankId {
    final $$BanksTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.bankId,
      referencedTable: $db.banksTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BanksTableTableAnnotationComposer(
            $db: $db,
            $table: $db.banksTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ParserRulesTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ParserRulesTableTable,
          ParserRulesTableData,
          $$ParserRulesTableTableFilterComposer,
          $$ParserRulesTableTableOrderingComposer,
          $$ParserRulesTableTableAnnotationComposer,
          $$ParserRulesTableTableCreateCompanionBuilder,
          $$ParserRulesTableTableUpdateCompanionBuilder,
          (ParserRulesTableData, $$ParserRulesTableTableReferences),
          ParserRulesTableData,
          PrefetchHooks Function({bool bankId})
        > {
  $$ParserRulesTableTableTableManager(
    _$AppDatabase db,
    $ParserRulesTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ParserRulesTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ParserRulesTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ParserRulesTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> bankId = const Value.absent(),
                Value<String> field = const Value.absent(),
                Value<String> ruleType = const Value.absent(),
                Value<String?> pattern = const Value.absent(),
                Value<int> extractionGroup = const Value.absent(),
                Value<String> keywords = const Value.absent(),
                Value<String> validation = const Value.absent(),
                Value<int> priority = const Value.absent(),
                Value<bool> isRequired = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ParserRulesTableCompanion(
                id: id,
                bankId: bankId,
                field: field,
                ruleType: ruleType,
                pattern: pattern,
                extractionGroup: extractionGroup,
                keywords: keywords,
                validation: validation,
                priority: priority,
                isRequired: isRequired,
                isActive: isActive,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                required String bankId,
                required String field,
                required String ruleType,
                Value<String?> pattern = const Value.absent(),
                Value<int> extractionGroup = const Value.absent(),
                Value<String> keywords = const Value.absent(),
                Value<String> validation = const Value.absent(),
                Value<int> priority = const Value.absent(),
                Value<bool> isRequired = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => ParserRulesTableCompanion.insert(
                id: id,
                bankId: bankId,
                field: field,
                ruleType: ruleType,
                pattern: pattern,
                extractionGroup: extractionGroup,
                keywords: keywords,
                validation: validation,
                priority: priority,
                isRequired: isRequired,
                isActive: isActive,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ParserRulesTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({bankId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (bankId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.bankId,
                                referencedTable:
                                    $$ParserRulesTableTableReferences
                                        ._bankIdTable(db),
                                referencedColumn:
                                    $$ParserRulesTableTableReferences
                                        ._bankIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ParserRulesTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ParserRulesTableTable,
      ParserRulesTableData,
      $$ParserRulesTableTableFilterComposer,
      $$ParserRulesTableTableOrderingComposer,
      $$ParserRulesTableTableAnnotationComposer,
      $$ParserRulesTableTableCreateCompanionBuilder,
      $$ParserRulesTableTableUpdateCompanionBuilder,
      (ParserRulesTableData, $$ParserRulesTableTableReferences),
      ParserRulesTableData,
      PrefetchHooks Function({bool bankId})
    >;
typedef $$SmsMessagesTableTableCreateCompanionBuilder =
    SmsMessagesTableCompanion Function({
      Value<String> id,
      required String deviceId,
      required String sender,
      required String body,
      required String bodyHash,
      required DateTime receivedAt,
      required String processingStatus,
      required String source,
      required DateTime createdAt,
      Value<String?> normalizedBody,
      Value<DateTime?> processedAt,
      Value<int> rowid,
    });
typedef $$SmsMessagesTableTableUpdateCompanionBuilder =
    SmsMessagesTableCompanion Function({
      Value<String> id,
      Value<String> deviceId,
      Value<String> sender,
      Value<String> body,
      Value<String> bodyHash,
      Value<DateTime> receivedAt,
      Value<String> processingStatus,
      Value<String> source,
      Value<DateTime> createdAt,
      Value<String?> normalizedBody,
      Value<DateTime?> processedAt,
      Value<int> rowid,
    });

final class $$SmsMessagesTableTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $SmsMessagesTableTable,
          SmsMessagesTableData
        > {
  $$SmsMessagesTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<
    $TransactionsTableTable,
    List<TransactionsTableData>
  >
  _transactionsTableRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.transactionsTable,
        aliasName: $_aliasNameGenerator(
          db.smsMessagesTable.id,
          db.transactionsTable.smsId,
        ),
      );

  $$TransactionsTableTableProcessedTableManager get transactionsTableRefs {
    final manager = $$TransactionsTableTableTableManager(
      $_db,
      $_db.transactionsTable,
    ).filter((f) => f.smsId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _transactionsTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$SmsMessagesTableTableFilterComposer
    extends Composer<_$AppDatabase, $SmsMessagesTableTable> {
  $$SmsMessagesTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get deviceId => $composableBuilder(
    column: $table.deviceId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sender => $composableBuilder(
    column: $table.sender,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get body => $composableBuilder(
    column: $table.body,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get bodyHash => $composableBuilder(
    column: $table.bodyHash,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get receivedAt => $composableBuilder(
    column: $table.receivedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get processingStatus => $composableBuilder(
    column: $table.processingStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get normalizedBody => $composableBuilder(
    column: $table.normalizedBody,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get processedAt => $composableBuilder(
    column: $table.processedAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> transactionsTableRefs(
    Expression<bool> Function($$TransactionsTableTableFilterComposer f) f,
  ) {
    final $$TransactionsTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.transactionsTable,
      getReferencedColumn: (t) => t.smsId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TransactionsTableTableFilterComposer(
            $db: $db,
            $table: $db.transactionsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$SmsMessagesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $SmsMessagesTableTable> {
  $$SmsMessagesTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get deviceId => $composableBuilder(
    column: $table.deviceId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sender => $composableBuilder(
    column: $table.sender,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get body => $composableBuilder(
    column: $table.body,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get bodyHash => $composableBuilder(
    column: $table.bodyHash,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get receivedAt => $composableBuilder(
    column: $table.receivedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get processingStatus => $composableBuilder(
    column: $table.processingStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get normalizedBody => $composableBuilder(
    column: $table.normalizedBody,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get processedAt => $composableBuilder(
    column: $table.processedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SmsMessagesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $SmsMessagesTableTable> {
  $$SmsMessagesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get deviceId =>
      $composableBuilder(column: $table.deviceId, builder: (column) => column);

  GeneratedColumn<String> get sender =>
      $composableBuilder(column: $table.sender, builder: (column) => column);

  GeneratedColumn<String> get body =>
      $composableBuilder(column: $table.body, builder: (column) => column);

  GeneratedColumn<String> get bodyHash =>
      $composableBuilder(column: $table.bodyHash, builder: (column) => column);

  GeneratedColumn<DateTime> get receivedAt => $composableBuilder(
    column: $table.receivedAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get processingStatus => $composableBuilder(
    column: $table.processingStatus,
    builder: (column) => column,
  );

  GeneratedColumn<String> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get normalizedBody => $composableBuilder(
    column: $table.normalizedBody,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get processedAt => $composableBuilder(
    column: $table.processedAt,
    builder: (column) => column,
  );

  Expression<T> transactionsTableRefs<T extends Object>(
    Expression<T> Function($$TransactionsTableTableAnnotationComposer a) f,
  ) {
    final $$TransactionsTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.transactionsTable,
          getReferencedColumn: (t) => t.smsId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$TransactionsTableTableAnnotationComposer(
                $db: $db,
                $table: $db.transactionsTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$SmsMessagesTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SmsMessagesTableTable,
          SmsMessagesTableData,
          $$SmsMessagesTableTableFilterComposer,
          $$SmsMessagesTableTableOrderingComposer,
          $$SmsMessagesTableTableAnnotationComposer,
          $$SmsMessagesTableTableCreateCompanionBuilder,
          $$SmsMessagesTableTableUpdateCompanionBuilder,
          (SmsMessagesTableData, $$SmsMessagesTableTableReferences),
          SmsMessagesTableData,
          PrefetchHooks Function({bool transactionsTableRefs})
        > {
  $$SmsMessagesTableTableTableManager(
    _$AppDatabase db,
    $SmsMessagesTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SmsMessagesTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SmsMessagesTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SmsMessagesTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> deviceId = const Value.absent(),
                Value<String> sender = const Value.absent(),
                Value<String> body = const Value.absent(),
                Value<String> bodyHash = const Value.absent(),
                Value<DateTime> receivedAt = const Value.absent(),
                Value<String> processingStatus = const Value.absent(),
                Value<String> source = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<String?> normalizedBody = const Value.absent(),
                Value<DateTime?> processedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SmsMessagesTableCompanion(
                id: id,
                deviceId: deviceId,
                sender: sender,
                body: body,
                bodyHash: bodyHash,
                receivedAt: receivedAt,
                processingStatus: processingStatus,
                source: source,
                createdAt: createdAt,
                normalizedBody: normalizedBody,
                processedAt: processedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                required String deviceId,
                required String sender,
                required String body,
                required String bodyHash,
                required DateTime receivedAt,
                required String processingStatus,
                required String source,
                required DateTime createdAt,
                Value<String?> normalizedBody = const Value.absent(),
                Value<DateTime?> processedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SmsMessagesTableCompanion.insert(
                id: id,
                deviceId: deviceId,
                sender: sender,
                body: body,
                bodyHash: bodyHash,
                receivedAt: receivedAt,
                processingStatus: processingStatus,
                source: source,
                createdAt: createdAt,
                normalizedBody: normalizedBody,
                processedAt: processedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$SmsMessagesTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({transactionsTableRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (transactionsTableRefs) db.transactionsTable,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (transactionsTableRefs)
                    await $_getPrefetchedData<
                      SmsMessagesTableData,
                      $SmsMessagesTableTable,
                      TransactionsTableData
                    >(
                      currentTable: table,
                      referencedTable: $$SmsMessagesTableTableReferences
                          ._transactionsTableRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$SmsMessagesTableTableReferences(
                            db,
                            table,
                            p0,
                          ).transactionsTableRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.smsId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$SmsMessagesTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SmsMessagesTableTable,
      SmsMessagesTableData,
      $$SmsMessagesTableTableFilterComposer,
      $$SmsMessagesTableTableOrderingComposer,
      $$SmsMessagesTableTableAnnotationComposer,
      $$SmsMessagesTableTableCreateCompanionBuilder,
      $$SmsMessagesTableTableUpdateCompanionBuilder,
      (SmsMessagesTableData, $$SmsMessagesTableTableReferences),
      SmsMessagesTableData,
      PrefetchHooks Function({bool transactionsTableRefs})
    >;
typedef $$TransactionsTableTableCreateCompanionBuilder =
    TransactionsTableCompanion Function({
      Value<String> id,
      required String smsId,
      required String deviceId,
      required String bankId,
      required String bankCode,
      required String bankName,
      required String type,
      required int amount,
      required String currency,
      required DateTime timestamp,
      Value<String?> cardNumberMasked,
      Value<String?> accountNumber,
      Value<String?> referenceNumber,
      Value<String?> traceNumber,
      Value<int?> balance,
      required double confidenceScore,
      required String status,
      required String dedupKey,
      required String sourceSmsHash,
      required String parserVersion,
      Value<String?> serverTransactionId,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$TransactionsTableTableUpdateCompanionBuilder =
    TransactionsTableCompanion Function({
      Value<String> id,
      Value<String> smsId,
      Value<String> deviceId,
      Value<String> bankId,
      Value<String> bankCode,
      Value<String> bankName,
      Value<String> type,
      Value<int> amount,
      Value<String> currency,
      Value<DateTime> timestamp,
      Value<String?> cardNumberMasked,
      Value<String?> accountNumber,
      Value<String?> referenceNumber,
      Value<String?> traceNumber,
      Value<int?> balance,
      Value<double> confidenceScore,
      Value<String> status,
      Value<String> dedupKey,
      Value<String> sourceSmsHash,
      Value<String> parserVersion,
      Value<String?> serverTransactionId,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

final class $$TransactionsTableTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $TransactionsTableTable,
          TransactionsTableData
        > {
  $$TransactionsTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $SmsMessagesTableTable _smsIdTable(_$AppDatabase db) =>
      db.smsMessagesTable.createAlias(
        $_aliasNameGenerator(
          db.transactionsTable.smsId,
          db.smsMessagesTable.id,
        ),
      );

  $$SmsMessagesTableTableProcessedTableManager get smsId {
    final $_column = $_itemColumn<String>('sms_id')!;

    final manager = $$SmsMessagesTableTableTableManager(
      $_db,
      $_db.smsMessagesTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_smsIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $BanksTableTable _bankIdTable(_$AppDatabase db) =>
      db.banksTable.createAlias(
        $_aliasNameGenerator(db.transactionsTable.bankId, db.banksTable.id),
      );

  $$BanksTableTableProcessedTableManager get bankId {
    final $_column = $_itemColumn<String>('bank_id')!;

    final manager = $$BanksTableTableTableManager(
      $_db,
      $_db.banksTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_bankIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$TransactionsTableTableFilterComposer
    extends Composer<_$AppDatabase, $TransactionsTableTable> {
  $$TransactionsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get deviceId => $composableBuilder(
    column: $table.deviceId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get bankCode => $composableBuilder(
    column: $table.bankCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get bankName => $composableBuilder(
    column: $table.bankName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get currency => $composableBuilder(
    column: $table.currency,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get cardNumberMasked => $composableBuilder(
    column: $table.cardNumberMasked,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get accountNumber => $composableBuilder(
    column: $table.accountNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get referenceNumber => $composableBuilder(
    column: $table.referenceNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get traceNumber => $composableBuilder(
    column: $table.traceNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get balance => $composableBuilder(
    column: $table.balance,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get confidenceScore => $composableBuilder(
    column: $table.confidenceScore,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get dedupKey => $composableBuilder(
    column: $table.dedupKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sourceSmsHash => $composableBuilder(
    column: $table.sourceSmsHash,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get parserVersion => $composableBuilder(
    column: $table.parserVersion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get serverTransactionId => $composableBuilder(
    column: $table.serverTransactionId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$SmsMessagesTableTableFilterComposer get smsId {
    final $$SmsMessagesTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.smsId,
      referencedTable: $db.smsMessagesTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SmsMessagesTableTableFilterComposer(
            $db: $db,
            $table: $db.smsMessagesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$BanksTableTableFilterComposer get bankId {
    final $$BanksTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.bankId,
      referencedTable: $db.banksTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BanksTableTableFilterComposer(
            $db: $db,
            $table: $db.banksTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TransactionsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $TransactionsTableTable> {
  $$TransactionsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get deviceId => $composableBuilder(
    column: $table.deviceId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get bankCode => $composableBuilder(
    column: $table.bankCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get bankName => $composableBuilder(
    column: $table.bankName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get currency => $composableBuilder(
    column: $table.currency,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get cardNumberMasked => $composableBuilder(
    column: $table.cardNumberMasked,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get accountNumber => $composableBuilder(
    column: $table.accountNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get referenceNumber => $composableBuilder(
    column: $table.referenceNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get traceNumber => $composableBuilder(
    column: $table.traceNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get balance => $composableBuilder(
    column: $table.balance,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get confidenceScore => $composableBuilder(
    column: $table.confidenceScore,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get dedupKey => $composableBuilder(
    column: $table.dedupKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sourceSmsHash => $composableBuilder(
    column: $table.sourceSmsHash,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get parserVersion => $composableBuilder(
    column: $table.parserVersion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get serverTransactionId => $composableBuilder(
    column: $table.serverTransactionId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$SmsMessagesTableTableOrderingComposer get smsId {
    final $$SmsMessagesTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.smsId,
      referencedTable: $db.smsMessagesTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SmsMessagesTableTableOrderingComposer(
            $db: $db,
            $table: $db.smsMessagesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$BanksTableTableOrderingComposer get bankId {
    final $$BanksTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.bankId,
      referencedTable: $db.banksTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BanksTableTableOrderingComposer(
            $db: $db,
            $table: $db.banksTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TransactionsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $TransactionsTableTable> {
  $$TransactionsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get deviceId =>
      $composableBuilder(column: $table.deviceId, builder: (column) => column);

  GeneratedColumn<String> get bankCode =>
      $composableBuilder(column: $table.bankCode, builder: (column) => column);

  GeneratedColumn<String> get bankName =>
      $composableBuilder(column: $table.bankName, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<int> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<String> get currency =>
      $composableBuilder(column: $table.currency, builder: (column) => column);

  GeneratedColumn<DateTime> get timestamp =>
      $composableBuilder(column: $table.timestamp, builder: (column) => column);

  GeneratedColumn<String> get cardNumberMasked => $composableBuilder(
    column: $table.cardNumberMasked,
    builder: (column) => column,
  );

  GeneratedColumn<String> get accountNumber => $composableBuilder(
    column: $table.accountNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get referenceNumber => $composableBuilder(
    column: $table.referenceNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get traceNumber => $composableBuilder(
    column: $table.traceNumber,
    builder: (column) => column,
  );

  GeneratedColumn<int> get balance =>
      $composableBuilder(column: $table.balance, builder: (column) => column);

  GeneratedColumn<double> get confidenceScore => $composableBuilder(
    column: $table.confidenceScore,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get dedupKey =>
      $composableBuilder(column: $table.dedupKey, builder: (column) => column);

  GeneratedColumn<String> get sourceSmsHash => $composableBuilder(
    column: $table.sourceSmsHash,
    builder: (column) => column,
  );

  GeneratedColumn<String> get parserVersion => $composableBuilder(
    column: $table.parserVersion,
    builder: (column) => column,
  );

  GeneratedColumn<String> get serverTransactionId => $composableBuilder(
    column: $table.serverTransactionId,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$SmsMessagesTableTableAnnotationComposer get smsId {
    final $$SmsMessagesTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.smsId,
      referencedTable: $db.smsMessagesTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SmsMessagesTableTableAnnotationComposer(
            $db: $db,
            $table: $db.smsMessagesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$BanksTableTableAnnotationComposer get bankId {
    final $$BanksTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.bankId,
      referencedTable: $db.banksTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BanksTableTableAnnotationComposer(
            $db: $db,
            $table: $db.banksTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TransactionsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TransactionsTableTable,
          TransactionsTableData,
          $$TransactionsTableTableFilterComposer,
          $$TransactionsTableTableOrderingComposer,
          $$TransactionsTableTableAnnotationComposer,
          $$TransactionsTableTableCreateCompanionBuilder,
          $$TransactionsTableTableUpdateCompanionBuilder,
          (TransactionsTableData, $$TransactionsTableTableReferences),
          TransactionsTableData,
          PrefetchHooks Function({bool smsId, bool bankId})
        > {
  $$TransactionsTableTableTableManager(
    _$AppDatabase db,
    $TransactionsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TransactionsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TransactionsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TransactionsTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> smsId = const Value.absent(),
                Value<String> deviceId = const Value.absent(),
                Value<String> bankId = const Value.absent(),
                Value<String> bankCode = const Value.absent(),
                Value<String> bankName = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<int> amount = const Value.absent(),
                Value<String> currency = const Value.absent(),
                Value<DateTime> timestamp = const Value.absent(),
                Value<String?> cardNumberMasked = const Value.absent(),
                Value<String?> accountNumber = const Value.absent(),
                Value<String?> referenceNumber = const Value.absent(),
                Value<String?> traceNumber = const Value.absent(),
                Value<int?> balance = const Value.absent(),
                Value<double> confidenceScore = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String> dedupKey = const Value.absent(),
                Value<String> sourceSmsHash = const Value.absent(),
                Value<String> parserVersion = const Value.absent(),
                Value<String?> serverTransactionId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TransactionsTableCompanion(
                id: id,
                smsId: smsId,
                deviceId: deviceId,
                bankId: bankId,
                bankCode: bankCode,
                bankName: bankName,
                type: type,
                amount: amount,
                currency: currency,
                timestamp: timestamp,
                cardNumberMasked: cardNumberMasked,
                accountNumber: accountNumber,
                referenceNumber: referenceNumber,
                traceNumber: traceNumber,
                balance: balance,
                confidenceScore: confidenceScore,
                status: status,
                dedupKey: dedupKey,
                sourceSmsHash: sourceSmsHash,
                parserVersion: parserVersion,
                serverTransactionId: serverTransactionId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                required String smsId,
                required String deviceId,
                required String bankId,
                required String bankCode,
                required String bankName,
                required String type,
                required int amount,
                required String currency,
                required DateTime timestamp,
                Value<String?> cardNumberMasked = const Value.absent(),
                Value<String?> accountNumber = const Value.absent(),
                Value<String?> referenceNumber = const Value.absent(),
                Value<String?> traceNumber = const Value.absent(),
                Value<int?> balance = const Value.absent(),
                required double confidenceScore,
                required String status,
                required String dedupKey,
                required String sourceSmsHash,
                required String parserVersion,
                Value<String?> serverTransactionId = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => TransactionsTableCompanion.insert(
                id: id,
                smsId: smsId,
                deviceId: deviceId,
                bankId: bankId,
                bankCode: bankCode,
                bankName: bankName,
                type: type,
                amount: amount,
                currency: currency,
                timestamp: timestamp,
                cardNumberMasked: cardNumberMasked,
                accountNumber: accountNumber,
                referenceNumber: referenceNumber,
                traceNumber: traceNumber,
                balance: balance,
                confidenceScore: confidenceScore,
                status: status,
                dedupKey: dedupKey,
                sourceSmsHash: sourceSmsHash,
                parserVersion: parserVersion,
                serverTransactionId: serverTransactionId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$TransactionsTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({smsId = false, bankId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (smsId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.smsId,
                                referencedTable:
                                    $$TransactionsTableTableReferences
                                        ._smsIdTable(db),
                                referencedColumn:
                                    $$TransactionsTableTableReferences
                                        ._smsIdTable(db)
                                        .id,
                              )
                              as T;
                    }
                    if (bankId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.bankId,
                                referencedTable:
                                    $$TransactionsTableTableReferences
                                        ._bankIdTable(db),
                                referencedColumn:
                                    $$TransactionsTableTableReferences
                                        ._bankIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$TransactionsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TransactionsTableTable,
      TransactionsTableData,
      $$TransactionsTableTableFilterComposer,
      $$TransactionsTableTableOrderingComposer,
      $$TransactionsTableTableAnnotationComposer,
      $$TransactionsTableTableCreateCompanionBuilder,
      $$TransactionsTableTableUpdateCompanionBuilder,
      (TransactionsTableData, $$TransactionsTableTableReferences),
      TransactionsTableData,
      PrefetchHooks Function({bool smsId, bool bankId})
    >;
typedef $$PendingTransactionsTableTableCreateCompanionBuilder =
    PendingTransactionsTableCompanion Function({
      Value<String> id,
      required String title,
      required String type,
      required int amount,
      required String currency,
      Value<String?> bankCode,
      Value<String?> cardHint,
      Value<String?> referenceHint,
      Value<DateTime?> validFrom,
      Value<DateTime?> validUntil,
      required String status,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$PendingTransactionsTableTableUpdateCompanionBuilder =
    PendingTransactionsTableCompanion Function({
      Value<String> id,
      Value<String> title,
      Value<String> type,
      Value<int> amount,
      Value<String> currency,
      Value<String?> bankCode,
      Value<String?> cardHint,
      Value<String?> referenceHint,
      Value<DateTime?> validFrom,
      Value<DateTime?> validUntil,
      Value<String> status,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$PendingTransactionsTableTableFilterComposer
    extends Composer<_$AppDatabase, $PendingTransactionsTableTable> {
  $$PendingTransactionsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get currency => $composableBuilder(
    column: $table.currency,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get bankCode => $composableBuilder(
    column: $table.bankCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get cardHint => $composableBuilder(
    column: $table.cardHint,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get referenceHint => $composableBuilder(
    column: $table.referenceHint,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get validFrom => $composableBuilder(
    column: $table.validFrom,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get validUntil => $composableBuilder(
    column: $table.validUntil,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PendingTransactionsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $PendingTransactionsTableTable> {
  $$PendingTransactionsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get currency => $composableBuilder(
    column: $table.currency,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get bankCode => $composableBuilder(
    column: $table.bankCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get cardHint => $composableBuilder(
    column: $table.cardHint,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get referenceHint => $composableBuilder(
    column: $table.referenceHint,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get validFrom => $composableBuilder(
    column: $table.validFrom,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get validUntil => $composableBuilder(
    column: $table.validUntil,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PendingTransactionsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $PendingTransactionsTableTable> {
  $$PendingTransactionsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<int> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<String> get currency =>
      $composableBuilder(column: $table.currency, builder: (column) => column);

  GeneratedColumn<String> get bankCode =>
      $composableBuilder(column: $table.bankCode, builder: (column) => column);

  GeneratedColumn<String> get cardHint =>
      $composableBuilder(column: $table.cardHint, builder: (column) => column);

  GeneratedColumn<String> get referenceHint => $composableBuilder(
    column: $table.referenceHint,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get validFrom =>
      $composableBuilder(column: $table.validFrom, builder: (column) => column);

  GeneratedColumn<DateTime> get validUntil => $composableBuilder(
    column: $table.validUntil,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$PendingTransactionsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PendingTransactionsTableTable,
          PendingTransactionsTableData,
          $$PendingTransactionsTableTableFilterComposer,
          $$PendingTransactionsTableTableOrderingComposer,
          $$PendingTransactionsTableTableAnnotationComposer,
          $$PendingTransactionsTableTableCreateCompanionBuilder,
          $$PendingTransactionsTableTableUpdateCompanionBuilder,
          (
            PendingTransactionsTableData,
            BaseReferences<
              _$AppDatabase,
              $PendingTransactionsTableTable,
              PendingTransactionsTableData
            >,
          ),
          PendingTransactionsTableData,
          PrefetchHooks Function()
        > {
  $$PendingTransactionsTableTableTableManager(
    _$AppDatabase db,
    $PendingTransactionsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PendingTransactionsTableTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$PendingTransactionsTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$PendingTransactionsTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<int> amount = const Value.absent(),
                Value<String> currency = const Value.absent(),
                Value<String?> bankCode = const Value.absent(),
                Value<String?> cardHint = const Value.absent(),
                Value<String?> referenceHint = const Value.absent(),
                Value<DateTime?> validFrom = const Value.absent(),
                Value<DateTime?> validUntil = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PendingTransactionsTableCompanion(
                id: id,
                title: title,
                type: type,
                amount: amount,
                currency: currency,
                bankCode: bankCode,
                cardHint: cardHint,
                referenceHint: referenceHint,
                validFrom: validFrom,
                validUntil: validUntil,
                status: status,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                required String title,
                required String type,
                required int amount,
                required String currency,
                Value<String?> bankCode = const Value.absent(),
                Value<String?> cardHint = const Value.absent(),
                Value<String?> referenceHint = const Value.absent(),
                Value<DateTime?> validFrom = const Value.absent(),
                Value<DateTime?> validUntil = const Value.absent(),
                required String status,
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => PendingTransactionsTableCompanion.insert(
                id: id,
                title: title,
                type: type,
                amount: amount,
                currency: currency,
                bankCode: bankCode,
                cardHint: cardHint,
                referenceHint: referenceHint,
                validFrom: validFrom,
                validUntil: validUntil,
                status: status,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PendingTransactionsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PendingTransactionsTableTable,
      PendingTransactionsTableData,
      $$PendingTransactionsTableTableFilterComposer,
      $$PendingTransactionsTableTableOrderingComposer,
      $$PendingTransactionsTableTableAnnotationComposer,
      $$PendingTransactionsTableTableCreateCompanionBuilder,
      $$PendingTransactionsTableTableUpdateCompanionBuilder,
      (
        PendingTransactionsTableData,
        BaseReferences<
          _$AppDatabase,
          $PendingTransactionsTableTable,
          PendingTransactionsTableData
        >,
      ),
      PendingTransactionsTableData,
      PrefetchHooks Function()
    >;
typedef $$MatchingRecordsTableTableCreateCompanionBuilder =
    MatchingRecordsTableCompanion Function({
      Value<String> id,
      required String transactionId,
      required String pendingTransactionId,
      required String matchStatus,
      required double score,
      Value<String> payload,
      Value<String> decisionSource,
      Value<String?> decidedBy,
      Value<DateTime?> decidedAt,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$MatchingRecordsTableTableUpdateCompanionBuilder =
    MatchingRecordsTableCompanion Function({
      Value<String> id,
      Value<String> transactionId,
      Value<String> pendingTransactionId,
      Value<String> matchStatus,
      Value<double> score,
      Value<String> payload,
      Value<String> decisionSource,
      Value<String?> decidedBy,
      Value<DateTime?> decidedAt,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$MatchingRecordsTableTableFilterComposer
    extends Composer<_$AppDatabase, $MatchingRecordsTableTable> {
  $$MatchingRecordsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get transactionId => $composableBuilder(
    column: $table.transactionId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get pendingTransactionId => $composableBuilder(
    column: $table.pendingTransactionId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get matchStatus => $composableBuilder(
    column: $table.matchStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get score => $composableBuilder(
    column: $table.score,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get payload => $composableBuilder(
    column: $table.payload,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get decisionSource => $composableBuilder(
    column: $table.decisionSource,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get decidedBy => $composableBuilder(
    column: $table.decidedBy,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get decidedAt => $composableBuilder(
    column: $table.decidedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$MatchingRecordsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $MatchingRecordsTableTable> {
  $$MatchingRecordsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get transactionId => $composableBuilder(
    column: $table.transactionId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get pendingTransactionId => $composableBuilder(
    column: $table.pendingTransactionId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get matchStatus => $composableBuilder(
    column: $table.matchStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get score => $composableBuilder(
    column: $table.score,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get payload => $composableBuilder(
    column: $table.payload,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get decisionSource => $composableBuilder(
    column: $table.decisionSource,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get decidedBy => $composableBuilder(
    column: $table.decidedBy,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get decidedAt => $composableBuilder(
    column: $table.decidedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$MatchingRecordsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $MatchingRecordsTableTable> {
  $$MatchingRecordsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get transactionId => $composableBuilder(
    column: $table.transactionId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get pendingTransactionId => $composableBuilder(
    column: $table.pendingTransactionId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get matchStatus => $composableBuilder(
    column: $table.matchStatus,
    builder: (column) => column,
  );

  GeneratedColumn<double> get score =>
      $composableBuilder(column: $table.score, builder: (column) => column);

  GeneratedColumn<String> get payload =>
      $composableBuilder(column: $table.payload, builder: (column) => column);

  GeneratedColumn<String> get decisionSource => $composableBuilder(
    column: $table.decisionSource,
    builder: (column) => column,
  );

  GeneratedColumn<String> get decidedBy =>
      $composableBuilder(column: $table.decidedBy, builder: (column) => column);

  GeneratedColumn<DateTime> get decidedAt =>
      $composableBuilder(column: $table.decidedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$MatchingRecordsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MatchingRecordsTableTable,
          MatchingRecordsTableData,
          $$MatchingRecordsTableTableFilterComposer,
          $$MatchingRecordsTableTableOrderingComposer,
          $$MatchingRecordsTableTableAnnotationComposer,
          $$MatchingRecordsTableTableCreateCompanionBuilder,
          $$MatchingRecordsTableTableUpdateCompanionBuilder,
          (
            MatchingRecordsTableData,
            BaseReferences<
              _$AppDatabase,
              $MatchingRecordsTableTable,
              MatchingRecordsTableData
            >,
          ),
          MatchingRecordsTableData,
          PrefetchHooks Function()
        > {
  $$MatchingRecordsTableTableTableManager(
    _$AppDatabase db,
    $MatchingRecordsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MatchingRecordsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MatchingRecordsTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$MatchingRecordsTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> transactionId = const Value.absent(),
                Value<String> pendingTransactionId = const Value.absent(),
                Value<String> matchStatus = const Value.absent(),
                Value<double> score = const Value.absent(),
                Value<String> payload = const Value.absent(),
                Value<String> decisionSource = const Value.absent(),
                Value<String?> decidedBy = const Value.absent(),
                Value<DateTime?> decidedAt = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MatchingRecordsTableCompanion(
                id: id,
                transactionId: transactionId,
                pendingTransactionId: pendingTransactionId,
                matchStatus: matchStatus,
                score: score,
                payload: payload,
                decisionSource: decisionSource,
                decidedBy: decidedBy,
                decidedAt: decidedAt,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                required String transactionId,
                required String pendingTransactionId,
                required String matchStatus,
                required double score,
                Value<String> payload = const Value.absent(),
                Value<String> decisionSource = const Value.absent(),
                Value<String?> decidedBy = const Value.absent(),
                Value<DateTime?> decidedAt = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => MatchingRecordsTableCompanion.insert(
                id: id,
                transactionId: transactionId,
                pendingTransactionId: pendingTransactionId,
                matchStatus: matchStatus,
                score: score,
                payload: payload,
                decisionSource: decisionSource,
                decidedBy: decidedBy,
                decidedAt: decidedAt,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$MatchingRecordsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MatchingRecordsTableTable,
      MatchingRecordsTableData,
      $$MatchingRecordsTableTableFilterComposer,
      $$MatchingRecordsTableTableOrderingComposer,
      $$MatchingRecordsTableTableAnnotationComposer,
      $$MatchingRecordsTableTableCreateCompanionBuilder,
      $$MatchingRecordsTableTableUpdateCompanionBuilder,
      (
        MatchingRecordsTableData,
        BaseReferences<
          _$AppDatabase,
          $MatchingRecordsTableTable,
          MatchingRecordsTableData
        >,
      ),
      MatchingRecordsTableData,
      PrefetchHooks Function()
    >;
typedef $$SyncQueueTableTableCreateCompanionBuilder =
    SyncQueueTableCompanion Function({
      Value<String> id,
      required String entityType,
      required String entityId,
      required String operation,
      required String payload,
      Value<int> payloadVersion,
      required String status,
      Value<int> retryCount,
      Value<DateTime?> nextRetryAt,
      Value<String?> failureClass,
      Value<String?> lastError,
      Value<DateTime?> attemptStartedAt,
      Value<DateTime?> completedAt,
      required DateTime createdAt,
      Value<int> rowid,
    });
typedef $$SyncQueueTableTableUpdateCompanionBuilder =
    SyncQueueTableCompanion Function({
      Value<String> id,
      Value<String> entityType,
      Value<String> entityId,
      Value<String> operation,
      Value<String> payload,
      Value<int> payloadVersion,
      Value<String> status,
      Value<int> retryCount,
      Value<DateTime?> nextRetryAt,
      Value<String?> failureClass,
      Value<String?> lastError,
      Value<DateTime?> attemptStartedAt,
      Value<DateTime?> completedAt,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

class $$SyncQueueTableTableFilterComposer
    extends Composer<_$AppDatabase, $SyncQueueTableTable> {
  $$SyncQueueTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get entityType => $composableBuilder(
    column: $table.entityType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get entityId => $composableBuilder(
    column: $table.entityId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get operation => $composableBuilder(
    column: $table.operation,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get payload => $composableBuilder(
    column: $table.payload,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get payloadVersion => $composableBuilder(
    column: $table.payloadVersion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get retryCount => $composableBuilder(
    column: $table.retryCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get nextRetryAt => $composableBuilder(
    column: $table.nextRetryAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get failureClass => $composableBuilder(
    column: $table.failureClass,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastError => $composableBuilder(
    column: $table.lastError,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get attemptStartedAt => $composableBuilder(
    column: $table.attemptStartedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SyncQueueTableTableOrderingComposer
    extends Composer<_$AppDatabase, $SyncQueueTableTable> {
  $$SyncQueueTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get entityType => $composableBuilder(
    column: $table.entityType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get entityId => $composableBuilder(
    column: $table.entityId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get operation => $composableBuilder(
    column: $table.operation,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get payload => $composableBuilder(
    column: $table.payload,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get payloadVersion => $composableBuilder(
    column: $table.payloadVersion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get retryCount => $composableBuilder(
    column: $table.retryCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get nextRetryAt => $composableBuilder(
    column: $table.nextRetryAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get failureClass => $composableBuilder(
    column: $table.failureClass,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastError => $composableBuilder(
    column: $table.lastError,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get attemptStartedAt => $composableBuilder(
    column: $table.attemptStartedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SyncQueueTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $SyncQueueTableTable> {
  $$SyncQueueTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get entityType => $composableBuilder(
    column: $table.entityType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get entityId =>
      $composableBuilder(column: $table.entityId, builder: (column) => column);

  GeneratedColumn<String> get operation =>
      $composableBuilder(column: $table.operation, builder: (column) => column);

  GeneratedColumn<String> get payload =>
      $composableBuilder(column: $table.payload, builder: (column) => column);

  GeneratedColumn<int> get payloadVersion => $composableBuilder(
    column: $table.payloadVersion,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<int> get retryCount => $composableBuilder(
    column: $table.retryCount,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get nextRetryAt => $composableBuilder(
    column: $table.nextRetryAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get failureClass => $composableBuilder(
    column: $table.failureClass,
    builder: (column) => column,
  );

  GeneratedColumn<String> get lastError =>
      $composableBuilder(column: $table.lastError, builder: (column) => column);

  GeneratedColumn<DateTime> get attemptStartedAt => $composableBuilder(
    column: $table.attemptStartedAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$SyncQueueTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SyncQueueTableTable,
          SyncQueueTableData,
          $$SyncQueueTableTableFilterComposer,
          $$SyncQueueTableTableOrderingComposer,
          $$SyncQueueTableTableAnnotationComposer,
          $$SyncQueueTableTableCreateCompanionBuilder,
          $$SyncQueueTableTableUpdateCompanionBuilder,
          (
            SyncQueueTableData,
            BaseReferences<
              _$AppDatabase,
              $SyncQueueTableTable,
              SyncQueueTableData
            >,
          ),
          SyncQueueTableData,
          PrefetchHooks Function()
        > {
  $$SyncQueueTableTableTableManager(
    _$AppDatabase db,
    $SyncQueueTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SyncQueueTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SyncQueueTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SyncQueueTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> entityType = const Value.absent(),
                Value<String> entityId = const Value.absent(),
                Value<String> operation = const Value.absent(),
                Value<String> payload = const Value.absent(),
                Value<int> payloadVersion = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<int> retryCount = const Value.absent(),
                Value<DateTime?> nextRetryAt = const Value.absent(),
                Value<String?> failureClass = const Value.absent(),
                Value<String?> lastError = const Value.absent(),
                Value<DateTime?> attemptStartedAt = const Value.absent(),
                Value<DateTime?> completedAt = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SyncQueueTableCompanion(
                id: id,
                entityType: entityType,
                entityId: entityId,
                operation: operation,
                payload: payload,
                payloadVersion: payloadVersion,
                status: status,
                retryCount: retryCount,
                nextRetryAt: nextRetryAt,
                failureClass: failureClass,
                lastError: lastError,
                attemptStartedAt: attemptStartedAt,
                completedAt: completedAt,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                required String entityType,
                required String entityId,
                required String operation,
                required String payload,
                Value<int> payloadVersion = const Value.absent(),
                required String status,
                Value<int> retryCount = const Value.absent(),
                Value<DateTime?> nextRetryAt = const Value.absent(),
                Value<String?> failureClass = const Value.absent(),
                Value<String?> lastError = const Value.absent(),
                Value<DateTime?> attemptStartedAt = const Value.absent(),
                Value<DateTime?> completedAt = const Value.absent(),
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => SyncQueueTableCompanion.insert(
                id: id,
                entityType: entityType,
                entityId: entityId,
                operation: operation,
                payload: payload,
                payloadVersion: payloadVersion,
                status: status,
                retryCount: retryCount,
                nextRetryAt: nextRetryAt,
                failureClass: failureClass,
                lastError: lastError,
                attemptStartedAt: attemptStartedAt,
                completedAt: completedAt,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SyncQueueTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SyncQueueTableTable,
      SyncQueueTableData,
      $$SyncQueueTableTableFilterComposer,
      $$SyncQueueTableTableOrderingComposer,
      $$SyncQueueTableTableAnnotationComposer,
      $$SyncQueueTableTableCreateCompanionBuilder,
      $$SyncQueueTableTableUpdateCompanionBuilder,
      (
        SyncQueueTableData,
        BaseReferences<_$AppDatabase, $SyncQueueTableTable, SyncQueueTableData>,
      ),
      SyncQueueTableData,
      PrefetchHooks Function()
    >;
typedef $$LogsTableTableCreateCompanionBuilder =
    LogsTableCompanion Function({
      Value<String> id,
      required DateTime timestamp,
      required String level,
      required String module,
      required String event,
      required String message,
      Value<String?> errorCode,
      Value<String> stackTrace,
      Value<String> details,
      Value<int> rowid,
    });
typedef $$LogsTableTableUpdateCompanionBuilder =
    LogsTableCompanion Function({
      Value<String> id,
      Value<DateTime> timestamp,
      Value<String> level,
      Value<String> module,
      Value<String> event,
      Value<String> message,
      Value<String?> errorCode,
      Value<String> stackTrace,
      Value<String> details,
      Value<int> rowid,
    });

class $$LogsTableTableFilterComposer
    extends Composer<_$AppDatabase, $LogsTableTable> {
  $$LogsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get level => $composableBuilder(
    column: $table.level,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get module => $composableBuilder(
    column: $table.module,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get event => $composableBuilder(
    column: $table.event,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get message => $composableBuilder(
    column: $table.message,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get errorCode => $composableBuilder(
    column: $table.errorCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get stackTrace => $composableBuilder(
    column: $table.stackTrace,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get details => $composableBuilder(
    column: $table.details,
    builder: (column) => ColumnFilters(column),
  );
}

class $$LogsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $LogsTableTable> {
  $$LogsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get level => $composableBuilder(
    column: $table.level,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get module => $composableBuilder(
    column: $table.module,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get event => $composableBuilder(
    column: $table.event,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get message => $composableBuilder(
    column: $table.message,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get errorCode => $composableBuilder(
    column: $table.errorCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get stackTrace => $composableBuilder(
    column: $table.stackTrace,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get details => $composableBuilder(
    column: $table.details,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LogsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $LogsTableTable> {
  $$LogsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get timestamp =>
      $composableBuilder(column: $table.timestamp, builder: (column) => column);

  GeneratedColumn<String> get level =>
      $composableBuilder(column: $table.level, builder: (column) => column);

  GeneratedColumn<String> get module =>
      $composableBuilder(column: $table.module, builder: (column) => column);

  GeneratedColumn<String> get event =>
      $composableBuilder(column: $table.event, builder: (column) => column);

  GeneratedColumn<String> get message =>
      $composableBuilder(column: $table.message, builder: (column) => column);

  GeneratedColumn<String> get errorCode =>
      $composableBuilder(column: $table.errorCode, builder: (column) => column);

  GeneratedColumn<String> get stackTrace => $composableBuilder(
    column: $table.stackTrace,
    builder: (column) => column,
  );

  GeneratedColumn<String> get details =>
      $composableBuilder(column: $table.details, builder: (column) => column);
}

class $$LogsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LogsTableTable,
          LogsTableData,
          $$LogsTableTableFilterComposer,
          $$LogsTableTableOrderingComposer,
          $$LogsTableTableAnnotationComposer,
          $$LogsTableTableCreateCompanionBuilder,
          $$LogsTableTableUpdateCompanionBuilder,
          (
            LogsTableData,
            BaseReferences<_$AppDatabase, $LogsTableTable, LogsTableData>,
          ),
          LogsTableData,
          PrefetchHooks Function()
        > {
  $$LogsTableTableTableManager(_$AppDatabase db, $LogsTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LogsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LogsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LogsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> timestamp = const Value.absent(),
                Value<String> level = const Value.absent(),
                Value<String> module = const Value.absent(),
                Value<String> event = const Value.absent(),
                Value<String> message = const Value.absent(),
                Value<String?> errorCode = const Value.absent(),
                Value<String> stackTrace = const Value.absent(),
                Value<String> details = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LogsTableCompanion(
                id: id,
                timestamp: timestamp,
                level: level,
                module: module,
                event: event,
                message: message,
                errorCode: errorCode,
                stackTrace: stackTrace,
                details: details,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                required DateTime timestamp,
                required String level,
                required String module,
                required String event,
                required String message,
                Value<String?> errorCode = const Value.absent(),
                Value<String> stackTrace = const Value.absent(),
                Value<String> details = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LogsTableCompanion.insert(
                id: id,
                timestamp: timestamp,
                level: level,
                module: module,
                event: event,
                message: message,
                errorCode: errorCode,
                stackTrace: stackTrace,
                details: details,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$LogsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LogsTableTable,
      LogsTableData,
      $$LogsTableTableFilterComposer,
      $$LogsTableTableOrderingComposer,
      $$LogsTableTableAnnotationComposer,
      $$LogsTableTableCreateCompanionBuilder,
      $$LogsTableTableUpdateCompanionBuilder,
      (
        LogsTableData,
        BaseReferences<_$AppDatabase, $LogsTableTable, LogsTableData>,
      ),
      LogsTableData,
      PrefetchHooks Function()
    >;
typedef $$AuditEventsTableTableCreateCompanionBuilder =
    AuditEventsTableCompanion Function({
      Value<String> id,
      required DateTime timestamp,
      required String type,
      required String deviceId,
      required String appVersion,
      required String actorRole,
      Value<String?> actorUserId,
      Value<String?> smsId,
      Value<String?> transactionId,
      Value<String?> smsHash,
      Value<String> metadata,
      Value<int> rowid,
    });
typedef $$AuditEventsTableTableUpdateCompanionBuilder =
    AuditEventsTableCompanion Function({
      Value<String> id,
      Value<DateTime> timestamp,
      Value<String> type,
      Value<String> deviceId,
      Value<String> appVersion,
      Value<String> actorRole,
      Value<String?> actorUserId,
      Value<String?> smsId,
      Value<String?> transactionId,
      Value<String?> smsHash,
      Value<String> metadata,
      Value<int> rowid,
    });

class $$AuditEventsTableTableFilterComposer
    extends Composer<_$AppDatabase, $AuditEventsTableTable> {
  $$AuditEventsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get deviceId => $composableBuilder(
    column: $table.deviceId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get appVersion => $composableBuilder(
    column: $table.appVersion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get actorRole => $composableBuilder(
    column: $table.actorRole,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get actorUserId => $composableBuilder(
    column: $table.actorUserId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get smsId => $composableBuilder(
    column: $table.smsId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get transactionId => $composableBuilder(
    column: $table.transactionId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get smsHash => $composableBuilder(
    column: $table.smsHash,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get metadata => $composableBuilder(
    column: $table.metadata,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AuditEventsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $AuditEventsTableTable> {
  $$AuditEventsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get deviceId => $composableBuilder(
    column: $table.deviceId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get appVersion => $composableBuilder(
    column: $table.appVersion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get actorRole => $composableBuilder(
    column: $table.actorRole,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get actorUserId => $composableBuilder(
    column: $table.actorUserId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get smsId => $composableBuilder(
    column: $table.smsId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get transactionId => $composableBuilder(
    column: $table.transactionId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get smsHash => $composableBuilder(
    column: $table.smsHash,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get metadata => $composableBuilder(
    column: $table.metadata,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AuditEventsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $AuditEventsTableTable> {
  $$AuditEventsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get timestamp =>
      $composableBuilder(column: $table.timestamp, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get deviceId =>
      $composableBuilder(column: $table.deviceId, builder: (column) => column);

  GeneratedColumn<String> get appVersion => $composableBuilder(
    column: $table.appVersion,
    builder: (column) => column,
  );

  GeneratedColumn<String> get actorRole =>
      $composableBuilder(column: $table.actorRole, builder: (column) => column);

  GeneratedColumn<String> get actorUserId => $composableBuilder(
    column: $table.actorUserId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get smsId =>
      $composableBuilder(column: $table.smsId, builder: (column) => column);

  GeneratedColumn<String> get transactionId => $composableBuilder(
    column: $table.transactionId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get smsHash =>
      $composableBuilder(column: $table.smsHash, builder: (column) => column);

  GeneratedColumn<String> get metadata =>
      $composableBuilder(column: $table.metadata, builder: (column) => column);
}

class $$AuditEventsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AuditEventsTableTable,
          AuditEventsTableData,
          $$AuditEventsTableTableFilterComposer,
          $$AuditEventsTableTableOrderingComposer,
          $$AuditEventsTableTableAnnotationComposer,
          $$AuditEventsTableTableCreateCompanionBuilder,
          $$AuditEventsTableTableUpdateCompanionBuilder,
          (
            AuditEventsTableData,
            BaseReferences<
              _$AppDatabase,
              $AuditEventsTableTable,
              AuditEventsTableData
            >,
          ),
          AuditEventsTableData,
          PrefetchHooks Function()
        > {
  $$AuditEventsTableTableTableManager(
    _$AppDatabase db,
    $AuditEventsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AuditEventsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AuditEventsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AuditEventsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> timestamp = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<String> deviceId = const Value.absent(),
                Value<String> appVersion = const Value.absent(),
                Value<String> actorRole = const Value.absent(),
                Value<String?> actorUserId = const Value.absent(),
                Value<String?> smsId = const Value.absent(),
                Value<String?> transactionId = const Value.absent(),
                Value<String?> smsHash = const Value.absent(),
                Value<String> metadata = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AuditEventsTableCompanion(
                id: id,
                timestamp: timestamp,
                type: type,
                deviceId: deviceId,
                appVersion: appVersion,
                actorRole: actorRole,
                actorUserId: actorUserId,
                smsId: smsId,
                transactionId: transactionId,
                smsHash: smsHash,
                metadata: metadata,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                required DateTime timestamp,
                required String type,
                required String deviceId,
                required String appVersion,
                required String actorRole,
                Value<String?> actorUserId = const Value.absent(),
                Value<String?> smsId = const Value.absent(),
                Value<String?> transactionId = const Value.absent(),
                Value<String?> smsHash = const Value.absent(),
                Value<String> metadata = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AuditEventsTableCompanion.insert(
                id: id,
                timestamp: timestamp,
                type: type,
                deviceId: deviceId,
                appVersion: appVersion,
                actorRole: actorRole,
                actorUserId: actorUserId,
                smsId: smsId,
                transactionId: transactionId,
                smsHash: smsHash,
                metadata: metadata,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AuditEventsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AuditEventsTableTable,
      AuditEventsTableData,
      $$AuditEventsTableTableFilterComposer,
      $$AuditEventsTableTableOrderingComposer,
      $$AuditEventsTableTableAnnotationComposer,
      $$AuditEventsTableTableCreateCompanionBuilder,
      $$AuditEventsTableTableUpdateCompanionBuilder,
      (
        AuditEventsTableData,
        BaseReferences<
          _$AppDatabase,
          $AuditEventsTableTable,
          AuditEventsTableData
        >,
      ),
      AuditEventsTableData,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$BanksTableTableTableManager get banksTable =>
      $$BanksTableTableTableManager(_db, _db.banksTable);
  $$BankSendersTableTableTableManager get bankSendersTable =>
      $$BankSendersTableTableTableManager(_db, _db.bankSendersTable);
  $$ParserRulesTableTableTableManager get parserRulesTable =>
      $$ParserRulesTableTableTableManager(_db, _db.parserRulesTable);
  $$SmsMessagesTableTableTableManager get smsMessagesTable =>
      $$SmsMessagesTableTableTableManager(_db, _db.smsMessagesTable);
  $$TransactionsTableTableTableManager get transactionsTable =>
      $$TransactionsTableTableTableManager(_db, _db.transactionsTable);
  $$PendingTransactionsTableTableTableManager get pendingTransactionsTable =>
      $$PendingTransactionsTableTableTableManager(
        _db,
        _db.pendingTransactionsTable,
      );
  $$MatchingRecordsTableTableTableManager get matchingRecordsTable =>
      $$MatchingRecordsTableTableTableManager(_db, _db.matchingRecordsTable);
  $$SyncQueueTableTableTableManager get syncQueueTable =>
      $$SyncQueueTableTableTableManager(_db, _db.syncQueueTable);
  $$LogsTableTableTableManager get logsTable =>
      $$LogsTableTableTableManager(_db, _db.logsTable);
  $$AuditEventsTableTableTableManager get auditEventsTable =>
      $$AuditEventsTableTableTableManager(_db, _db.auditEventsTable);
}
