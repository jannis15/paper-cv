import 'dart:convert';
import 'package:paper_cv/data/models/floor_enums.dart';
import 'package:paper_cv/domain/floor_models.dart';
import 'package:paper_cv/utils/api_utils.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:paper_cv/utils/date_format_utils.dart';
import 'package:paper_cv/utils/file_picker_models.dart';
import 'package:uuid/uuid.dart';

part 'floor_dto_models.freezed.dart';

part 'floor_dto_models.g.dart';

@freezed
class DocumentPreviewDto with _$DocumentPreviewDto {
  const factory DocumentPreviewDto({
    required String? uuid,
    required String title,
    required DateTime createdAt,
    required DateTime modifiedAt,
    required DateTime? documentDate,
    required bool isExample,
  }) = _DocumentPreviewDto;
}

@freezed
class ScanResultDto with _$ScanResultDto {
  ScanResultDto._();

  factory ScanResultDto({
    String? uuid,
    @JsonKey(name: 'column_widths_cm') required List<double> columnWidthsCm,
    @JsonKey(name: 'ref_uuid') required String refUuid,
    @JsonKey(name: 'avg_row_height_cm') required double avgRowHeightCm,
    @JsonKey(name: 'rows') required int rows,
    @JsonKey(name: 'table_x_cm') required double tableXCm,
    @JsonKey(name: 'table_y_cm') required double tableYCm,
    @JsonKey(name: 'img_width_px') required double imgWidthPx,
    @JsonKey(name: 'img_height_px') required double imgHeightPx,
    @JsonKey(name: 'cell_texts') required List<List<String>> cellTexts,
  }) = _ScanResultDto;

  factory ScanResultDto.fromJson(JsonObject json) => _$ScanResultDtoFromJson(json);

  ScanForm toForm() => ScanForm(
        uuid: this.uuid ?? Uuid().v4(),
        refUuid: this.refUuid,
        columnWidthsCm: this.columnWidthsCm,
        avgRowHeightCm: this.avgRowHeightCm,
        rows: this.rows,
        tableXCm: this.tableXCm,
        tableYCm: this.tableYCm,
        imgWidthPx: this.imgWidthPx,
        imgHeightPx: this.imgHeightPx,
        cellTexts: List.from(this.cellTexts),
      );

  SelectedFile toSelectedFile() {
    final now = DateTime.now();
    final String formattedDate = dateFormatDateTime.format(now);
    final data = utf8.encode(jsonEncode(toJson()));
    return SelectedFile(
      uuid: uuid ?? Uuid().v4(),
      filename: 'Scan $formattedDate.json',
      data: data,
      index: null,
      fileType: FileType.scan,
      createdAt: now,
      modifiedAt: now,
    );
  }
}

@freezed
class SelectionDto with _$SelectionDto {
  SelectionDto._();

  factory SelectionDto({
    required double x1,
    required double y1,
    required double x2,
    required double y2,
  }) = _SelectionDto;

  factory SelectionDto.fromJson(Map<String, dynamic> json) => _$SelectionDtoFromJson(json);
}

@freezed
class ScanRecalculationDto with _$ScanRecalculationDto {
  factory ScanRecalculationDto({
    @JsonKey(name: 'cell_texts') required List<List<String>> cellTexts,
    @JsonKey(name: 'template_no') required int templateNo,
  }) = _ScanRecalculationDto;

  factory ScanRecalculationDto.fromJson(Map<String, dynamic> json) => _$ScanRecalculationDtoFromJson(json);
}

@freezed
class ScanPropertiesDto with _$ScanPropertiesDto {
  ScanPropertiesDto._();

  factory ScanPropertiesDto({
    @JsonKey(name: 'ref_uuid') required String refUuid,
    @JsonKey(name: 'selection') required SelectionDto selection,
    @JsonKey(name: 'template_no') required int templateNo,
  }) = _ScanPropertiesDto;

  factory ScanPropertiesDto.fromJson(Map<String, dynamic> json) => _$ScanPropertiesDtoFromJson(json);
}
