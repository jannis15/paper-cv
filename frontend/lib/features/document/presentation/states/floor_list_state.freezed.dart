// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'floor_list_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$FloorListState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            List<DocumentPreviewDto> documentPreviews,
            bool isSelectionMode,
            Set<DocumentPreviewDto> selectedDocuments,
            DocumentViewType documentViewType,
            DocumentSortType sortType,
            SortDirection sortDirection)
        data,
    required TResult Function(Object? error) error,
    required TResult Function() loading,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            List<DocumentPreviewDto> documentPreviews,
            bool isSelectionMode,
            Set<DocumentPreviewDto> selectedDocuments,
            DocumentViewType documentViewType,
            DocumentSortType sortType,
            SortDirection sortDirection)?
        data,
    TResult? Function(Object? error)? error,
    TResult? Function()? loading,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            List<DocumentPreviewDto> documentPreviews,
            bool isSelectionMode,
            Set<DocumentPreviewDto> selectedDocuments,
            DocumentViewType documentViewType,
            DocumentSortType sortType,
            SortDirection sortDirection)?
        data,
    TResult Function(Object? error)? error,
    TResult Function()? loading,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FloorListStateData value) data,
    required TResult Function(FloorListStateError value) error,
    required TResult Function(FloorListStateLoading value) loading,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FloorListStateData value)? data,
    TResult? Function(FloorListStateError value)? error,
    TResult? Function(FloorListStateLoading value)? loading,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FloorListStateData value)? data,
    TResult Function(FloorListStateError value)? error,
    TResult Function(FloorListStateLoading value)? loading,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FloorListStateCopyWith<$Res> {
  factory $FloorListStateCopyWith(
          FloorListState value, $Res Function(FloorListState) then) =
      _$FloorListStateCopyWithImpl<$Res, FloorListState>;
}

/// @nodoc
class _$FloorListStateCopyWithImpl<$Res, $Val extends FloorListState>
    implements $FloorListStateCopyWith<$Res> {
  _$FloorListStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FloorListState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$FloorListStateDataImplCopyWith<$Res> {
  factory _$$FloorListStateDataImplCopyWith(_$FloorListStateDataImpl value,
          $Res Function(_$FloorListStateDataImpl) then) =
      __$$FloorListStateDataImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {List<DocumentPreviewDto> documentPreviews,
      bool isSelectionMode,
      Set<DocumentPreviewDto> selectedDocuments,
      DocumentViewType documentViewType,
      DocumentSortType sortType,
      SortDirection sortDirection});
}

/// @nodoc
class __$$FloorListStateDataImplCopyWithImpl<$Res>
    extends _$FloorListStateCopyWithImpl<$Res, _$FloorListStateDataImpl>
    implements _$$FloorListStateDataImplCopyWith<$Res> {
  __$$FloorListStateDataImplCopyWithImpl(_$FloorListStateDataImpl _value,
      $Res Function(_$FloorListStateDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of FloorListState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? documentPreviews = null,
    Object? isSelectionMode = null,
    Object? selectedDocuments = null,
    Object? documentViewType = null,
    Object? sortType = null,
    Object? sortDirection = null,
  }) {
    return _then(_$FloorListStateDataImpl(
      documentPreviews: null == documentPreviews
          ? _value._documentPreviews
          : documentPreviews // ignore: cast_nullable_to_non_nullable
              as List<DocumentPreviewDto>,
      isSelectionMode: null == isSelectionMode
          ? _value.isSelectionMode
          : isSelectionMode // ignore: cast_nullable_to_non_nullable
              as bool,
      selectedDocuments: null == selectedDocuments
          ? _value._selectedDocuments
          : selectedDocuments // ignore: cast_nullable_to_non_nullable
              as Set<DocumentPreviewDto>,
      documentViewType: null == documentViewType
          ? _value.documentViewType
          : documentViewType // ignore: cast_nullable_to_non_nullable
              as DocumentViewType,
      sortType: null == sortType
          ? _value.sortType
          : sortType // ignore: cast_nullable_to_non_nullable
              as DocumentSortType,
      sortDirection: null == sortDirection
          ? _value.sortDirection
          : sortDirection // ignore: cast_nullable_to_non_nullable
              as SortDirection,
    ));
  }
}

