// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'floor_dto_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$DocumentPreviewDto {
  String? get uuid => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get modifiedAt => throw _privateConstructorUsedError;
  bool get isExample => throw _privateConstructorUsedError;

  /// Create a copy of DocumentPreviewDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DocumentPreviewDtoCopyWith<DocumentPreviewDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DocumentPreviewDtoCopyWith<$Res> {
  factory $DocumentPreviewDtoCopyWith(
          DocumentPreviewDto value, $Res Function(DocumentPreviewDto) then) =
      _$DocumentPreviewDtoCopyWithImpl<$Res, DocumentPreviewDto>;
  @useResult
  $Res call(
      {String? uuid,
      String title,
      DateTime createdAt,
      DateTime modifiedAt,
      bool isExample});
}

/// @nodoc
class _$DocumentPreviewDtoCopyWithImpl<$Res, $Val extends DocumentPreviewDto>
    implements $DocumentPreviewDtoCopyWith<$Res> {
  _$DocumentPreviewDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DocumentPreviewDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uuid = freezed,
    Object? title = null,
    Object? createdAt = null,
    Object? modifiedAt = null,
    Object? isExample = null,
  }) {
    return _then(_value.copyWith(
      uuid: freezed == uuid
          ? _value.uuid
          : uuid // ignore: cast_nullable_to_non_nullable
              as String?,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      modifiedAt: null == modifiedAt
          ? _value.modifiedAt
          : modifiedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isExample: null == isExample
          ? _value.isExample
          : isExample // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DocumentPreviewDtoImplCopyWith<$Res>
    implements $DocumentPreviewDtoCopyWith<$Res> {
  factory _$$DocumentPreviewDtoImplCopyWith(_$DocumentPreviewDtoImpl value,
          $Res Function(_$DocumentPreviewDtoImpl) then) =
      __$$DocumentPreviewDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? uuid,
      String title,
      DateTime createdAt,
      DateTime modifiedAt,
      bool isExample});
}

/// @nodoc
class __$$DocumentPreviewDtoImplCopyWithImpl<$Res>
    extends _$DocumentPreviewDtoCopyWithImpl<$Res, _$DocumentPreviewDtoImpl>
    implements _$$DocumentPreviewDtoImplCopyWith<$Res> {
  __$$DocumentPreviewDtoImplCopyWithImpl(_$DocumentPreviewDtoImpl _value,
      $Res Function(_$DocumentPreviewDtoImpl) _then)
      : super(_value, _then);

  /// Create a copy of DocumentPreviewDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uuid = freezed,
    Object? title = null,
    Object? createdAt = null,
    Object? modifiedAt = null,
    Object? isExample = null,
  }) {
    return _then(_$DocumentPreviewDtoImpl(
      uuid: freezed == uuid
          ? _value.uuid
          : uuid // ignore: cast_nullable_to_non_nullable
              as String?,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      modifiedAt: null == modifiedAt
          ? _value.modifiedAt
          : modifiedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isExample: null == isExample
          ? _value.isExample
          : isExample // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$DocumentPreviewDtoImpl implements _DocumentPreviewDto {
  const _$DocumentPreviewDtoImpl(
      {required this.uuid,
      required this.title,
      required this.createdAt,
      required this.modifiedAt,
      required this.isExample});

  @override
  final String? uuid;
  @override
  final String title;
  @override
  final DateTime createdAt;
  @override
  final DateTime modifiedAt;
  @override
  final bool isExample;

  @override
  String toString() {
    return 'DocumentPreviewDto(uuid: $uuid, title: $title, createdAt: $createdAt, modifiedAt: $modifiedAt, isExample: $isExample)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DocumentPreviewDtoImpl &&
            (identical(other.uuid, uuid) || other.uuid == uuid) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.modifiedAt, modifiedAt) ||
                other.modifiedAt == modifiedAt) &&
            (identical(other.isExample, isExample) ||
                other.isExample == isExample));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, uuid, title, createdAt, modifiedAt, isExample);

  /// Create a copy of DocumentPreviewDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DocumentPreviewDtoImplCopyWith<_$DocumentPreviewDtoImpl> get copyWith =>
      __$$DocumentPreviewDtoImplCopyWithImpl<_$DocumentPreviewDtoImpl>(
          this, _$identity);
}

