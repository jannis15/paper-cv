import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:paper_cv/core/utils/sort_enums.dart';
import 'package:paper_cv/features/document/domain/models/floor_models.dart';

import '../../../../generated/l10n.dart';

part 'floor_list_state.freezed.dart';

enum DocumentViewType {
  list,
  grid;

  String get label => switch (this) {
        DocumentViewType.list => S.current.list,
        DocumentViewType.grid => S.current.tile,
      };
}

@freezed
class FloorListState with _$FloorListState {
  const FloorListState._();

  String get selectedText => when(
        data: (documentPreviews, isSelectionMode, selectedDocuments, documentViewType, sortType, sortDirection) =>
            '${selectedDocuments.length} ${selectedDocuments.length == 1 ? S.current.documentSelected : S.current.documentsSelected}',
        error: (_) => throw UnimplementedError(),
        loading: () => throw UnimplementedError(),
      );

  const factory FloorListState.data({
    required List<DocumentPreviewDto> documentPreviews,
    @Default(false) bool isSelectionMode,
    @Default(const {}) Set<DocumentPreviewDto> selectedDocuments,
    @Default(DocumentViewType.grid) DocumentViewType documentViewType,
    @Default(DocumentSortType.documentDate) DocumentSortType sortType,
    @Default(SortDirection.descending) SortDirection sortDirection,
  }) = FloorListStateData;

  factory FloorListState.error(Object? error) = FloorListStateError;

  factory FloorListState.loading() = FloorListStateLoading;
}