/// @nodoc

class _$FloorListStateDataImpl extends FloorListStateData {
  const _$FloorListStateDataImpl(
      {required final List<DocumentPreviewDto> documentPreviews,
      this.isSelectionMode = false,
      final Set<DocumentPreviewDto> selectedDocuments = const {},
      this.documentViewType = DocumentViewType.grid,
      this.sortType = DocumentSortType.documentDate,
      this.sortDirection = SortDirection.descending})
      : _documentPreviews = documentPreviews,
        _selectedDocuments = selectedDocuments,
        super._();

  final List<DocumentPreviewDto> _documentPreviews;
  @override
  List<DocumentPreviewDto> get documentPreviews {
    if (_documentPreviews is EqualUnmodifiableListView)
      return _documentPreviews;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_documentPreviews);
  }

  @override
  @JsonKey()
  final bool isSelectionMode;
  final Set<DocumentPreviewDto> _selectedDocuments;
  @override
  @JsonKey()
  Set<DocumentPreviewDto> get selectedDocuments {
    if (_selectedDocuments is EqualUnmodifiableSetView)
      return _selectedDocuments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_selectedDocuments);
  }

  @override
  @JsonKey()
  final DocumentViewType documentViewType;
  @override
  @JsonKey()
  final DocumentSortType sortType;
  @override
  @JsonKey()
  final SortDirection sortDirection;

  @override
  String toString() {
    return 'FloorListState.data(documentPreviews: $documentPreviews, isSelectionMode: $isSelectionMode, selectedDocuments: $selectedDocuments, documentViewType: $documentViewType, sortType: $sortType, sortDirection: $sortDirection)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FloorListStateDataImpl &&
            const DeepCollectionEquality()
                .equals(other._documentPreviews, _documentPreviews) &&
            (identical(other.isSelectionMode, isSelectionMode) ||
                other.isSelectionMode == isSelectionMode) &&
            const DeepCollectionEquality()
                .equals(other._selectedDocuments, _selectedDocuments) &&
            (identical(other.documentViewType, documentViewType) ||
                other.documentViewType == documentViewType) &&
            (identical(other.sortType, sortType) ||
                other.sortType == sortType) &&
            (identical(other.sortDirection, sortDirection) ||
                other.sortDirection == sortDirection));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_documentPreviews),
      isSelectionMode,
      const DeepCollectionEquality().hash(_selectedDocuments),
      documentViewType,
      sortType,
      sortDirection);

  /// Create a copy of FloorListState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FloorListStateDataImplCopyWith<_$FloorListStateDataImpl> get copyWith =>
      __$$FloorListStateDataImplCopyWithImpl<_$FloorListStateDataImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            List<DocumentPreviewDto> documentPreviews,
            bool isSelectionMode,
            Set<DocumentPreviewDto> selectedDocuments,
            DocumentViewType documentViewType,
            DocumentSortType sortType,
            SortDirection sortDirection)
        data,
    required TResult Function(Object? error) error,
    required TResult Function() loading,
  }) {
    return data(documentPreviews, isSelectionMode, selectedDocuments,
        documentViewType, sortType, sortDirection);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            List<DocumentPreviewDto> documentPreviews,
            bool isSelectionMode,
            Set<DocumentPreviewDto> selectedDocuments,
            DocumentViewType documentViewType,
            DocumentSortType sortType,
            SortDirection sortDirection)?
        data,
    TResult? Function(Object? error)? error,
    TResult? Function()? loading,
  }) {
    return data?.call(documentPreviews, isSelectionMode, selectedDocuments,
        documentViewType, sortType, sortDirection);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            List<DocumentPreviewDto> documentPreviews,
            bool isSelectionMode,
            Set<DocumentPreviewDto> selectedDocuments,
            DocumentViewType documentViewType,
            DocumentSortType sortType,
            SortDirection sortDirection)?
        data,
    TResult Function(Object? error)? error,
    TResult Function()? loading,
    required TResult orElse(),
  }) {
    if (data != null) {
      return data(documentPreviews, isSelectionMode, selectedDocuments,
          documentViewType, sortType, sortDirection);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FloorListStateData value) data,
    required TResult Function(FloorListStateError value) error,
    required TResult Function(FloorListStateLoading value) loading,
  }) {
    return data(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FloorListStateData value)? data,
    TResult? Function(FloorListStateError value)? error,
    TResult? Function(FloorListStateLoading value)? loading,
  }) {
    return data?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FloorListStateData value)? data,
    TResult Function(FloorListStateError value)? error,
    TResult Function(FloorListStateLoading value)? loading,
    required TResult orElse(),
  }) {
    if (data != null) {
      return data(this);
    }
    return orElse();
  }
}

