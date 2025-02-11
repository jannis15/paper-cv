// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'floor_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ScanResultDtoImpl _$$ScanResultDtoImplFromJson(Map<String, dynamic> json) =>
    _$ScanResultDtoImpl(
      uuid: json['uuid'] as String?,
      columnWidthsCm: (json['column_widths_cm'] as List<dynamic>)
          .map((e) => (e as num).toDouble())
          .toList(),
      refUuid: json['ref_uuid'] as String,
      avgRowHeightCm: (json['avg_row_height_cm'] as num).toDouble(),
      rows: (json['rows'] as num).toInt(),
      tableXCm: (json['table_x_cm'] as num).toDouble(),
      tableYCm: (json['table_y_cm'] as num).toDouble(),
      imgWidthPx: (json['img_width_px'] as num).toDouble(),
      imgHeightPx: (json['img_height_px'] as num).toDouble(),
      cellTexts: (json['cell_texts'] as List<dynamic>)
          .map((e) => (e as List<dynamic>).map((e) => e as String).toList())
          .toList(),
    );

Map<String, dynamic> _$$ScanResultDtoImplToJson(_$ScanResultDtoImpl instance) =>
    <String, dynamic>{
      'uuid': instance.uuid,
      'column_widths_cm': instance.columnWidthsCm,
      'ref_uuid': instance.refUuid,
      'avg_row_height_cm': instance.avgRowHeightCm,
      'rows': instance.rows,
      'table_x_cm': instance.tableXCm,
      'table_y_cm': instance.tableYCm,
      'img_width_px': instance.imgWidthPx,
      'img_height_px': instance.imgHeightPx,
      'cell_texts': instance.cellTexts,
    };

_$SelectionDtoImpl _$$SelectionDtoImplFromJson(Map<String, dynamic> json) =>
    _$SelectionDtoImpl(
      x1: (json['x1'] as num).toDouble(),
      y1: (json['y1'] as num).toDouble(),
      x2: (json['x2'] as num).toDouble(),
      y2: (json['y2'] as num).toDouble(),
    );

Map<String, dynamic> _$$SelectionDtoImplToJson(_$SelectionDtoImpl instance) =>
    <String, dynamic>{
      'x1': instance.x1,
      'y1': instance.y1,
      'x2': instance.x2,
      'y2': instance.y2,
    };

_$ScanRecalculationDtoImpl _$$ScanRecalculationDtoImplFromJson(
        Map<String, dynamic> json) =>
    _$ScanRecalculationDtoImpl(
      cellTexts: (json['cell_texts'] as List<dynamic>)
          .map((e) => (e as List<dynamic>).map((e) => e as String).toList())
          .toList(),
      templateNo: (json['template_no'] as num).toInt(),
    );

Map<String, dynamic> _$$ScanRecalculationDtoImplToJson(
        _$ScanRecalculationDtoImpl instance) =>
    <String, dynamic>{
      'cell_texts': instance.cellTexts,
      'template_no': instance.templateNo,
    };

_$ScanPropertiesDtoImpl _$$ScanPropertiesDtoImplFromJson(
        Map<String, dynamic> json) =>
    _$ScanPropertiesDtoImpl(
      refUuid: json['ref_uuid'] as String,
      selection:
          SelectionDto.fromJson(json['selection'] as Map<String, dynamic>),
      templateNo: (json['template_no'] as num).toInt(),
    );

Map<String, dynamic> _$$ScanPropertiesDtoImplToJson(
        _$ScanPropertiesDtoImpl instance) =>
    <String, dynamic>{
      'ref_uuid': instance.refUuid,
      'selection': instance.selection,
      'template_no': instance.templateNo,
    };

const _$SelectionTypeEnumMap = {
  SelectionType.header: 0,
  SelectionType.table: 1,
};
