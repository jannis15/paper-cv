// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'floor_dto_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ScanPropertiesDtoImpl _$$ScanPropertiesDtoImplFromJson(
        Map<String, dynamic> json) =>
    _$ScanPropertiesDtoImpl(
      uuid: json['uuid'] as String?,
      columnWidths: (json['column_widths'] as List<dynamic>)
          .map((e) => (e as num).toDouble())
          .toList(),
      rows: (json['rows'] as num).toInt(),
      avgRowHeight: (json['avg_row_height'] as num).toDouble(),
      cellTexts: (json['cell_texts'] as List<dynamic>)
          .map((e) => (e as List<dynamic>).map((e) => e as String).toList())
          .toList(),
    );

Map<String, dynamic> _$$ScanPropertiesDtoImplToJson(
        _$ScanPropertiesDtoImpl instance) =>
    <String, dynamic>{
      'uuid': instance.uuid,
      'column_widths': instance.columnWidths,
      'rows': instance.rows,
      'avg_row_height': instance.avgRowHeight,
      'cell_texts': instance.cellTexts,
    };