abstract class FloorListStateData extends FloorListState {
  const factory FloorListStateData(
      {required final List<DocumentPreviewDto> documentPreviews,
      final bool isSelectionMode,
      final Set<DocumentPreviewDto> selectedDocuments,
      final DocumentViewType documentViewType,
      final DocumentSortType sortType,
      final SortDirection sortDirection}) = _$FloorListStateDataImpl;
  const FloorListStateData._() : super._();

  List<DocumentPreviewDto> get documentPreviews;
  bool get isSelectionMode;
  Set<DocumentPreviewDto> get selectedDocuments;
  DocumentViewType get documentViewType;
  DocumentSortType get sortType;
  SortDirection get sortDirection;

  /// Create a copy of FloorListState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FloorListStateDataImplCopyWith<_$FloorListStateDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$FloorListStateErrorImplCopyWith<$Res> {
  factory _$$FloorListStateErrorImplCopyWith(_$FloorListStateErrorImpl value,
          $Res Function(_$FloorListStateErrorImpl) then) =
      __$$FloorListStateErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Object? error});
}

/// @nodoc
class __$$FloorListStateErrorImplCopyWithImpl<$Res>
    extends _$FloorListStateCopyWithImpl<$Res, _$FloorListStateErrorImpl>
    implements _$$FloorListStateErrorImplCopyWith<$Res> {
  __$$FloorListStateErrorImplCopyWithImpl(_$FloorListStateErrorImpl _value,
      $Res Function(_$FloorListStateErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of FloorListState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = freezed,
  }) {
    return _then(_$FloorListStateErrorImpl(
      freezed == error ? _value.error : error,
    ));
  }
}

/// @nodoc

class _$FloorListStateErrorImpl extends FloorListStateError {
  _$FloorListStateErrorImpl(this.error) : super._();

  @override
  final Object? error;

