import 'dart:convert';
import 'dart:typed_data';

import 'package:floor_cv/data/models/floor_enums.dart';
import 'package:floor_cv/utils/api_utils.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl/intl.dart';

part 'floor_dto_models.freezed.dart';

part 'floor_dto_models.g.dart';

@freezed
class DocumentPreviewDto with _$DocumentPreviewDto {
  const factory DocumentPreviewDto({
    required String? uuid,
    required String title,
    required DateTime createdAt,
    required DateTime modifiedAt,
  }) = _DocumentPreviewDto;
}

@freezed
class FileDto with _$FileDto {
  const factory FileDto({
    required String? uuid,
    required String? refUuid,
    required String filename,
    required Uint8List data,
    required int? index,
    required FileType fileType,
    required DateTime createdAt,
    required DateTime modifiedAt,
  }) = _FileDto;
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

  FileDto toFileDto({required String? formId}) {
    final now = DateTime.now();
    final String formattedDate = DateFormat('dd-MM-yyyy-HH-mm').format(now);
    final data = utf8.encode(jsonEncode(toJson()));
    return FileDto(
      uuid: uuid,
      refUuid: formId,
      filename: 'scan-$formattedDate.json',
      data: data,
      index: null,
      fileType: FileType.scan,
      createdAt: now,
      modifiedAt: now,
    );
  }
}
