import 'dart:convert';
import 'package:paper_cv/data/models/floor_enums.dart';
import 'package:paper_cv/utils/api_utils.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl/intl.dart';
import 'package:paper_cv/utils/file_picker_models.dart';

part 'floor_dto_models.freezed.dart';

part 'floor_dto_models.g.dart';

@freezed
class DocumentPreviewDto with _$DocumentPreviewDto {
  const factory DocumentPreviewDto({
    required String? uuid,
    required String title,
    required DateTime createdAt,
    required DateTime modifiedAt,
    required bool isExample,
  }) = _DocumentPreviewDto;
}

@freezed
class ScanPropertiesDto with _$ScanPropertiesDto {
  ScanPropertiesDto._();

  factory ScanPropertiesDto({
    String? uuid,
    @JsonKey(name: 'column_widths') required List<double> columnWidths,
    @JsonKey(name: 'rows') required int rows,
    @JsonKey(name: 'avg_row_height') required double avgRowHeight,
    @JsonKey(name: 'cell_texts') required List<List<String>> cellTexts,
  }) = _ScanPropertiesDto;

  factory ScanPropertiesDto.fromJson(JsonObject json) => _$ScanPropertiesDtoFromJson(json);

  SelectedFile toSelectedFile() {
    final now = DateTime.now();
    final String formattedDate = DateFormat('dd.MM.yy HH:mm').format(now);
    final data = utf8.encode(jsonEncode(toJson()));
    return SelectedFile(
      uuid: uuid,
      filename: 'Scan $formattedDate.json',
      data: data,
      index: null,
      fileType: FileType.scan,
      createdAt: now,
      modifiedAt: now,
    );
  }
}
