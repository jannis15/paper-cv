import 'package:drift/drift.dart';
import 'package:paper_cv/utils/enum_utils.dart';

class EnumConverter<T extends Enum> extends TypeConverter<IJsonEnum<T>, int> {
  final List<IJsonEnum<T>> values;

  const EnumConverter(this.values);

  @override
  IJsonEnum<T> fromSql(int fromDb) => values.firstWhere((element) => element.toJson() == fromDb);

  @override
  int toSql(IJsonEnum value) => value.toJson();
}
