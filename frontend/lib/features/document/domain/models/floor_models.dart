import 'dart:convert';
import 'package:paper_cv/core/utils/api_utils.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:paper_cv/core/utils/date_format_utils.dart';
import 'package:paper_cv/core/utils/file_picker_models.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/utils/enum_utils.dart';
import '../../../../generated/l10n.dart';

part 'floor_models.freezed.dart';

part 'floor_models.g.dart';

@JsonEnum(alwaysCreate: true)
enum SelectionType implements IJsonEnum<SelectionType> {
  @JsonValue(0)
  header,
  @JsonValue(1)
  table;

  @override
  int toJson() => _$SelectionTypeEnumMap[this]!;
}

@freezed
class DocumentPreviewDto with _$DocumentPreviewDto {
  const factory DocumentPreviewDto({
    required String uuid,
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

  SelectedFile toSelectedFile(String locale) {
    final now = DateTime.now();
    final String formattedDate = dateFormatDateTime(locale).format(now);
    final data = utf8.encode(jsonEncode(toJson()));
    return SelectedFile(
      uuid: uuid ?? Uuid().v4(),
      filename: '${S.current.scan} $formattedDate.json',
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

enum DocumentSortType {
  title,
  modifiedAt,
  documentDate;

  String get name => switch (this) {
        DocumentSortType.title => S.current.title,
        DocumentSortType.modifiedAt => S.current.modifiedAt,
        DocumentSortType.documentDate => S.current.documentDate,
      };
}

class Selection {
  String? uuid;
  double? tX1;
  double? tX2;
  double? tY1;
  double? tY2;
  double? hX1;
  double? hX2;
  double? hY1;
  double? hY2;

  Selection({
    this.uuid,
    this.tX1,
    this.tX2,
    this.tY1,
    this.tY2,
    this.hX1,
    this.hX2,
    this.hY1,
    this.hY2,
  });

  bool get isTSet => tX1 != null && tX2 != null && tY1 != null && tY2 != null;

  bool get isHSet => hX1 != null && hX2 != null && hY1 != null && hY2 != null;

  bool get isSet => this.isTSet && this.isHSet;

  SelectionDto toTDto() => SelectionDto(
        x1: tX1!,
        x2: tX2!,
        y1: tY1!,
        y2: tY2!,
      );
}

class DocumentForm {
  String? uuid;
  String title;
  String notes;
  List<SelectedFile> captures;
  List<SelectedFile> scans = [];
  List<SelectedFile> reports = [];
  DateTime? createdAt;
  DateTime? modifiedAt;
  DateTime? documentDate;
  Map<SelectedFile, Selection> selections;

  DocumentForm({
    this.uuid,
    this.title = '',
    this.notes = '',
    List<SelectedFile>? captures,
    List<SelectedFile>? scans,
    List<SelectedFile>? reports,
    this.createdAt,
    this.modifiedAt,
    this.documentDate,
    Map<SelectedFile, Selection>? selections,
  })  : captures = captures ?? [],
        scans = scans ?? [],
        reports = reports ?? [],
        selections = selections ?? {};

  bool get selectionsReady => selections.entries.map((entry) => entry.value.isTSet).where((entry) => entry).length == captures.length;
}

class ScanForm {
  String? uuid;
  String refUuid;
  List<double> columnWidthsCm;
  double avgRowHeightCm;
  int rows;
  double tableXCm;
  double tableYCm;
  double imgWidthPx;
  double imgHeightPx;
  List<List<String>> cellTexts;

  ScanForm({
    this.uuid,
    required this.refUuid,
    required this.columnWidthsCm,
    required this.avgRowHeightCm,
    required this.rows,
    required this.tableXCm,
    required this.tableYCm,
    required this.imgWidthPx,
    required this.imgHeightPx,
    required this.cellTexts,
  });

  ScanResultDto toDto() => ScanResultDto(
        uuid: this.uuid,
        refUuid: this.refUuid,
        columnWidthsCm: this.columnWidthsCm,
        avgRowHeightCm: this.avgRowHeightCm,
        rows: this.rows,
        tableXCm: this.tableXCm,
        tableYCm: this.tableYCm,
        imgWidthPx: this.imgWidthPx,
        imgHeightPx: this.imgHeightPx,
        cellTexts: this.cellTexts,
      );
}
