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
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, false,
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
  List<GeneratedColumn> get $columns =>
      [uuid, title, notes, createdAt, modifiedAt];
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
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    } else if (isInserting) {
      context.missing(_notesMeta);
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
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes'])!,
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
  final String notes;
  final DateTime createdAt;
  final DateTime modifiedAt;
  const TbDocumentData(
      {required this.uuid,
      required this.title,
      required this.notes,
      required this.createdAt,
      required this.modifiedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['uuid'] = Variable<String>(uuid);
    map['title'] = Variable<String>(title);
    map['notes'] = Variable<String>(notes);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['modified_at'] = Variable<DateTime>(modifiedAt);
    return map;
  }

  TbDocumentCompanion toCompanion(bool nullToAbsent) {
    return TbDocumentCompanion(
      uuid: Value(uuid),
      title: Value(title),
      notes: Value(notes),
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
      notes: serializer.fromJson<String>(json['notes']),
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
      'notes': serializer.toJson<String>(notes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'modifiedAt': serializer.toJson<DateTime>(modifiedAt),
    };
  }

  TbDocumentData copyWith(
          {String? uuid,
          String? title,
          String? notes,
          DateTime? createdAt,
          DateTime? modifiedAt}) =>
      TbDocumentData(
        uuid: uuid ?? this.uuid,
        title: title ?? this.title,
        notes: notes ?? this.notes,
        createdAt: createdAt ?? this.createdAt,
        modifiedAt: modifiedAt ?? this.modifiedAt,
      );
  TbDocumentData copyWithCompanion(TbDocumentCompanion data) {
    return TbDocumentData(
      uuid: data.uuid.present ? data.uuid.value : this.uuid,
      title: data.title.present ? data.title.value : this.title,
      notes: data.notes.present ? data.notes.value : this.notes,
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
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('modifiedAt: $modifiedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(uuid, title, notes, createdAt, modifiedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TbDocumentData &&
          other.uuid == this.uuid &&
          other.title == this.title &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt &&
          other.modifiedAt == this.modifiedAt);
}

class TbDocumentCompanion extends UpdateCompanion<TbDocumentData> {
  final Value<String> uuid;
  final Value<String> title;
  final Value<String> notes;
  final Value<DateTime> createdAt;
  final Value<DateTime> modifiedAt;
  final Value<int> rowid;
  const TbDocumentCompanion({
    this.uuid = const Value.absent(),
    this.title = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.modifiedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TbDocumentCompanion.insert({
    this.uuid = const Value.absent(),
    required String title,
    required String notes,
    required DateTime createdAt,
    required DateTime modifiedAt,
    this.rowid = const Value.absent(),
  })  : title = Value(title),
        notes = Value(notes),
        createdAt = Value(createdAt),
        modifiedAt = Value(modifiedAt);
  static Insertable<TbDocumentData> custom({
    Expression<String>? uuid,
    Expression<String>? title,
    Expression<String>? notes,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? modifiedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (uuid != null) 'uuid': uuid,
      if (title != null) 'title': title,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
      if (modifiedAt != null) 'modified_at': modifiedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TbDocumentCompanion copyWith(
      {Value<String>? uuid,
      Value<String>? title,
      Value<String>? notes,
      Value<DateTime>? createdAt,
      Value<DateTime>? modifiedAt,
      Value<int>? rowid}) {
    return TbDocumentCompanion(
      uuid: uuid ?? this.uuid,
      title: title ?? this.title,
      notes: notes ?? this.notes,
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
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
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
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('modifiedAt: $modifiedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TbFileTable extends TbFile with TableInfo<$TbFileTable, TbFileData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TbFileTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _uuidMeta = const VerificationMeta('uuid');
  @override
  late final GeneratedColumn<String> uuid = GeneratedColumn<String>(
      'uuid', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      clientDefault: () => const Uuid().v4());
  static const VerificationMeta _refUuidMeta =
      const VerificationMeta('refUuid');
  @override
  late final GeneratedColumn<String> refUuid = GeneratedColumn<String>(
      'ref_uuid', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _filenameMeta =
      const VerificationMeta('filename');
  @override
  late final GeneratedColumn<String> filename = GeneratedColumn<String>(
      'filename', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _dataMeta = const VerificationMeta('data');
  @override
  late final GeneratedColumn<Uint8List> data = GeneratedColumn<Uint8List>(
      'data', aliasedName, false,
      type: DriftSqlType.blob, requiredDuringInsert: true);
  static const VerificationMeta _indexMeta = const VerificationMeta('index');
  @override
  late final GeneratedColumn<int> index = GeneratedColumn<int>(
      'index', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _fileTypeMeta =
      const VerificationMeta('fileType');
  @override
  late final GeneratedColumnWithTypeConverter<IJsonEnum<FileType>, int>
      fileType = GeneratedColumn<int>('file_type', aliasedName, false,
              type: DriftSqlType.int, requiredDuringInsert: true)
          .withConverter<IJsonEnum<FileType>>($TbFileTable.$converterfileType);
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
  List<GeneratedColumn> get $columns =>
      [uuid, refUuid, filename, data, index, fileType, createdAt, modifiedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tb_file';
  @override
  VerificationContext validateIntegrity(Insertable<TbFileData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('uuid')) {
      context.handle(
          _uuidMeta, uuid.isAcceptableOrUnknown(data['uuid']!, _uuidMeta));
    }
    if (data.containsKey('ref_uuid')) {
      context.handle(_refUuidMeta,
          refUuid.isAcceptableOrUnknown(data['ref_uuid']!, _refUuidMeta));
    }
    if (data.containsKey('filename')) {
      context.handle(_filenameMeta,
          filename.isAcceptableOrUnknown(data['filename']!, _filenameMeta));
    } else if (isInserting) {
      context.missing(_filenameMeta);
    }
    if (data.containsKey('data')) {
      context.handle(
          _dataMeta, this.data.isAcceptableOrUnknown(data['data']!, _dataMeta));
    } else if (isInserting) {
      context.missing(_dataMeta);
    }
    if (data.containsKey('index')) {
      context.handle(
          _indexMeta, index.isAcceptableOrUnknown(data['index']!, _indexMeta));
    }
    context.handle(_fileTypeMeta, const VerificationResult.success());
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
  TbFileData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TbFileData(
      uuid: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}uuid'])!,
      refUuid: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}ref_uuid']),
      filename: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}filename'])!,
      data: attachedDatabase.typeMapping
          .read(DriftSqlType.blob, data['${effectivePrefix}data'])!,
      index: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}index']),
      fileType: $TbFileTable.$converterfileType.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}file_type'])!),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      modifiedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}modified_at'])!,
    );
  }

  @override
  $TbFileTable createAlias(String alias) {
    return $TbFileTable(attachedDatabase, alias);
  }

  static TypeConverter<IJsonEnum<FileType>, int> $converterfileType =
      const EnumConverter(FileType.values);
}

class TbFileData extends DataClass implements Insertable<TbFileData> {
  final String uuid;
  final String? refUuid;
  final String filename;
  final Uint8List data;
  final int? index;
  final IJsonEnum<FileType> fileType;
  final DateTime createdAt;
  final DateTime modifiedAt;
  const TbFileData(
      {required this.uuid,
      this.refUuid,
      required this.filename,
      required this.data,
      this.index,
      required this.fileType,
      required this.createdAt,
      required this.modifiedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['uuid'] = Variable<String>(uuid);
    if (!nullToAbsent || refUuid != null) {
      map['ref_uuid'] = Variable<String>(refUuid);
    }
    map['filename'] = Variable<String>(filename);
    map['data'] = Variable<Uint8List>(data);
    if (!nullToAbsent || index != null) {
      map['index'] = Variable<int>(index);
    }
    {
      map['file_type'] =
          Variable<int>($TbFileTable.$converterfileType.toSql(fileType));
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['modified_at'] = Variable<DateTime>(modifiedAt);
    return map;
  }

  TbFileCompanion toCompanion(bool nullToAbsent) {
    return TbFileCompanion(
      uuid: Value(uuid),
      refUuid: refUuid == null && nullToAbsent
          ? const Value.absent()
          : Value(refUuid),
      filename: Value(filename),
      data: Value(data),
      index:
          index == null && nullToAbsent ? const Value.absent() : Value(index),
      fileType: Value(fileType),
      createdAt: Value(createdAt),
      modifiedAt: Value(modifiedAt),
    );
  }

  factory TbFileData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TbFileData(
      uuid: serializer.fromJson<String>(json['uuid']),
      refUuid: serializer.fromJson<String?>(json['refUuid']),
      filename: serializer.fromJson<String>(json['filename']),
      data: serializer.fromJson<Uint8List>(json['data']),
      index: serializer.fromJson<int?>(json['index']),
      fileType: serializer.fromJson<IJsonEnum<FileType>>(json['fileType']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      modifiedAt: serializer.fromJson<DateTime>(json['modifiedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'uuid': serializer.toJson<String>(uuid),
      'refUuid': serializer.toJson<String?>(refUuid),
      'filename': serializer.toJson<String>(filename),
      'data': serializer.toJson<Uint8List>(data),
      'index': serializer.toJson<int?>(index),
      'fileType': serializer.toJson<IJsonEnum<FileType>>(fileType),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'modifiedAt': serializer.toJson<DateTime>(modifiedAt),
    };
  }

  TbFileData copyWith(
          {String? uuid,
          Value<String?> refUuid = const Value.absent(),
          String? filename,
          Uint8List? data,
          Value<int?> index = const Value.absent(),
          IJsonEnum<FileType>? fileType,
          DateTime? createdAt,
          DateTime? modifiedAt}) =>
      TbFileData(
        uuid: uuid ?? this.uuid,
        refUuid: refUuid.present ? refUuid.value : this.refUuid,
        filename: filename ?? this.filename,
        data: data ?? this.data,
        index: index.present ? index.value : this.index,
        fileType: fileType ?? this.fileType,
        createdAt: createdAt ?? this.createdAt,
        modifiedAt: modifiedAt ?? this.modifiedAt,
      );
  TbFileData copyWithCompanion(TbFileCompanion data) {
    return TbFileData(
      uuid: data.uuid.present ? data.uuid.value : this.uuid,
      refUuid: data.refUuid.present ? data.refUuid.value : this.refUuid,
      filename: data.filename.present ? data.filename.value : this.filename,
      data: data.data.present ? data.data.value : this.data,
      index: data.index.present ? data.index.value : this.index,
      fileType: data.fileType.present ? data.fileType.value : this.fileType,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      modifiedAt:
          data.modifiedAt.present ? data.modifiedAt.value : this.modifiedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TbFileData(')
          ..write('uuid: $uuid, ')
          ..write('refUuid: $refUuid, ')
          ..write('filename: $filename, ')
          ..write('data: $data, ')
          ..write('index: $index, ')
          ..write('fileType: $fileType, ')
          ..write('createdAt: $createdAt, ')
          ..write('modifiedAt: $modifiedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(uuid, refUuid, filename,
      $driftBlobEquality.hash(data), index, fileType, createdAt, modifiedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TbFileData &&
          other.uuid == this.uuid &&
          other.refUuid == this.refUuid &&
          other.filename == this.filename &&
          $driftBlobEquality.equals(other.data, this.data) &&
          other.index == this.index &&
          other.fileType == this.fileType &&
          other.createdAt == this.createdAt &&
          other.modifiedAt == this.modifiedAt);
}

class TbFileCompanion extends UpdateCompanion<TbFileData> {
  final Value<String> uuid;
  final Value<String?> refUuid;
  final Value<String> filename;
  final Value<Uint8List> data;
  final Value<int?> index;
  final Value<IJsonEnum<FileType>> fileType;
  final Value<DateTime> createdAt;
  final Value<DateTime> modifiedAt;
  final Value<int> rowid;
  const TbFileCompanion({
    this.uuid = const Value.absent(),
    this.refUuid = const Value.absent(),
    this.filename = const Value.absent(),
    this.data = const Value.absent(),
    this.index = const Value.absent(),
    this.fileType = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.modifiedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TbFileCompanion.insert({
    this.uuid = const Value.absent(),
    this.refUuid = const Value.absent(),
    required String filename,
    required Uint8List data,
    this.index = const Value.absent(),
    required IJsonEnum<FileType> fileType,
    required DateTime createdAt,
    required DateTime modifiedAt,
    this.rowid = const Value.absent(),
  })  : filename = Value(filename),
        data = Value(data),
        fileType = Value(fileType),
        createdAt = Value(createdAt),
        modifiedAt = Value(modifiedAt);
  static Insertable<TbFileData> custom({
    Expression<String>? uuid,
    Expression<String>? refUuid,
    Expression<String>? filename,
    Expression<Uint8List>? data,
    Expression<int>? index,
    Expression<int>? fileType,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? modifiedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (uuid != null) 'uuid': uuid,
      if (refUuid != null) 'ref_uuid': refUuid,
      if (filename != null) 'filename': filename,
      if (data != null) 'data': data,
      if (index != null) 'index': index,
      if (fileType != null) 'file_type': fileType,
      if (createdAt != null) 'created_at': createdAt,
      if (modifiedAt != null) 'modified_at': modifiedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TbFileCompanion copyWith(
      {Value<String>? uuid,
      Value<String?>? refUuid,
      Value<String>? filename,
      Value<Uint8List>? data,
      Value<int?>? index,
      Value<IJsonEnum<FileType>>? fileType,
      Value<DateTime>? createdAt,
      Value<DateTime>? modifiedAt,
      Value<int>? rowid}) {
    return TbFileCompanion(
      uuid: uuid ?? this.uuid,
      refUuid: refUuid ?? this.refUuid,
      filename: filename ?? this.filename,
      data: data ?? this.data,
      index: index ?? this.index,
      fileType: fileType ?? this.fileType,
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
    if (refUuid.present) {
      map['ref_uuid'] = Variable<String>(refUuid.value);
    }
    if (filename.present) {
      map['filename'] = Variable<String>(filename.value);
    }
    if (data.present) {
      map['data'] = Variable<Uint8List>(data.value);
    }
    if (index.present) {
      map['index'] = Variable<int>(index.value);
    }
    if (fileType.present) {
      map['file_type'] =
          Variable<int>($TbFileTable.$converterfileType.toSql(fileType.value));
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
    return (StringBuffer('TbFileCompanion(')
          ..write('uuid: $uuid, ')
          ..write('refUuid: $refUuid, ')
          ..write('filename: $filename, ')
          ..write('data: $data, ')
          ..write('index: $index, ')
          ..write('fileType: $fileType, ')
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
  late final $TbFileTable tbFile = $TbFileTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [tbDocument, tbFile];
}

typedef $$TbDocumentTableCreateCompanionBuilder = TbDocumentCompanion Function({
  Value<String> uuid,
  required String title,
  required String notes,
  required DateTime createdAt,
  required DateTime modifiedAt,
  Value<int> rowid,
});
typedef $$TbDocumentTableUpdateCompanionBuilder = TbDocumentCompanion Function({
  Value<String> uuid,
  Value<String> title,
  Value<String> notes,
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

  ColumnFilters<String> get notes => $state.composableBuilder(
      column: $state.table.notes,
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

  ColumnOrderings<String> get notes => $state.composableBuilder(
      column: $state.table.notes,
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
            Value<String> notes = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> modifiedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              TbDocumentCompanion(
            uuid: uuid,
            title: title,
            notes: notes,
            createdAt: createdAt,
            modifiedAt: modifiedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            Value<String> uuid = const Value.absent(),
            required String title,
            required String notes,
            required DateTime createdAt,
            required DateTime modifiedAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              TbDocumentCompanion.insert(
            uuid: uuid,
            title: title,
            notes: notes,
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
typedef $$TbFileTableCreateCompanionBuilder = TbFileCompanion Function({
  Value<String> uuid,
  Value<String?> refUuid,
  required String filename,
  required Uint8List data,
  Value<int?> index,
  required IJsonEnum<FileType> fileType,
  required DateTime createdAt,
  required DateTime modifiedAt,
  Value<int> rowid,
});
typedef $$TbFileTableUpdateCompanionBuilder = TbFileCompanion Function({
  Value<String> uuid,
  Value<String?> refUuid,
  Value<String> filename,
  Value<Uint8List> data,
  Value<int?> index,
  Value<IJsonEnum<FileType>> fileType,
  Value<DateTime> createdAt,
  Value<DateTime> modifiedAt,
  Value<int> rowid,
});

class $$TbFileTableFilterComposer
    extends FilterComposer<_$FloorDatabase, $TbFileTable> {
  $$TbFileTableFilterComposer(super.$state);
  ColumnFilters<String> get uuid => $state.composableBuilder(
      column: $state.table.uuid,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get refUuid => $state.composableBuilder(
      column: $state.table.refUuid,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get filename => $state.composableBuilder(
      column: $state.table.filename,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<Uint8List> get data => $state.composableBuilder(
      column: $state.table.data,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get index => $state.composableBuilder(
      column: $state.table.index,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnWithTypeConverterFilters<IJsonEnum<FileType>, IJsonEnum<FileType>, int>
      get fileType => $state.composableBuilder(
          column: $state.table.fileType,
          builder: (column, joinBuilders) => ColumnWithTypeConverterFilters(
              column,
              joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get modifiedAt => $state.composableBuilder(
      column: $state.table.modifiedAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$TbFileTableOrderingComposer
    extends OrderingComposer<_$FloorDatabase, $TbFileTable> {
  $$TbFileTableOrderingComposer(super.$state);
  ColumnOrderings<String> get uuid => $state.composableBuilder(
      column: $state.table.uuid,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get refUuid => $state.composableBuilder(
      column: $state.table.refUuid,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get filename => $state.composableBuilder(
      column: $state.table.filename,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<Uint8List> get data => $state.composableBuilder(
      column: $state.table.data,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get index => $state.composableBuilder(
      column: $state.table.index,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get fileType => $state.composableBuilder(
      column: $state.table.fileType,
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

class $$TbFileTableTableManager extends RootTableManager<
    _$FloorDatabase,
    $TbFileTable,
    TbFileData,
    $$TbFileTableFilterComposer,
    $$TbFileTableOrderingComposer,
    $$TbFileTableCreateCompanionBuilder,
    $$TbFileTableUpdateCompanionBuilder,
    (TbFileData, BaseReferences<_$FloorDatabase, $TbFileTable, TbFileData>),
    TbFileData,
    PrefetchHooks Function()> {
  $$TbFileTableTableManager(_$FloorDatabase db, $TbFileTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$TbFileTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$TbFileTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<String> uuid = const Value.absent(),
            Value<String?> refUuid = const Value.absent(),
            Value<String> filename = const Value.absent(),
            Value<Uint8List> data = const Value.absent(),
            Value<int?> index = const Value.absent(),
            Value<IJsonEnum<FileType>> fileType = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> modifiedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              TbFileCompanion(
            uuid: uuid,
            refUuid: refUuid,
            filename: filename,
            data: data,
            index: index,
            fileType: fileType,
            createdAt: createdAt,
            modifiedAt: modifiedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            Value<String> uuid = const Value.absent(),
            Value<String?> refUuid = const Value.absent(),
            required String filename,
            required Uint8List data,
            Value<int?> index = const Value.absent(),
            required IJsonEnum<FileType> fileType,
            required DateTime createdAt,
            required DateTime modifiedAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              TbFileCompanion.insert(
            uuid: uuid,
            refUuid: refUuid,
            filename: filename,
            data: data,
            index: index,
            fileType: fileType,
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

typedef $$TbFileTableProcessedTableManager = ProcessedTableManager<
    _$FloorDatabase,
    $TbFileTable,
    TbFileData,
    $$TbFileTableFilterComposer,
    $$TbFileTableOrderingComposer,
    $$TbFileTableCreateCompanionBuilder,
    $$TbFileTableUpdateCompanionBuilder,
    (TbFileData, BaseReferences<_$FloorDatabase, $TbFileTable, TbFileData>),
    TbFileData,
    PrefetchHooks Function()>;

class $FloorDatabaseManager {
  final _$FloorDatabase _db;
  $FloorDatabaseManager(this._db);
  $$TbDocumentTableTableManager get tbDocument =>
      $$TbDocumentTableTableManager(_db, _db.tbDocument);
  $$TbFileTableTableManager get tbFile =>
      $$TbFileTableTableManager(_db, _db.tbFile);
}
