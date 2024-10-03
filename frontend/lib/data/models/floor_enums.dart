import 'package:floor_cv/utils/enum_utils.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'floor_enums.g.dart';

@JsonEnum(alwaysCreate: true)
enum FileType implements IJsonEnum<FileType> {
  @JsonValue(0)
  attachment,
  @JsonValue(1)
  capture,
  @JsonValue(2)
  report,
  @JsonValue(3)
  scan;

  @override
  int toJson() => _$FileTypeEnumMap[this]!;
}
