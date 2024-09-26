import 'package:drift/drift.dart';
import 'package:floor_cv/data/models/floor_enums.dart';
import 'package:floor_cv/utils/type_converters.dart';
import 'package:uuid/uuid.dart';

class TbDocument extends Table {
  TextColumn get uuid => text().clientDefault(() => const Uuid().v4())();

  TextColumn get title => text()();

  TextColumn get notes => text()();

  DateTimeColumn get createdAt => dateTime()();

  DateTimeColumn get modifiedAt => dateTime()();

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
