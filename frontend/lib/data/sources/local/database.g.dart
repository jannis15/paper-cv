// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $TbDocumentTable extends TbDocument
    with TableInfo<$TbDocumentTable, TbDocumentData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TbDocumentTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _uuidMeta = const VerificationMeta('uuid');
  @override
  late final GeneratedColumn<String> uuid = GeneratedColumn<String>(
      'uuid', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      clientDefault: () => const Uuid().v4());
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _modifiedAtMeta =
      const VerificationMeta('modifiedAt');
  @override
  late final GeneratedColumn<DateTime> modifiedAt = GeneratedColumn<DateTime>(
      'modified_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [uuid, title, createdAt, modifiedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tb_document';
  @override
  VerificationContext validateIntegrity(Insertable<TbDocumentData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('uuid')) {
      context.handle(
          _uuidMeta, uuid.isAcceptableOrUnknown(data['uuid']!, _uuidMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('modified_at')) {
      context.handle(
          _modifiedAtMeta,
          modifiedAt.isAcceptableOrUnknown(
              data['modified_at']!, _modifiedAtMeta));
    } else if (isInserting) {
      context.missing(_modifiedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {uuid};
  @override
  TbDocumentData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TbDocumentData(
      uuid: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}uuid'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      modifiedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}modified_at'])!,
    );
  }

  @override
  $TbDocumentTable createAlias(String alias) {
    return $TbDocumentTable(attachedDatabase, alias);
  }
}

