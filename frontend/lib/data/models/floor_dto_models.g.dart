// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'floor_dto_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ScanPropertiesDtoImpl _$$ScanPropertiesDtoImplFromJson(
        Map<String, dynamic> json) =>
    _$ScanPropertiesDtoImpl(
      uuid: json['uuid'] as String?,
      columnWidthsCm: (json['column_widths_cm'] as List<dynamic>)
          .map((e) => (e as num).toDouble())
          .toList(),
      rows: (json['rows'] as num).toInt(),
      avgRowHeightCm: (json['avg_row_height_cm'] as num).toDouble(),
      tableX: (json['table_x'] as num).toDouble(),
      tableY: (json['table_y'] as num).toDouble(),
      cellTexts: (json['cell_texts'] as List<dynamic>)
          .map((e) => (e as List<dynamic>).map((e) => e as String).toList())
          .toList(),
    );

Map<String, dynamic> _$$ScanPropertiesDtoImplToJson(
        _$ScanPropertiesDtoImpl instance) =>
    <String, dynamic>{
      'uuid': instance.uuid,
      'column_widths_cm': instance.columnWidthsCm,
      'rows': instance.rows,
      'avg_row_height_cm': instance.avgRowHeightCm,
      'table_x': instance.tableX,
      'table_y': instance.tableY,
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