  @override
  String toString() {
    return 'FloorListState.error(error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FloorListStateErrorImpl &&
            const DeepCollectionEquality().equals(other.error, error));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(error));

  /// Create a copy of FloorListState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FloorListStateErrorImplCopyWith<_$FloorListStateErrorImpl> get copyWith =>
      __$$FloorListStateErrorImplCopyWithImpl<_$FloorListStateErrorImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            List<DocumentPreviewDto> documentPreviews,
            bool isSelectionMode,
            Set<DocumentPreviewDto> selectedDocuments,
            DocumentViewType documentViewType,
            DocumentSortType sortType,
            SortDirection sortDirection)
        data,
    required TResult Function(Object? error) error,
    required TResult Function() loading,
  }) {
    return error(this.error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            List<DocumentPreviewDto> documentPreviews,
            bool isSelectionMode,
            Set<DocumentPreviewDto> selectedDocuments,
            DocumentViewType documentViewType,
            DocumentSortType sortType,
            SortDirection sortDirection)?
        data,
    TResult? Function(Object? error)? error,
    TResult? Function()? loading,
  }) {
    return error?.call(this.error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            List<DocumentPreviewDto> documentPreviews,
            bool isSelectionMode,
            Set<DocumentPreviewDto> selectedDocuments,
            DocumentViewType documentViewType,
            DocumentSortType sortType,
            SortDirection sortDirection)?
        data,
    TResult Function(Object? error)? error,
    TResult Function()? loading,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this.error);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FloorListStateData value) data,
    required TResult Function(FloorListStateError value) error,
    required TResult Function(FloorListStateLoading value) loading,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FloorListStateData value)? data,
    TResult? Function(FloorListStateError value)? error,
    TResult? Function(FloorListStateLoading value)? loading,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FloorListStateData value)? data,
    TResult Function(FloorListStateError value)? error,
    TResult Function(FloorListStateLoading value)? loading,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class FloorListStateError extends FloorListState {
  factory FloorListStateError(final Object? error) = _$FloorListStateErrorImpl;
  FloorListStateError._() : super._();

  Object? get error;

  /// Create a copy of FloorListState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FloorListStateErrorImplCopyWith<_$FloorListStateErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$FloorListStateLoadingImplCopyWith<$Res> {
  factory _$$FloorListStateLoadingImplCopyWith(
          _$FloorListStateLoadingImpl value,
          $Res Function(_$FloorListStateLoadingImpl) then) =
      __$$FloorListStateLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$FloorListStateLoadingImplCopyWithImpl<$Res>
    extends _$FloorListStateCopyWithImpl<$Res, _$FloorListStateLoadingImpl>
    implements _$$FloorListStateLoadingImplCopyWith<$Res> {
  __$$FloorListStateLoadingImplCopyWithImpl(_$FloorListStateLoadingImpl _value,
      $Res Function(_$FloorListStateLoadingImpl) _then)
      : super(_value, _then);

  /// Create a copy of FloorListState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$FloorListStateLoadingImpl extends FloorListStateLoading {
  _$FloorListStateLoadingImpl() : super._();

  @override
  String toString() {
    return 'FloorListState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FloorListStateLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            List<DocumentPreviewDto> documentPreviews,
            bool isSelectionMode,
            Set<DocumentPreviewDto> selectedDocuments,
            DocumentViewType documentViewType,
            DocumentSortType sortType,
            SortDirection sortDirection)
        data,
    required TResult Function(Object? error) error,
    required TResult Function() loading,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            List<DocumentPreviewDto> documentPreviews,
            bool isSelectionMode,
            Set<DocumentPreviewDto> selectedDocuments,
            DocumentViewType documentViewType,
            DocumentSortType sortType,
            SortDirection sortDirection)?
        data,
    TResult? Function(Object? error)? error,
    TResult? Function()? loading,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            List<DocumentPreviewDto> documentPreviews,
            bool isSelectionMode,
            Set<DocumentPreviewDto> selectedDocuments,
            DocumentViewType documentViewType,
            DocumentSortType sortType,
            SortDirection sortDirection)?
        data,
    TResult Function(Object? error)? error,
    TResult Function()? loading,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FloorListStateData value) data,
    required TResult Function(FloorListStateError value) error,
    required TResult Function(FloorListStateLoading value) loading,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FloorListStateData value)? data,
    TResult? Function(FloorListStateError value)? error,
    TResult? Function(FloorListStateLoading value)? loading,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FloorListStateData value)? data,
    TResult Function(FloorListStateError value)? error,
    TResult Function(FloorListStateLoading value)? loading,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class FloorListStateLoading extends FloorListState {
  factory FloorListStateLoading() = _$FloorListStateLoadingImpl;
  FloorListStateLoading._() : super._();
}