class TbDocumentData extends DataClass implements Insertable<TbDocumentData> {
  final String uuid;
  final String title;
  final DateTime createdAt;
  final DateTime modifiedAt;
  const TbDocumentData(
      {required this.uuid,
      required this.title,
      required this.createdAt,
      required this.modifiedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['uuid'] = Variable<String>(uuid);
    map['title'] = Variable<String>(title);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['modified_at'] = Variable<DateTime>(modifiedAt);
    return map;
  }

  TbDocumentCompanion toCompanion(bool nullToAbsent) {
    return TbDocumentCompanion(
      uuid: Value(uuid),
      title: Value(title),
      createdAt: Value(createdAt),
      modifiedAt: Value(modifiedAt),
    );
  }

  factory TbDocumentData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TbDocumentData(
      uuid: serializer.fromJson<String>(json['uuid']),
      title: serializer.fromJson<String>(json['title']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      modifiedAt: serializer.fromJson<DateTime>(json['modifiedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'uuid': serializer.toJson<String>(uuid),
      'title': serializer.toJson<String>(title),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'modifiedAt': serializer.toJson<DateTime>(modifiedAt),
    };
  }

  TbDocumentData copyWith(
          {String? uuid,
          String? title,
          DateTime? createdAt,
          DateTime? modifiedAt}) =>
      TbDocumentData(
        uuid: uuid ?? this.uuid,
        title: title ?? this.title,
        createdAt: createdAt ?? this.createdAt,
        modifiedAt: modifiedAt ?? this.modifiedAt,
      );
  TbDocumentData copyWithCompanion(TbDocumentCompanion data) {
    return TbDocumentData(
      uuid: data.uuid.present ? data.uuid.value : this.uuid,
      title: data.title.present ? data.title.value : this.title,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      modifiedAt:
          data.modifiedAt.present ? data.modifiedAt.value : this.modifiedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TbDocumentData(')
          ..write('uuid: $uuid, ')
          ..write('title: $title, ')
          ..write('createdAt: $createdAt, ')
          ..write('modifiedAt: $modifiedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(uuid, title, createdAt, modifiedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TbDocumentData &&
          other.uuid == this.uuid &&
          other.title == this.title &&
          other.createdAt == this.createdAt &&
          other.modifiedAt == this.modifiedAt);
}

class TbDocumentCompanion extends UpdateCompanion<TbDocumentData> {
  final Value<String> uuid;
  final Value<String> title;
  final Value<DateTime> createdAt;
  final Value<DateTime> modifiedAt;
  final Value<int> rowid;
  const TbDocumentCompanion({
    this.uuid = const Value.absent(),
    this.title = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.modifiedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TbDocumentCompanion.insert({
    this.uuid = const Value.absent(),
    required String title,
    required DateTime createdAt,
    required DateTime modifiedAt,
    this.rowid = const Value.absent(),
  })  : title = Value(title),
        createdAt = Value(createdAt),
        modifiedAt = Value(modifiedAt);
  static Insertable<TbDocumentData> custom({
    Expression<String>? uuid,
    Expression<String>? title,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? modifiedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (uuid != null) 'uuid': uuid,
      if (title != null) 'title': title,
      if (createdAt != null) 'created_at': createdAt,
      if (modifiedAt != null) 'modified_at': modifiedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TbDocumentCompanion copyWith(
      {Value<String>? uuid,
      Value<String>? title,
      Value<DateTime>? createdAt,
      Value<DateTime>? modifiedAt,
      Value<int>? rowid}) {
    return TbDocumentCompanion(
      uuid: uuid ?? this.uuid,
      title: title ?? this.title,
      createdAt: createdAt ?? this.createdAt,
      modifiedAt: modifiedAt ?? this.modifiedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (uuid.present) {
      map['uuid'] = Variable<String>(uuid.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (modifiedAt.present) {
      map['modified_at'] = Variable<DateTime>(modifiedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TbDocumentCompanion(')
          ..write('uuid: $uuid, ')
          ..write('title: $title, ')
          ..write('createdAt: $createdAt, ')
          ..write('modifiedAt: $modifiedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$FloorDatabase extends GeneratedDatabase {
  _$FloorDatabase(QueryExecutor e) : super(e);
  $FloorDatabaseManager get managers => $FloorDatabaseManager(this);
  late final $TbDocumentTable tbDocument = $TbDocumentTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [tbDocument];
}

typedef $$TbDocumentTableCreateCompanionBuilder = TbDocumentCompanion Function({
  Value<String> uuid,
  required String title,
  required DateTime createdAt,
  required DateTime modifiedAt,
  Value<int> rowid,
});
typedef $$TbDocumentTableUpdateCompanionBuilder = TbDocumentCompanion Function({
  Value<String> uuid,
  Value<String> title,
  Value<DateTime> createdAt,
  Value<DateTime> modifiedAt,
  Value<int> rowid,
});

class $$TbDocumentTableFilterComposer
    extends FilterComposer<_$FloorDatabase, $TbDocumentTable> {
  $$TbDocumentTableFilterComposer(super.$state);
  ColumnFilters<String> get uuid => $state.composableBuilder(
      column: $state.table.uuid,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get title => $state.composableBuilder(
      column: $state.table.title,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get modifiedAt => $state.composableBuilder(
      column: $state.table.modifiedAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$TbDocumentTableOrderingComposer
    extends OrderingComposer<_$FloorDatabase, $TbDocumentTable> {
  $$TbDocumentTableOrderingComposer(super.$state);
  ColumnOrderings<String> get uuid => $state.composableBuilder(
      column: $state.table.uuid,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get title => $state.composableBuilder(
      column: $state.table.title,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get modifiedAt => $state.composableBuilder(
      column: $state.table.modifiedAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

class $$TbDocumentTableTableManager extends RootTableManager<
    _$FloorDatabase,
    $TbDocumentTable,
    TbDocumentData,
    $$TbDocumentTableFilterComposer,
    $$TbDocumentTableOrderingComposer,
    $$TbDocumentTableCreateCompanionBuilder,
    $$TbDocumentTableUpdateCompanionBuilder,
    (
      TbDocumentData,
      BaseReferences<_$FloorDatabase, $TbDocumentTable, TbDocumentData>
    ),
    TbDocumentData,
    PrefetchHooks Function()> {
  $$TbDocumentTableTableManager(_$FloorDatabase db, $TbDocumentTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$TbDocumentTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$TbDocumentTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<String> uuid = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> modifiedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              TbDocumentCompanion(
            uuid: uuid,
            title: title,
            createdAt: createdAt,
            modifiedAt: modifiedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            Value<String> uuid = const Value.absent(),
            required String title,
            required DateTime createdAt,
            required DateTime modifiedAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              TbDocumentCompanion.insert(
            uuid: uuid,
            title: title,
            createdAt: createdAt,
            modifiedAt: modifiedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$TbDocumentTableProcessedTableManager = ProcessedTableManager<
    _$FloorDatabase,
    $TbDocumentTable,
    TbDocumentData,
    $$TbDocumentTableFilterComposer,
    $$TbDocumentTableOrderingComposer,
    $$TbDocumentTableCreateCompanionBuilder,
    $$TbDocumentTableUpdateCompanionBuilder,
    (
      TbDocumentData,
      BaseReferences<_$FloorDatabase, $TbDocumentTable, TbDocumentData>
    ),
    TbDocumentData,
    PrefetchHooks Function()>;

class $FloorDatabaseManager {
  final _$FloorDatabase _db;
  $FloorDatabaseManager(this._db);
  $$TbDocumentTableTableManager get tbDocument =>
      $$TbDocumentTableTableManager(_db, _db.tbDocument);
}