abstract class _DocumentPreviewDto implements DocumentPreviewDto {
  const factory _DocumentPreviewDto(
      {required final String? uuid,
      required final String title,
      required final DateTime createdAt,
      required final DateTime modifiedAt,
      required final bool isExample}) = _$DocumentPreviewDtoImpl;

  @override
  String? get uuid;
  @override
  String get title;
  @override
  DateTime get createdAt;
  @override
  DateTime get modifiedAt;
  @override
  bool get isExample;

  /// Create a copy of DocumentPreviewDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DocumentPreviewDtoImplCopyWith<_$DocumentPreviewDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ScanPropertiesDto _$ScanPropertiesDtoFromJson(Map<String, dynamic> json) {
  return _ScanPropertiesDto.fromJson(json);
}

/// @nodoc
mixin _$ScanPropertiesDto {
  String? get uuid => throw _privateConstructorUsedError;
  @JsonKey(name: 'column_widths_cm')
  List<double> get columnWidthsCm => throw _privateConstructorUsedError;
  @JsonKey(name: 'rows')
  int get rows => throw _privateConstructorUsedError;
  @JsonKey(name: 'avg_row_height_cm')
  double get avgRowHeightCm => throw _privateConstructorUsedError;
  @JsonKey(name: 'table_x')
  double get tableX => throw _privateConstructorUsedError;
  @JsonKey(name: 'table_y')
  double get tableY => throw _privateConstructorUsedError;
  @JsonKey(name: 'cell_texts')
  List<List<String>> get cellTexts => throw _privateConstructorUsedError;

  /// Serializes this ScanPropertiesDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ScanPropertiesDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ScanPropertiesDtoCopyWith<ScanPropertiesDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ScanPropertiesDtoCopyWith<$Res> {
  factory $ScanPropertiesDtoCopyWith(
          ScanPropertiesDto value, $Res Function(ScanPropertiesDto) then) =
      _$ScanPropertiesDtoCopyWithImpl<$Res, ScanPropertiesDto>;
  @useResult
  $Res call(
      {String? uuid,
      @JsonKey(name: 'column_widths_cm') List<double> columnWidthsCm,
      @JsonKey(name: 'rows') int rows,
      @JsonKey(name: 'avg_row_height_cm') double avgRowHeightCm,
      @JsonKey(name: 'table_x') double tableX,
      @JsonKey(name: 'table_y') double tableY,
      @JsonKey(name: 'cell_texts') List<List<String>> cellTexts});
}

