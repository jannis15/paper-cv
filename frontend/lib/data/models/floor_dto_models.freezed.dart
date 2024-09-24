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
  String get uuid => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get modifiedAt => throw _privateConstructorUsedError;

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
      {String uuid, String title, DateTime createdAt, DateTime modifiedAt});
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
    Object? uuid = null,
    Object? title = null,
    Object? createdAt = null,
    Object? modifiedAt = null,
  }) {
    return _then(_value.copyWith(
      uuid: null == uuid
          ? _value.uuid
          : uuid // ignore: cast_nullable_to_non_nullable
              as String,
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
      {String uuid, String title, DateTime createdAt, DateTime modifiedAt});
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
    Object? uuid = null,
    Object? title = null,
    Object? createdAt = null,
    Object? modifiedAt = null,
  }) {
    return _then(_$DocumentPreviewDtoImpl(
      uuid: null == uuid
          ? _value.uuid
          : uuid // ignore: cast_nullable_to_non_nullable
              as String,
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
    ));
  }
}

/// @nodoc

class _$DocumentPreviewDtoImpl implements _DocumentPreviewDto {
  const _$DocumentPreviewDtoImpl(
      {required this.uuid,
      required this.title,
      required this.createdAt,
      required this.modifiedAt});

  @override
  final String uuid;
  @override
  final String title;
  @override
  final DateTime createdAt;
  @override
  final DateTime modifiedAt;

  @override
  String toString() {
    return 'DocumentPreviewDto(uuid: $uuid, title: $title, createdAt: $createdAt, modifiedAt: $modifiedAt)';
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
                other.modifiedAt == modifiedAt));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, uuid, title, createdAt, modifiedAt);

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
      {required final String uuid,
      required final String title,
      required final DateTime createdAt,
      required final DateTime modifiedAt}) = _$DocumentPreviewDtoImpl;

  @override
  String get uuid;
  @override
  String get title;
  @override
  DateTime get createdAt;
  @override
  DateTime get modifiedAt;

  /// Create a copy of DocumentPreviewDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DocumentPreviewDtoImplCopyWith<_$DocumentPreviewDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
