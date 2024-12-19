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
  static const VerificationMeta _documentDateMeta =
      const VerificationMeta('documentDate');
  @override
  late final GeneratedColumn<DateTime> documentDate = GeneratedColumn<DateTime>(
      'document_date', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _isExampleMeta =
      const VerificationMeta('isExample');
  @override
  late final GeneratedColumn<bool> isExample = GeneratedColumn<bool>(
      'is_example', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_example" IN (0, 1))'),
      defaultValue: Constant(false));
  @override
  List<GeneratedColumn> get $columns =>
      [uuid, title, notes, createdAt, modifiedAt, documentDate, isExample];
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
    if (data.containsKey('document_date')) {
      context.handle(
          _documentDateMeta,
          documentDate.isAcceptableOrUnknown(
              data['document_date']!, _documentDateMeta));
    }
    if (data.containsKey('is_example')) {
      context.handle(_isExampleMeta,
          isExample.isAcceptableOrUnknown(data['is_example']!, _isExampleMeta));
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
      documentDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}document_date']),
      isExample: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_example'])!,
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
  final DateTime? documentDate;
  final bool isExample;
  const TbDocumentData(
      {required this.uuid,
      required this.title,
      required this.notes,
      required this.createdAt,
      required this.modifiedAt,
      this.documentDate,
      required this.isExample});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['uuid'] = Variable<String>(uuid);
    map['title'] = Variable<String>(title);
    map['notes'] = Variable<String>(notes);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['modified_at'] = Variable<DateTime>(modifiedAt);
    if (!nullToAbsent || documentDate != null) {
      map['document_date'] = Variable<DateTime>(documentDate);
    }
    map['is_example'] = Variable<bool>(isExample);
    return map;
  }

  TbDocumentCompanion toCompanion(bool nullToAbsent) {
    return TbDocumentCompanion(
      uuid: Value(uuid),
      title: Value(title),
      notes: Value(notes),
      createdAt: Value(createdAt),
      modifiedAt: Value(modifiedAt),
      documentDate: documentDate == null && nullToAbsent
          ? const Value.absent()
          : Value(documentDate),
      isExample: Value(isExample),
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
      documentDate: serializer.fromJson<DateTime?>(json['documentDate']),
      isExample: serializer.fromJson<bool>(json['isExample']),
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
      'documentDate': serializer.toJson<DateTime?>(documentDate),
      'isExample': serializer.toJson<bool>(isExample),
    };
  }

  TbDocumentData copyWith(
          {String? uuid,
          String? title,
          String? notes,
          DateTime? createdAt,
          DateTime? modifiedAt,
          Value<DateTime?> documentDate = const Value.absent(),
          bool? isExample}) =>
      TbDocumentData(
        uuid: uuid ?? this.uuid,
        title: title ?? this.title,
        notes: notes ?? this.notes,
        createdAt: createdAt ?? this.createdAt,
        modifiedAt: modifiedAt ?? this.modifiedAt,
        documentDate:
            documentDate.present ? documentDate.value : this.documentDate,
        isExample: isExample ?? this.isExample,
      );
  TbDocumentData copyWithCompanion(TbDocumentCompanion data) {
    return TbDocumentData(
      uuid: data.uuid.present ? data.uuid.value : this.uuid,
      title: data.title.present ? data.title.value : this.title,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      modifiedAt:
          data.modifiedAt.present ? data.modifiedAt.value : this.modifiedAt,
      documentDate: data.documentDate.present
          ? data.documentDate.value
          : this.documentDate,
      isExample: data.isExample.present ? data.isExample.value : this.isExample,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TbDocumentData(')
          ..write('uuid: $uuid, ')
          ..write('title: $title, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('modifiedAt: $modifiedAt, ')
          ..write('documentDate: $documentDate, ')
          ..write('isExample: $isExample')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      uuid, title, notes, createdAt, modifiedAt, documentDate, isExample);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TbDocumentData &&
          other.uuid == this.uuid &&
          other.title == this.title &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt &&
          other.modifiedAt == this.modifiedAt &&
          other.documentDate == this.documentDate &&
          other.isExample == this.isExample);
}

class TbDocumentCompanion extends UpdateCompanion<TbDocumentData> {
  final Value<String> uuid;
  final Value<String> title;
  final Value<String> notes;
  final Value<DateTime> createdAt;
  final Value<DateTime> modifiedAt;
  final Value<DateTime?> documentDate;
  final Value<bool> isExample;
  final Value<int> rowid;
  const TbDocumentCompanion({
    this.uuid = const Value.absent(),
    this.title = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.modifiedAt = const Value.absent(),
    this.documentDate = const Value.absent(),
    this.isExample = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TbDocumentCompanion.insert({
    this.uuid = const Value.absent(),
    required String title,
    required String notes,
    required DateTime createdAt,
    required DateTime modifiedAt,
    this.documentDate = const Value.absent(),
    this.isExample = const Value.absent(),
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
    Expression<DateTime>? documentDate,
    Expression<bool>? isExample,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (uuid != null) 'uuid': uuid,
      if (title != null) 'title': title,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
      if (modifiedAt != null) 'modified_at': modifiedAt,
      if (documentDate != null) 'document_date': documentDate,
      if (isExample != null) 'is_example': isExample,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TbDocumentCompanion copyWith(
      {Value<String>? uuid,
      Value<String>? title,
      Value<String>? notes,
      Value<DateTime>? createdAt,
      Value<DateTime>? modifiedAt,
      Value<DateTime?>? documentDate,
      Value<bool>? isExample,
      Value<int>? rowid}) {
    return TbDocumentCompanion(
      uuid: uuid ?? this.uuid,
      title: title ?? this.title,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      modifiedAt: modifiedAt ?? this.modifiedAt,
      documentDate: documentDate ?? this.documentDate,
      isExample: isExample ?? this.isExample,
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
    if (documentDate.present) {
      map['document_date'] = Variable<DateTime>(documentDate.value);
    }
    if (isExample.present) {
      map['is_example'] = Variable<bool>(isExample.value);
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
          ..write('documentDate: $documentDate, ')
          ..write('isExample: $isExample, ')
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

class $TbSelectionTable extends TbSelection
    with TableInfo<$TbSelectionTable, TbSelectionData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TbSelectionTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _uuidMeta = const VerificationMeta('uuid');
  @override
  late final GeneratedColumn<String> uuid = GeneratedColumn<String>(
      'uuid', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      clientDefault: () => const Uuid().v4());
  static const VerificationMeta _documentIdMeta =
      const VerificationMeta('documentId');
  @override
  late final GeneratedColumn<String> documentId = GeneratedColumn<String>(
      'document_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES tb_document (uuid) ON DELETE CASCADE'));
  static const VerificationMeta _fileIdMeta = const VerificationMeta('fileId');
  @override
  late final GeneratedColumn<String> fileId = GeneratedColumn<String>(
      'file_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES tb_file (uuid) ON DELETE CASCADE'));
  static const VerificationMeta _x1Meta = const VerificationMeta('x1');
  @override
  late final GeneratedColumn<double> x1 = GeneratedColumn<double>(
      'x1', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _x2Meta = const VerificationMeta('x2');
  @override
  late final GeneratedColumn<double> x2 = GeneratedColumn<double>(
      'x2', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _y1Meta = const VerificationMeta('y1');
  @override
  late final GeneratedColumn<double> y1 = GeneratedColumn<double>(
      'y1', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _y2Meta = const VerificationMeta('y2');
  @override
  late final GeneratedColumn<double> y2 = GeneratedColumn<double>(
      'y2', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [uuid, documentId, fileId, x1, x2, y1, y2];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tb_selection';
  @override
  VerificationContext validateIntegrity(Insertable<TbSelectionData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('uuid')) {
      context.handle(
          _uuidMeta, uuid.isAcceptableOrUnknown(data['uuid']!, _uuidMeta));
    }
    if (data.containsKey('document_id')) {
      context.handle(
          _documentIdMeta,
          documentId.isAcceptableOrUnknown(
              data['document_id']!, _documentIdMeta));
    } else if (isInserting) {
      context.missing(_documentIdMeta);
    }
    if (data.containsKey('file_id')) {
      context.handle(_fileIdMeta,
          fileId.isAcceptableOrUnknown(data['file_id']!, _fileIdMeta));
    } else if (isInserting) {
      context.missing(_fileIdMeta);
    }
    if (data.containsKey('x1')) {
      context.handle(_x1Meta, x1.isAcceptableOrUnknown(data['x1']!, _x1Meta));
    } else if (isInserting) {
      context.missing(_x1Meta);
    }
    if (data.containsKey('x2')) {
      context.handle(_x2Meta, x2.isAcceptableOrUnknown(data['x2']!, _x2Meta));
    } else if (isInserting) {
      context.missing(_x2Meta);
    }
    if (data.containsKey('y1')) {
      context.handle(_y1Meta, y1.isAcceptableOrUnknown(data['y1']!, _y1Meta));
    } else if (isInserting) {
      context.missing(_y1Meta);
    }
    if (data.containsKey('y2')) {
      context.handle(_y2Meta, y2.isAcceptableOrUnknown(data['y2']!, _y2Meta));
    } else if (isInserting) {
      context.missing(_y2Meta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {uuid};
  @override
  TbSelectionData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TbSelectionData(
      uuid: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}uuid'])!,
      documentId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}document_id'])!,
      fileId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}file_id'])!,
      x1: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}x1'])!,
      x2: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}x2'])!,
      y1: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}y1'])!,
      y2: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}y2'])!,
    );
  }

  @override
  $TbSelectionTable createAlias(String alias) {
    return $TbSelectionTable(attachedDatabase, alias);
  }
}

class TbSelectionData extends DataClass implements Insertable<TbSelectionData> {
  final String uuid;
  final String documentId;
  final String fileId;
  final double x1;
  final double x2;
  final double y1;
  final double y2;
  const TbSelectionData(
      {required this.uuid,
      required this.documentId,
      required this.fileId,
      required this.x1,
      required this.x2,
      required this.y1,
      required this.y2});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['uuid'] = Variable<String>(uuid);
    map['document_id'] = Variable<String>(documentId);
    map['file_id'] = Variable<String>(fileId);
    map['x1'] = Variable<double>(x1);
    map['x2'] = Variable<double>(x2);
    map['y1'] = Variable<double>(y1);
    map['y2'] = Variable<double>(y2);
    return map;
  }

  TbSelectionCompanion toCompanion(bool nullToAbsent) {
    return TbSelectionCompanion(
      uuid: Value(uuid),
      documentId: Value(documentId),
      fileId: Value(fileId),
      x1: Value(x1),
      x2: Value(x2),
      y1: Value(y1),
      y2: Value(y2),
    );
  }

  factory TbSelectionData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TbSelectionData(
      uuid: serializer.fromJson<String>(json['uuid']),
      documentId: serializer.fromJson<String>(json['documentId']),
      fileId: serializer.fromJson<String>(json['fileId']),
      x1: serializer.fromJson<double>(json['x1']),
      x2: serializer.fromJson<double>(json['x2']),
      y1: serializer.fromJson<double>(json['y1']),
      y2: serializer.fromJson<double>(json['y2']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'uuid': serializer.toJson<String>(uuid),
      'documentId': serializer.toJson<String>(documentId),
      'fileId': serializer.toJson<String>(fileId),
      'x1': serializer.toJson<double>(x1),
      'x2': serializer.toJson<double>(x2),
      'y1': serializer.toJson<double>(y1),
      'y2': serializer.toJson<double>(y2),
    };
  }

  TbSelectionData copyWith(
          {String? uuid,
          String? documentId,
          String? fileId,
          double? x1,
          double? x2,
          double? y1,
          double? y2}) =>
      TbSelectionData(
        uuid: uuid ?? this.uuid,
        documentId: documentId ?? this.documentId,
        fileId: fileId ?? this.fileId,
        x1: x1 ?? this.x1,
        x2: x2 ?? this.x2,
        y1: y1 ?? this.y1,
        y2: y2 ?? this.y2,
      );
  TbSelectionData copyWithCompanion(TbSelectionCompanion data) {
    return TbSelectionData(
      uuid: data.uuid.present ? data.uuid.value : this.uuid,
      documentId:
          data.documentId.present ? data.documentId.value : this.documentId,
      fileId: data.fileId.present ? data.fileId.value : this.fileId,
      x1: data.x1.present ? data.x1.value : this.x1,
      x2: data.x2.present ? data.x2.value : this.x2,
      y1: data.y1.present ? data.y1.value : this.y1,
      y2: data.y2.present ? data.y2.value : this.y2,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TbSelectionData(')
          ..write('uuid: $uuid, ')
          ..write('documentId: $documentId, ')
          ..write('fileId: $fileId, ')
          ..write('x1: $x1, ')
          ..write('x2: $x2, ')
          ..write('y1: $y1, ')
          ..write('y2: $y2')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(uuid, documentId, fileId, x1, x2, y1, y2);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TbSelectionData &&
          other.uuid == this.uuid &&
          other.documentId == this.documentId &&
          other.fileId == this.fileId &&
          other.x1 == this.x1 &&
          other.x2 == this.x2 &&
          other.y1 == this.y1 &&
          other.y2 == this.y2);
}

class TbSelectionCompanion extends UpdateCompanion<TbSelectionData> {
  final Value<String> uuid;
  final Value<String> documentId;
  final Value<String> fileId;
  final Value<double> x1;
  final Value<double> x2;
  final Value<double> y1;
  final Value<double> y2;
  final Value<int> rowid;
  const TbSelectionCompanion({
    this.uuid = const Value.absent(),
    this.documentId = const Value.absent(),
    this.fileId = const Value.absent(),
    this.x1 = const Value.absent(),
    this.x2 = const Value.absent(),
    this.y1 = const Value.absent(),
    this.y2 = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TbSelectionCompanion.insert({
    this.uuid = const Value.absent(),
    required String documentId,
    required String fileId,
    required double x1,
    required double x2,
    required double y1,
    required double y2,
    this.rowid = const Value.absent(),
  })  : documentId = Value(documentId),
        fileId = Value(fileId),
        x1 = Value(x1),
        x2 = Value(x2),
        y1 = Value(y1),
        y2 = Value(y2);
  static Insertable<TbSelectionData> custom({
    Expression<String>? uuid,
    Expression<String>? documentId,
    Expression<String>? fileId,
    Expression<double>? x1,
    Expression<double>? x2,
    Expression<double>? y1,
    Expression<double>? y2,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (uuid != null) 'uuid': uuid,
      if (documentId != null) 'document_id': documentId,
      if (fileId != null) 'file_id': fileId,
      if (x1 != null) 'x1': x1,
      if (x2 != null) 'x2': x2,
      if (y1 != null) 'y1': y1,
      if (y2 != null) 'y2': y2,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TbSelectionCompanion copyWith(
      {Value<String>? uuid,
      Value<String>? documentId,
      Value<String>? fileId,
      Value<double>? x1,
      Value<double>? x2,
      Value<double>? y1,
      Value<double>? y2,
      Value<int>? rowid}) {
    return TbSelectionCompanion(
      uuid: uuid ?? this.uuid,
      documentId: documentId ?? this.documentId,
      fileId: fileId ?? this.fileId,
      x1: x1 ?? this.x1,
      x2: x2 ?? this.x2,
      y1: y1 ?? this.y1,
      y2: y2 ?? this.y2,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (uuid.present) {
      map['uuid'] = Variable<String>(uuid.value);
    }
    if (documentId.present) {
      map['document_id'] = Variable<String>(documentId.value);
    }
    if (fileId.present) {
      map['file_id'] = Variable<String>(fileId.value);
    }
    if (x1.present) {
      map['x1'] = Variable<double>(x1.value);
    }
    if (x2.present) {
      map['x2'] = Variable<double>(x2.value);
    }
    if (y1.present) {
      map['y1'] = Variable<double>(y1.value);
    }
    if (y2.present) {
      map['y2'] = Variable<double>(y2.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TbSelectionCompanion(')
          ..write('uuid: $uuid, ')
          ..write('documentId: $documentId, ')
          ..write('fileId: $fileId, ')
          ..write('x1: $x1, ')
          ..write('x2: $x2, ')
          ..write('y1: $y1, ')
          ..write('y2: $y2, ')
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
  late final $TbSelectionTable tbSelection = $TbSelectionTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [tbDocument, tbFile, tbSelection];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules(
        [
          WritePropagation(
            on: TableUpdateQuery.onTableName('tb_document',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('tb_selection', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('tb_file',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('tb_selection', kind: UpdateKind.delete),
            ],
          ),
        ],
      );
}

typedef $$TbDocumentTableCreateCompanionBuilder = TbDocumentCompanion Function({
  Value<String> uuid,
  required String title,
  required String notes,
  required DateTime createdAt,
  required DateTime modifiedAt,
  Value<DateTime?> documentDate,
  Value<bool> isExample,
  Value<int> rowid,
});
typedef $$TbDocumentTableUpdateCompanionBuilder = TbDocumentCompanion Function({
  Value<String> uuid,
  Value<String> title,
  Value<String> notes,
  Value<DateTime> createdAt,
  Value<DateTime> modifiedAt,
  Value<DateTime?> documentDate,
  Value<bool> isExample,
  Value<int> rowid,
});

final class $$TbDocumentTableReferences
    extends BaseReferences<_$FloorDatabase, $TbDocumentTable, TbDocumentData> {
  $$TbDocumentTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$TbSelectionTable, List<TbSelectionData>>
      _tbSelectionRefsTable(_$FloorDatabase db) =>
          MultiTypedResultKey.fromTable(db.tbSelection,
              aliasName: $_aliasNameGenerator(
                  db.tbDocument.uuid, db.tbSelection.documentId));

  $$TbSelectionTableProcessedTableManager get tbSelectionRefs {
    final manager = $$TbSelectionTableTableManager($_db, $_db.tbSelection)
        .filter((f) => f.documentId.uuid($_item.uuid));

    final cache = $_typedResult.readTableOrNull(_tbSelectionRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$TbDocumentTableFilterComposer
    extends Composer<_$FloorDatabase, $TbDocumentTable> {
  $$TbDocumentTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get uuid => $composableBuilder(
      column: $table.uuid, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get modifiedAt => $composableBuilder(
      column: $table.modifiedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get documentDate => $composableBuilder(
      column: $table.documentDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isExample => $composableBuilder(
      column: $table.isExample, builder: (column) => ColumnFilters(column));

  Expression<bool> tbSelectionRefs(
      Expression<bool> Function($$TbSelectionTableFilterComposer f) f) {
    final $$TbSelectionTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.uuid,
        referencedTable: $db.tbSelection,
        getReferencedColumn: (t) => t.documentId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TbSelectionTableFilterComposer(
              $db: $db,
              $table: $db.tbSelection,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$TbDocumentTableOrderingComposer
    extends Composer<_$FloorDatabase, $TbDocumentTable> {
  $$TbDocumentTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get uuid => $composableBuilder(
      column: $table.uuid, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get modifiedAt => $composableBuilder(
      column: $table.modifiedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get documentDate => $composableBuilder(
      column: $table.documentDate,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isExample => $composableBuilder(
      column: $table.isExample, builder: (column) => ColumnOrderings(column));
}

class $$TbDocumentTableAnnotationComposer
    extends Composer<_$FloorDatabase, $TbDocumentTable> {
  $$TbDocumentTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get uuid =>
      $composableBuilder(column: $table.uuid, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get modifiedAt => $composableBuilder(
      column: $table.modifiedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get documentDate => $composableBuilder(
      column: $table.documentDate, builder: (column) => column);

  GeneratedColumn<bool> get isExample =>
      $composableBuilder(column: $table.isExample, builder: (column) => column);

  Expression<T> tbSelectionRefs<T extends Object>(
      Expression<T> Function($$TbSelectionTableAnnotationComposer a) f) {
    final $$TbSelectionTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.uuid,
        referencedTable: $db.tbSelection,
        getReferencedColumn: (t) => t.documentId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TbSelectionTableAnnotationComposer(
              $db: $db,
              $table: $db.tbSelection,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$TbDocumentTableTableManager extends RootTableManager<
    _$FloorDatabase,
    $TbDocumentTable,
    TbDocumentData,
    $$TbDocumentTableFilterComposer,
    $$TbDocumentTableOrderingComposer,
    $$TbDocumentTableAnnotationComposer,
    $$TbDocumentTableCreateCompanionBuilder,
    $$TbDocumentTableUpdateCompanionBuilder,
    (TbDocumentData, $$TbDocumentTableReferences),
    TbDocumentData,
    PrefetchHooks Function({bool tbSelectionRefs})> {
  $$TbDocumentTableTableManager(_$FloorDatabase db, $TbDocumentTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TbDocumentTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TbDocumentTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TbDocumentTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> uuid = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String> notes = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> modifiedAt = const Value.absent(),
            Value<DateTime?> documentDate = const Value.absent(),
            Value<bool> isExample = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              TbDocumentCompanion(
            uuid: uuid,
            title: title,
            notes: notes,
            createdAt: createdAt,
            modifiedAt: modifiedAt,
            documentDate: documentDate,
            isExample: isExample,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            Value<String> uuid = const Value.absent(),
            required String title,
            required String notes,
            required DateTime createdAt,
            required DateTime modifiedAt,
            Value<DateTime?> documentDate = const Value.absent(),
            Value<bool> isExample = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              TbDocumentCompanion.insert(
            uuid: uuid,
            title: title,
            notes: notes,
            createdAt: createdAt,
            modifiedAt: modifiedAt,
            documentDate: documentDate,
            isExample: isExample,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$TbDocumentTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({tbSelectionRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (tbSelectionRefs) db.tbSelection],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (tbSelectionRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$TbDocumentTableReferences
                            ._tbSelectionRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$TbDocumentTableReferences(db, table, p0)
                                .tbSelectionRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.documentId == item.uuid),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$TbDocumentTableProcessedTableManager = ProcessedTableManager<
    _$FloorDatabase,
    $TbDocumentTable,
    TbDocumentData,
    $$TbDocumentTableFilterComposer,
    $$TbDocumentTableOrderingComposer,
    $$TbDocumentTableAnnotationComposer,
    $$TbDocumentTableCreateCompanionBuilder,
    $$TbDocumentTableUpdateCompanionBuilder,
    (TbDocumentData, $$TbDocumentTableReferences),
    TbDocumentData,
    PrefetchHooks Function({bool tbSelectionRefs})>;
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

final class $$TbFileTableReferences
    extends BaseReferences<_$FloorDatabase, $TbFileTable, TbFileData> {
  $$TbFileTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$TbSelectionTable, List<TbSelectionData>>
      _tbSelectionRefsTable(_$FloorDatabase db) =>
          MultiTypedResultKey.fromTable(db.tbSelection,
              aliasName:
                  $_aliasNameGenerator(db.tbFile.uuid, db.tbSelection.fileId));

  $$TbSelectionTableProcessedTableManager get tbSelectionRefs {
    final manager = $$TbSelectionTableTableManager($_db, $_db.tbSelection)
        .filter((f) => f.fileId.uuid($_item.uuid));

    final cache = $_typedResult.readTableOrNull(_tbSelectionRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$TbFileTableFilterComposer
    extends Composer<_$FloorDatabase, $TbFileTable> {
  $$TbFileTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get uuid => $composableBuilder(
      column: $table.uuid, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get refUuid => $composableBuilder(
      column: $table.refUuid, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get filename => $composableBuilder(
      column: $table.filename, builder: (column) => ColumnFilters(column));

  ColumnFilters<Uint8List> get data => $composableBuilder(
      column: $table.data, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get index => $composableBuilder(
      column: $table.index, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<IJsonEnum<FileType>, IJsonEnum<FileType>, int>
      get fileType => $composableBuilder(
          column: $table.fileType,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get modifiedAt => $composableBuilder(
      column: $table.modifiedAt, builder: (column) => ColumnFilters(column));

  Expression<bool> tbSelectionRefs(
      Expression<bool> Function($$TbSelectionTableFilterComposer f) f) {
    final $$TbSelectionTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.uuid,
        referencedTable: $db.tbSelection,
        getReferencedColumn: (t) => t.fileId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TbSelectionTableFilterComposer(
              $db: $db,
              $table: $db.tbSelection,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$TbFileTableOrderingComposer
    extends Composer<_$FloorDatabase, $TbFileTable> {
  $$TbFileTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get uuid => $composableBuilder(
      column: $table.uuid, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get refUuid => $composableBuilder(
      column: $table.refUuid, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get filename => $composableBuilder(
      column: $table.filename, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<Uint8List> get data => $composableBuilder(
      column: $table.data, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get index => $composableBuilder(
      column: $table.index, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get fileType => $composableBuilder(
      column: $table.fileType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get modifiedAt => $composableBuilder(
      column: $table.modifiedAt, builder: (column) => ColumnOrderings(column));
}

class $$TbFileTableAnnotationComposer
    extends Composer<_$FloorDatabase, $TbFileTable> {
  $$TbFileTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get uuid =>
      $composableBuilder(column: $table.uuid, builder: (column) => column);

  GeneratedColumn<String> get refUuid =>
      $composableBuilder(column: $table.refUuid, builder: (column) => column);

  GeneratedColumn<String> get filename =>
      $composableBuilder(column: $table.filename, builder: (column) => column);

  GeneratedColumn<Uint8List> get data =>
      $composableBuilder(column: $table.data, builder: (column) => column);

  GeneratedColumn<int> get index =>
      $composableBuilder(column: $table.index, builder: (column) => column);

  GeneratedColumnWithTypeConverter<IJsonEnum<FileType>, int> get fileType =>
      $composableBuilder(column: $table.fileType, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get modifiedAt => $composableBuilder(
      column: $table.modifiedAt, builder: (column) => column);

  Expression<T> tbSelectionRefs<T extends Object>(
      Expression<T> Function($$TbSelectionTableAnnotationComposer a) f) {
    final $$TbSelectionTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.uuid,
        referencedTable: $db.tbSelection,
        getReferencedColumn: (t) => t.fileId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TbSelectionTableAnnotationComposer(
              $db: $db,
              $table: $db.tbSelection,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$TbFileTableTableManager extends RootTableManager<
    _$FloorDatabase,
    $TbFileTable,
    TbFileData,
    $$TbFileTableFilterComposer,
    $$TbFileTableOrderingComposer,
    $$TbFileTableAnnotationComposer,
    $$TbFileTableCreateCompanionBuilder,
    $$TbFileTableUpdateCompanionBuilder,
    (TbFileData, $$TbFileTableReferences),
    TbFileData,
    PrefetchHooks Function({bool tbSelectionRefs})> {
  $$TbFileTableTableManager(_$FloorDatabase db, $TbFileTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TbFileTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TbFileTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TbFileTableAnnotationComposer($db: db, $table: table),
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
              .map((e) =>
                  (e.readTable(table), $$TbFileTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({tbSelectionRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (tbSelectionRefs) db.tbSelection],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (tbSelectionRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable:
                            $$TbFileTableReferences._tbSelectionRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$TbFileTableReferences(db, table, p0)
                                .tbSelectionRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.fileId == item.uuid),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$TbFileTableProcessedTableManager = ProcessedTableManager<
    _$FloorDatabase,
    $TbFileTable,
    TbFileData,
    $$TbFileTableFilterComposer,
    $$TbFileTableOrderingComposer,
    $$TbFileTableAnnotationComposer,
    $$TbFileTableCreateCompanionBuilder,
    $$TbFileTableUpdateCompanionBuilder,
    (TbFileData, $$TbFileTableReferences),
    TbFileData,
    PrefetchHooks Function({bool tbSelectionRefs})>;
typedef $$TbSelectionTableCreateCompanionBuilder = TbSelectionCompanion
    Function({
  Value<String> uuid,
  required String documentId,
  required String fileId,
  required double x1,
  required double x2,
  required double y1,
  required double y2,
  Value<int> rowid,
});
typedef $$TbSelectionTableUpdateCompanionBuilder = TbSelectionCompanion
    Function({
  Value<String> uuid,
  Value<String> documentId,
  Value<String> fileId,
  Value<double> x1,
  Value<double> x2,
  Value<double> y1,
  Value<double> y2,
  Value<int> rowid,
});

final class $$TbSelectionTableReferences extends BaseReferences<_$FloorDatabase,
    $TbSelectionTable, TbSelectionData> {
  $$TbSelectionTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $TbDocumentTable _documentIdTable(_$FloorDatabase db) =>
      db.tbDocument.createAlias(
          $_aliasNameGenerator(db.tbSelection.documentId, db.tbDocument.uuid));

  $$TbDocumentTableProcessedTableManager get documentId {
    final manager = $$TbDocumentTableTableManager($_db, $_db.tbDocument)
        .filter((f) => f.uuid($_item.documentId!));
    final item = $_typedResult.readTableOrNull(_documentIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $TbFileTable _fileIdTable(_$FloorDatabase db) => db.tbFile
      .createAlias($_aliasNameGenerator(db.tbSelection.fileId, db.tbFile.uuid));

  $$TbFileTableProcessedTableManager get fileId {
    final manager = $$TbFileTableTableManager($_db, $_db.tbFile)
        .filter((f) => f.uuid($_item.fileId!));
    final item = $_typedResult.readTableOrNull(_fileIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$TbSelectionTableFilterComposer
    extends Composer<_$FloorDatabase, $TbSelectionTable> {
  $$TbSelectionTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get uuid => $composableBuilder(
      column: $table.uuid, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get x1 => $composableBuilder(
      column: $table.x1, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get x2 => $composableBuilder(
      column: $table.x2, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get y1 => $composableBuilder(
      column: $table.y1, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get y2 => $composableBuilder(
      column: $table.y2, builder: (column) => ColumnFilters(column));

  $$TbDocumentTableFilterComposer get documentId {
    final $$TbDocumentTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.documentId,
        referencedTable: $db.tbDocument,
        getReferencedColumn: (t) => t.uuid,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TbDocumentTableFilterComposer(
              $db: $db,
              $table: $db.tbDocument,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$TbFileTableFilterComposer get fileId {
    final $$TbFileTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.fileId,
        referencedTable: $db.tbFile,
        getReferencedColumn: (t) => t.uuid,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TbFileTableFilterComposer(
              $db: $db,
              $table: $db.tbFile,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$TbSelectionTableOrderingComposer
    extends Composer<_$FloorDatabase, $TbSelectionTable> {
  $$TbSelectionTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get uuid => $composableBuilder(
      column: $table.uuid, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get x1 => $composableBuilder(
      column: $table.x1, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get x2 => $composableBuilder(
      column: $table.x2, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get y1 => $composableBuilder(
      column: $table.y1, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get y2 => $composableBuilder(
      column: $table.y2, builder: (column) => ColumnOrderings(column));

  $$TbDocumentTableOrderingComposer get documentId {
    final $$TbDocumentTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.documentId,
        referencedTable: $db.tbDocument,
        getReferencedColumn: (t) => t.uuid,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TbDocumentTableOrderingComposer(
              $db: $db,
              $table: $db.tbDocument,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$TbFileTableOrderingComposer get fileId {
    final $$TbFileTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.fileId,
        referencedTable: $db.tbFile,
        getReferencedColumn: (t) => t.uuid,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TbFileTableOrderingComposer(
              $db: $db,
              $table: $db.tbFile,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$TbSelectionTableAnnotationComposer
    extends Composer<_$FloorDatabase, $TbSelectionTable> {
  $$TbSelectionTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get uuid =>
      $composableBuilder(column: $table.uuid, builder: (column) => column);

  GeneratedColumn<double> get x1 =>
      $composableBuilder(column: $table.x1, builder: (column) => column);

  GeneratedColumn<double> get x2 =>
      $composableBuilder(column: $table.x2, builder: (column) => column);

  GeneratedColumn<double> get y1 =>
      $composableBuilder(column: $table.y1, builder: (column) => column);

  GeneratedColumn<double> get y2 =>
      $composableBuilder(column: $table.y2, builder: (column) => column);

  $$TbDocumentTableAnnotationComposer get documentId {
    final $$TbDocumentTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.documentId,
        referencedTable: $db.tbDocument,
        getReferencedColumn: (t) => t.uuid,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TbDocumentTableAnnotationComposer(
              $db: $db,
              $table: $db.tbDocument,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$TbFileTableAnnotationComposer get fileId {
    final $$TbFileTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.fileId,
        referencedTable: $db.tbFile,
        getReferencedColumn: (t) => t.uuid,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TbFileTableAnnotationComposer(
              $db: $db,
              $table: $db.tbFile,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$TbSelectionTableTableManager extends RootTableManager<
    _$FloorDatabase,
    $TbSelectionTable,
    TbSelectionData,
    $$TbSelectionTableFilterComposer,
    $$TbSelectionTableOrderingComposer,
    $$TbSelectionTableAnnotationComposer,
    $$TbSelectionTableCreateCompanionBuilder,
    $$TbSelectionTableUpdateCompanionBuilder,
    (TbSelectionData, $$TbSelectionTableReferences),
    TbSelectionData,
    PrefetchHooks Function({bool documentId, bool fileId})> {
  $$TbSelectionTableTableManager(_$FloorDatabase db, $TbSelectionTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TbSelectionTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TbSelectionTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TbSelectionTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> uuid = const Value.absent(),
            Value<String> documentId = const Value.absent(),
            Value<String> fileId = const Value.absent(),
            Value<double> x1 = const Value.absent(),
            Value<double> x2 = const Value.absent(),
            Value<double> y1 = const Value.absent(),
            Value<double> y2 = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              TbSelectionCompanion(
            uuid: uuid,
            documentId: documentId,
            fileId: fileId,
            x1: x1,
            x2: x2,
            y1: y1,
            y2: y2,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            Value<String> uuid = const Value.absent(),
            required String documentId,
            required String fileId,
            required double x1,
            required double x2,
            required double y1,
            required double y2,
            Value<int> rowid = const Value.absent(),
          }) =>
              TbSelectionCompanion.insert(
            uuid: uuid,
            documentId: documentId,
            fileId: fileId,
            x1: x1,
            x2: x2,
            y1: y1,
            y2: y2,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$TbSelectionTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({documentId = false, fileId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
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
                      dynamic>>(state) {
                if (documentId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.documentId,
                    referencedTable:
                        $$TbSelectionTableReferences._documentIdTable(db),
                    referencedColumn:
                        $$TbSelectionTableReferences._documentIdTable(db).uuid,
                  ) as T;
                }
                if (fileId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.fileId,
                    referencedTable:
                        $$TbSelectionTableReferences._fileIdTable(db),
                    referencedColumn:
                        $$TbSelectionTableReferences._fileIdTable(db).uuid,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$TbSelectionTableProcessedTableManager = ProcessedTableManager<
    _$FloorDatabase,
    $TbSelectionTable,
    TbSelectionData,
    $$TbSelectionTableFilterComposer,
    $$TbSelectionTableOrderingComposer,
    $$TbSelectionTableAnnotationComposer,
    $$TbSelectionTableCreateCompanionBuilder,
    $$TbSelectionTableUpdateCompanionBuilder,
    (TbSelectionData, $$TbSelectionTableReferences),
    TbSelectionData,
    PrefetchHooks Function({bool documentId, bool fileId})>;

class $FloorDatabaseManager {
  final _$FloorDatabase _db;
  $FloorDatabaseManager(this._db);
  $$TbDocumentTableTableManager get tbDocument =>
      $$TbDocumentTableTableManager(_db, _db.tbDocument);
  $$TbFileTableTableManager get tbFile =>
      $$TbFileTableTableManager(_db, _db.tbFile);
  $$TbSelectionTableTableManager get tbSelection =>
      $$TbSelectionTableTableManager(_db, _db.tbSelection);
}