/// @nodoc
class _$ScanPropertiesDtoCopyWithImpl<$Res, $Val extends ScanPropertiesDto>
    implements $ScanPropertiesDtoCopyWith<$Res> {
  _$ScanPropertiesDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ScanPropertiesDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uuid = freezed,
    Object? columnWidthsCm = null,
    Object? rows = null,
    Object? avgRowHeightCm = null,
    Object? tableX = null,
    Object? tableY = null,
    Object? cellTexts = null,
  }) {
    return _then(_value.copyWith(
      uuid: freezed == uuid
          ? _value.uuid
          : uuid // ignore: cast_nullable_to_non_nullable
              as String?,
      columnWidthsCm: null == columnWidthsCm
          ? _value.columnWidthsCm
          : columnWidthsCm // ignore: cast_nullable_to_non_nullable
              as List<double>,
      rows: null == rows
          ? _value.rows
          : rows // ignore: cast_nullable_to_non_nullable
              as int,
      avgRowHeightCm: null == avgRowHeightCm
          ? _value.avgRowHeightCm
          : avgRowHeightCm // ignore: cast_nullable_to_non_nullable
              as double,
      tableX: null == tableX
          ? _value.tableX
          : tableX // ignore: cast_nullable_to_non_nullable
              as double,
      tableY: null == tableY
          ? _value.tableY
          : tableY // ignore: cast_nullable_to_non_nullable
              as double,
      cellTexts: null == cellTexts
          ? _value.cellTexts
          : cellTexts // ignore: cast_nullable_to_non_nullable
              as List<List<String>>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ScanPropertiesDtoImplCopyWith<$Res>
    implements $ScanPropertiesDtoCopyWith<$Res> {
  factory _$$ScanPropertiesDtoImplCopyWith(_$ScanPropertiesDtoImpl value,
          $Res Function(_$ScanPropertiesDtoImpl) then) =
      __$$ScanPropertiesDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? uuid,
      @JsonKey(name: 'column_widths_cm') List<double> columnWidthsCm,
      @JsonKey(name: 'rows') int rows,
      @JsonKey(name: 'avg_row_height_cm') double avgRowHeightCm,
      @JsonKey(name: 'table_x') double tableX,
      @JsonKey(name: 'table_y') double tableY,
      @JsonKey(name: 'cell_texts') List<List<String>> cellTexts});
}

/// @nodoc
class __$$ScanPropertiesDtoImplCopyWithImpl<$Res>
    extends _$ScanPropertiesDtoCopyWithImpl<$Res, _$ScanPropertiesDtoImpl>
    implements _$$ScanPropertiesDtoImplCopyWith<$Res> {
  __$$ScanPropertiesDtoImplCopyWithImpl(_$ScanPropertiesDtoImpl _value,
      $Res Function(_$ScanPropertiesDtoImpl) _then)
      : super(_value, _then);

  /// Create a copy of ScanPropertiesDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uuid = freezed,
    Object? columnWidthsCm = null,
    Object? rows = null,
    Object? avgRowHeightCm = null,
    Object? tableX = null,
    Object? tableY = null,
    Object? cellTexts = null,
  }) {
    return _then(_$ScanPropertiesDtoImpl(
      uuid: freezed == uuid
          ? _value.uuid
          : uuid // ignore: cast_nullable_to_non_nullable
              as String?,
      columnWidthsCm: null == columnWidthsCm
          ? _value._columnWidthsCm
          : columnWidthsCm // ignore: cast_nullable_to_non_nullable
              as List<double>,
      rows: null == rows
          ? _value.rows
          : rows // ignore: cast_nullable_to_non_nullable
              as int,
      avgRowHeightCm: null == avgRowHeightCm
          ? _value.avgRowHeightCm
          : avgRowHeightCm // ignore: cast_nullable_to_non_nullable
              as double,
      tableX: null == tableX
          ? _value.tableX
          : tableX // ignore: cast_nullable_to_non_nullable
              as double,
      tableY: null == tableY
          ? _value.tableY
          : tableY // ignore: cast_nullable_to_non_nullable
              as double,
      cellTexts: null == cellTexts
          ? _value._cellTexts
          : cellTexts // ignore: cast_nullable_to_non_nullable
              as List<List<String>>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ScanPropertiesDtoImpl extends _ScanPropertiesDto {
  _$ScanPropertiesDtoImpl(
      {this.uuid,
      @JsonKey(name: 'column_widths_cm')
      required final List<double> columnWidthsCm,
      @JsonKey(name: 'rows') required this.rows,
      @JsonKey(name: 'avg_row_height_cm') required this.avgRowHeightCm,
      @JsonKey(name: 'table_x') required this.tableX,
      @JsonKey(name: 'table_y') required this.tableY,
      @JsonKey(name: 'cell_texts') required final List<List<String>> cellTexts})
      : _columnWidthsCm = columnWidthsCm,
        _cellTexts = cellTexts,
        super._();

  factory _$ScanPropertiesDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$ScanPropertiesDtoImplFromJson(json);

  @override
  final String? uuid;
  final List<double> _columnWidthsCm;
  @override
  @JsonKey(name: 'column_widths_cm')
  List<double> get columnWidthsCm {
    if (_columnWidthsCm is EqualUnmodifiableListView) return _columnWidthsCm;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_columnWidthsCm);
  }

  @override
  @JsonKey(name: 'rows')
  final int rows;
  @override
  @JsonKey(name: 'avg_row_height_cm')
  final double avgRowHeightCm;
  @override
  @JsonKey(name: 'table_x')
  final double tableX;
  @override
  @JsonKey(name: 'table_y')
  final double tableY;
  final List<List<String>> _cellTexts;
  @override
  @JsonKey(name: 'cell_texts')
  List<List<String>> get cellTexts {
    if (_cellTexts is EqualUnmodifiableListView) return _cellTexts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_cellTexts);
  }

  @override
  String toString() {
    return 'ScanPropertiesDto(uuid: $uuid, columnWidthsCm: $columnWidthsCm, rows: $rows, avgRowHeightCm: $avgRowHeightCm, tableX: $tableX, tableY: $tableY, cellTexts: $cellTexts)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ScanPropertiesDtoImpl &&
            (identical(other.uuid, uuid) || other.uuid == uuid) &&
            const DeepCollectionEquality()
                .equals(other._columnWidthsCm, _columnWidthsCm) &&
            (identical(other.rows, rows) || other.rows == rows) &&
            (identical(other.avgRowHeightCm, avgRowHeightCm) ||
                other.avgRowHeightCm == avgRowHeightCm) &&
            (identical(other.tableX, tableX) || other.tableX == tableX) &&
            (identical(other.tableY, tableY) || other.tableY == tableY) &&
            const DeepCollectionEquality()
                .equals(other._cellTexts, _cellTexts));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      uuid,
      const DeepCollectionEquality().hash(_columnWidthsCm),
      rows,
      avgRowHeightCm,
      tableX,
      tableY,
      const DeepCollectionEquality().hash(_cellTexts));

  /// Create a copy of ScanPropertiesDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ScanPropertiesDtoImplCopyWith<_$ScanPropertiesDtoImpl> get copyWith =>
      __$$ScanPropertiesDtoImplCopyWithImpl<_$ScanPropertiesDtoImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ScanPropertiesDtoImplToJson(
      this,
    );
  }
}

