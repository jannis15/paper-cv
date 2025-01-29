import 'package:drift/drift.dart';
import 'package:paper_cv/core/utils/type_converters.dart';
import 'package:uuid/uuid.dart';
import '../../../../../core/utils/file_picker_models.dart';

class TbDocument extends Table {
  TextColumn get uuid => text().clientDefault(() => const Uuid().v4())();

  TextColumn get title => text()();

  TextColumn get notes => text()();

  DateTimeColumn get createdAt => dateTime()();

  DateTimeColumn get modifiedAt => dateTime()();

  DateTimeColumn get documentDate => dateTime().nullable()();

  BoolColumn get isExample => boolean().withDefault(Constant(false))();

  @override
  Set<Column> get primaryKey => {uuid};
}

class TbSelection extends Table {
  TextColumn get uuid => text().clientDefault(() => const Uuid().v4())();

  TextColumn get documentId => text().references(TbDocument, #uuid, onDelete: KeyAction.cascade)();

  TextColumn get fileId => text().references(TbFile, #uuid, onDelete: KeyAction.cascade)();

  RealColumn get tX1 => real().nullable()();

  RealColumn get tX2 => real().nullable()();

  RealColumn get tY1 => real().nullable()();

  RealColumn get tY2 => real().nullable()();

  RealColumn get hX1 => real().nullable()();

  RealColumn get hX2 => real().nullable()();

  RealColumn get hY1 => real().nullable()();

  RealColumn get hY2 => real().nullable()();

  @override
  Set<Column> get primaryKey => {uuid};
}

class TbFile extends Table {
  TextColumn get uuid => text().clientDefault(() => const Uuid().v4())();

  TextColumn get refUuid => text().nullable()();

  TextColumn get filename => text()();

  BlobColumn get data => blob()();

  IntColumn get index => integer().nullable()();

  IntColumn get fileType => integer().map(const EnumConverter(FileType.values))();

  DateTimeColumn get createdAt => dateTime()();

  DateTimeColumn get modifiedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {uuid};
}
