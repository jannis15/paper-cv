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
      {String? uuid, String title, DateTime createdAt, DateTime modifiedAt});
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
      {String? uuid, String title, DateTime createdAt, DateTime modifiedAt});
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
  final String? uuid;
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
      {required final String? uuid,
      required final String title,
      required final DateTime createdAt,
      required final DateTime modifiedAt}) = _$DocumentPreviewDtoImpl;

  @override
  String? get uuid;
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

/// @nodoc
mixin _$FileDto {
  String? get uuid => throw _privateConstructorUsedError;
  String? get refUuid => throw _privateConstructorUsedError;
  String get filename => throw _privateConstructorUsedError;
  Uint8List get data => throw _privateConstructorUsedError;
  int? get index => throw _privateConstructorUsedError;
  FileType get fileType => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get modifiedAt => throw _privateConstructorUsedError;

  /// Create a copy of FileDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FileDtoCopyWith<FileDto> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FileDtoCopyWith<$Res> {
  factory $FileDtoCopyWith(FileDto value, $Res Function(FileDto) then) =
      _$FileDtoCopyWithImpl<$Res, FileDto>;
  @useResult
  $Res call(
      {String? uuid,
      String? refUuid,
      String filename,
      Uint8List data,
      int? index,
      FileType fileType,
      DateTime createdAt,
      DateTime modifiedAt});
}

/// @nodoc
class _$FileDtoCopyWithImpl<$Res, $Val extends FileDto>
    implements $FileDtoCopyWith<$Res> {
  _$FileDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FileDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uuid = freezed,
    Object? refUuid = freezed,
    Object? filename = null,
    Object? data = null,
    Object? index = freezed,
    Object? fileType = null,
    Object? createdAt = null,
    Object? modifiedAt = null,
  }) {
    return _then(_value.copyWith(
      uuid: freezed == uuid
          ? _value.uuid
          : uuid // ignore: cast_nullable_to_non_nullable
              as String?,
      refUuid: freezed == refUuid
          ? _value.refUuid
          : refUuid // ignore: cast_nullable_to_non_nullable
              as String?,
      filename: null == filename
          ? _value.filename
          : filename // ignore: cast_nullable_to_non_nullable
              as String,
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as Uint8List,
      index: freezed == index
          ? _value.index
          : index // ignore: cast_nullable_to_non_nullable
              as int?,
      fileType: null == fileType
          ? _value.fileType
          : fileType // ignore: cast_nullable_to_non_nullable
              as FileType,
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
abstract class _$$FileDtoImplCopyWith<$Res> implements $FileDtoCopyWith<$Res> {
  factory _$$FileDtoImplCopyWith(
          _$FileDtoImpl value, $Res Function(_$FileDtoImpl) then) =
      __$$FileDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? uuid,
      String? refUuid,
      String filename,
      Uint8List data,
      int? index,
      FileType fileType,
      DateTime createdAt,
      DateTime modifiedAt});
}

/// @nodoc
class __$$FileDtoImplCopyWithImpl<$Res>
    extends _$FileDtoCopyWithImpl<$Res, _$FileDtoImpl>
    implements _$$FileDtoImplCopyWith<$Res> {
  __$$FileDtoImplCopyWithImpl(
      _$FileDtoImpl _value, $Res Function(_$FileDtoImpl) _then)
      : super(_value, _then);

  /// Create a copy of FileDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uuid = freezed,
    Object? refUuid = freezed,
    Object? filename = null,
    Object? data = null,
    Object? index = freezed,
    Object? fileType = null,
    Object? createdAt = null,
    Object? modifiedAt = null,
  }) {
    return _then(_$FileDtoImpl(
      uuid: freezed == uuid
          ? _value.uuid
          : uuid // ignore: cast_nullable_to_non_nullable
              as String?,
      refUuid: freezed == refUuid
          ? _value.refUuid
          : refUuid // ignore: cast_nullable_to_non_nullable
              as String?,
      filename: null == filename
          ? _value.filename
          : filename // ignore: cast_nullable_to_non_nullable
              as String,
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as Uint8List,
      index: freezed == index
          ? _value.index
          : index // ignore: cast_nullable_to_non_nullable
              as int?,
      fileType: null == fileType
          ? _value.fileType
          : fileType // ignore: cast_nullable_to_non_nullable
              as FileType,
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

class _$FileDtoImpl implements _FileDto {
  const _$FileDtoImpl(
      {required this.uuid,
      required this.refUuid,
      required this.filename,
      required this.data,
      required this.index,
      required this.fileType,
      required this.createdAt,
      required this.modifiedAt});

  @override
  final String? uuid;
  @override
  final String? refUuid;
  @override
  final String filename;
  @override
  final Uint8List data;
  @override
  final int? index;
  @override
  final FileType fileType;
  @override
  final DateTime createdAt;
  @override
  final DateTime modifiedAt;

  @override
  String toString() {
    return 'FileDto(uuid: $uuid, refUuid: $refUuid, filename: $filename, data: $data, index: $index, fileType: $fileType, createdAt: $createdAt, modifiedAt: $modifiedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FileDtoImpl &&
            (identical(other.uuid, uuid) || other.uuid == uuid) &&
            (identical(other.refUuid, refUuid) || other.refUuid == refUuid) &&
            (identical(other.filename, filename) ||
                other.filename == filename) &&
            const DeepCollectionEquality().equals(other.data, data) &&
            (identical(other.index, index) || other.index == index) &&
            (identical(other.fileType, fileType) ||
                other.fileType == fileType) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.modifiedAt, modifiedAt) ||
                other.modifiedAt == modifiedAt));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      uuid,
      refUuid,
      filename,
      const DeepCollectionEquality().hash(data),
      index,
      fileType,
      createdAt,
      modifiedAt);

  /// Create a copy of FileDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FileDtoImplCopyWith<_$FileDtoImpl> get copyWith =>
      __$$FileDtoImplCopyWithImpl<_$FileDtoImpl>(this, _$identity);
}

abstract class _FileDto implements FileDto {
  const factory _FileDto(
      {required final String? uuid,
      required final String? refUuid,
      required final String filename,
      required final Uint8List data,
      required final int? index,
      required final FileType fileType,
      required final DateTime createdAt,
      required final DateTime modifiedAt}) = _$FileDtoImpl;

  @override
  String? get uuid;
  @override
  String? get refUuid;
  @override
  String get filename;
  @override
  Uint8List get data;
  @override
  int? get index;
  @override
  FileType get fileType;
  @override
  DateTime get createdAt;
  @override
  DateTime get modifiedAt;

  /// Create a copy of FileDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FileDtoImplCopyWith<_$FileDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