abstract class _ScanPropertiesDto extends ScanPropertiesDto {
  factory _ScanPropertiesDto(
      {final String? uuid,
      @JsonKey(name: 'column_widths_cm')
      required final List<double> columnWidthsCm,
      @JsonKey(name: 'rows') required final int rows,
      @JsonKey(name: 'avg_row_height_cm') required final double avgRowHeightCm,
      @JsonKey(name: 'table_x') required final double tableX,
      @JsonKey(name: 'table_y') required final double tableY,
      @JsonKey(name: 'cell_texts')
      required final List<List<String>> cellTexts}) = _$ScanPropertiesDtoImpl;
  _ScanPropertiesDto._() : super._();

  factory _ScanPropertiesDto.fromJson(Map<String, dynamic> json) =
      _$ScanPropertiesDtoImpl.fromJson;

  @override
  String? get uuid;
  @override
  @JsonKey(name: 'column_widths_cm')
  List<double> get columnWidthsCm;
  @override
  @JsonKey(name: 'rows')
  int get rows;
  @override
  @JsonKey(name: 'avg_row_height_cm')
  double get avgRowHeightCm;
  @override
  @JsonKey(name: 'table_x')
  double get tableX;
  @override
  @JsonKey(name: 'table_y')
  double get tableY;
  @override
  @JsonKey(name: 'cell_texts')
  List<List<String>> get cellTexts;

  /// Create a copy of ScanPropertiesDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ScanPropertiesDtoImplCopyWith<_$ScanPropertiesDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SelectionDto _$SelectionDtoFromJson(Map<String, dynamic> json) {
  return _SelectionDto.fromJson(json);
}

/// @nodoc
mixin _$SelectionDto {
  double get x1 => throw _privateConstructorUsedError;
  double get y1 => throw _privateConstructorUsedError;
  double get x2 => throw _privateConstructorUsedError;
  double get y2 => throw _privateConstructorUsedError;

  /// Serializes this SelectionDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SelectionDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SelectionDtoCopyWith<SelectionDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SelectionDtoCopyWith<$Res> {
  factory $SelectionDtoCopyWith(
          SelectionDto value, $Res Function(SelectionDto) then) =
      _$SelectionDtoCopyWithImpl<$Res, SelectionDto>;
  @useResult
  $Res call({double x1, double y1, double x2, double y2});
}

