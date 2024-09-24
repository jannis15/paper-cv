import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

class TbDocument extends Table {
  TextColumn get uuid => text().clientDefault(() => const Uuid().v4())();

  TextColumn get title => text()();

  DateTimeColumn get createdAt => dateTime()();

  DateTimeColumn get modifiedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {uuid};
}