/// @nodoc
class _$SelectionDtoCopyWithImpl<$Res, $Val extends SelectionDto>
    implements $SelectionDtoCopyWith<$Res> {
  _$SelectionDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SelectionDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? x1 = null,
    Object? y1 = null,
    Object? x2 = null,
    Object? y2 = null,
  }) {
    return _then(_value.copyWith(
      x1: null == x1
          ? _value.x1
          : x1 // ignore: cast_nullable_to_non_nullable
              as double,
      y1: null == y1
          ? _value.y1
          : y1 // ignore: cast_nullable_to_non_nullable
              as double,
      x2: null == x2
          ? _value.x2
          : x2 // ignore: cast_nullable_to_non_nullable
              as double,
      y2: null == y2
          ? _value.y2
          : y2 // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SelectionDtoImplCopyWith<$Res>
    implements $SelectionDtoCopyWith<$Res> {
  factory _$$SelectionDtoImplCopyWith(
          _$SelectionDtoImpl value, $Res Function(_$SelectionDtoImpl) then) =
      __$$SelectionDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double x1, double y1, double x2, double y2});
}

/// @nodoc
class __$$SelectionDtoImplCopyWithImpl<$Res>
    extends _$SelectionDtoCopyWithImpl<$Res, _$SelectionDtoImpl>
    implements _$$SelectionDtoImplCopyWith<$Res> {
  __$$SelectionDtoImplCopyWithImpl(
      _$SelectionDtoImpl _value, $Res Function(_$SelectionDtoImpl) _then)
      : super(_value, _then);

  /// Create a copy of SelectionDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? x1 = null,
    Object? y1 = null,
    Object? x2 = null,
    Object? y2 = null,
  }) {
    return _then(_$SelectionDtoImpl(
      x1: null == x1
          ? _value.x1
          : x1 // ignore: cast_nullable_to_non_nullable
              as double,
      y1: null == y1
          ? _value.y1
          : y1 // ignore: cast_nullable_to_non_nullable
              as double,
      x2: null == x2
          ? _value.x2
          : x2 // ignore: cast_nullable_to_non_nullable
              as double,
      y2: null == y2
          ? _value.y2
          : y2 // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SelectionDtoImpl extends _SelectionDto {
  _$SelectionDtoImpl(
      {required this.x1, required this.y1, required this.x2, required this.y2})
      : super._();

  factory _$SelectionDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$SelectionDtoImplFromJson(json);

  @override
  final double x1;
  @override
  final double y1;
  @override
  final double x2;
  @override
  final double y2;

  @override
  String toString() {
    return 'SelectionDto(x1: $x1, y1: $y1, x2: $x2, y2: $y2)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SelectionDtoImpl &&
            (identical(other.x1, x1) || other.x1 == x1) &&
            (identical(other.y1, y1) || other.y1 == y1) &&
            (identical(other.x2, x2) || other.x2 == x2) &&
            (identical(other.y2, y2) || other.y2 == y2));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, x1, y1, x2, y2);

  /// Create a copy of SelectionDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SelectionDtoImplCopyWith<_$SelectionDtoImpl> get copyWith =>
      __$$SelectionDtoImplCopyWithImpl<_$SelectionDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SelectionDtoImplToJson(
      this,
    );
  }
}

abstract class _SelectionDto extends SelectionDto {
  factory _SelectionDto(
      {required final double x1,
      required final double y1,
      required final double x2,
      required final double y2}) = _$SelectionDtoImpl;
  _SelectionDto._() : super._();

  factory _SelectionDto.fromJson(Map<String, dynamic> json) =
      _$SelectionDtoImpl.fromJson;

  @override
  double get x1;
  @override
  double get y1;
  @override
  double get x2;
  @override
  double get y2;

  /// Create a copy of SelectionDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SelectionDtoImplCopyWith<_$SelectionDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
