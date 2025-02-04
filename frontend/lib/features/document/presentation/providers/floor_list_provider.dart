import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paper_cv/features/document/presentation/states/floor_list_state.dart';

import '../../../../core/utils/sort_enums.dart';
import '../../domain/models/floor_models.dart';
import '../../domain/repositories/floor_repository.dart';

class FloorListProvider extends Cubit<FloorListState> {
  late Stream<List<DocumentPreviewDto>> _previewStream;
  late final FloorRepository _repository;

  FloorListProvider({required FloorRepository repository}) : super(FloorListState.loading()) {
    _repository = repository;
    _assignPreviewStream(
      documentSortType: DocumentSortType.documentDate,
      sortDirection: SortDirection.descending,
    );
    _previewStream.listen(
      (event) {
        if (state is FloorListStateData) {
          emit((state as FloorListStateData).copyWith(documentPreviews: event));
        } else {
          emit(FloorListState.data(documentPreviews: event));
        }
      },
    );
  }

  void _assignPreviewStream({
    required DocumentSortType documentSortType,
    required SortDirection sortDirection,
  }) =>
      _previewStream = _repository.watchDocumentPreviews(
        sortType: documentSortType,
        sortDirection: sortDirection,
      );

  void disableSelectionMode() {
    state.whenOrNull(
      data: (documentPreviews, isSelectionMode, selectedDocuments, documentViewType, sortType, sortDirection) => emit(
        (state as FloorListStateData).copyWith(
          isSelectionMode: false,
          selectedDocuments: {},
        ),
      ),
    );
  }

  void selectDocument(DocumentPreviewDto documentPreview) {
    state.whenOrNull(
      data: (documentPreviews, isSelectionMode, selectedDocuments, documentViewType, sortType, sortDirection) {
        if (selectedDocuments.contains(documentPreview)) {
          selectedDocuments = Set.of(selectedDocuments)..remove(documentPreview);
          emit((state as FloorListStateData).copyWith(selectedDocuments: selectedDocuments));
        } else {
          emit((state as FloorListStateData).copyWith(
            isSelectionMode: selectedDocuments.length == 0 ? true : isSelectionMode,
            selectedDocuments: {...selectedDocuments, documentPreview},
          ));
        }
      },
    );
  }

  void toggleSelectionMode(DocumentPreviewDto documentPreview) {
    state.whenOrNull(
      data: (documentPreviews, isSelectionMode, selectedDocuments, documentViewType, sortType, sortDirection) {
        emit(
          (state as FloorListStateData).copyWith(
            isSelectionMode: !isSelectionMode,
            selectedDocuments: isSelectionMode ? {} : {...selectedDocuments, documentPreview},
          ),
        );
      },
    );
  }

  void sortDocumentPreviews(DocumentSortType newSortType) {
    state.whenOrNull(
      data: (documentPreviews, isSelectionMode, selectedDocuments, documentViewType, sortType, sortDirection) {
        sortDirection = newSortType == sortType ? sortDirection.opposite : sortDirection;
        sortType = newSortType;
        documentPreviews = List.of(documentPreviews)
          ..sort((a, b) {
            final sortA = sortDirection == SortDirection.ascending ? a : b;
            final sortB = sortDirection == SortDirection.ascending ? b : a;
            switch (sortType) {
              case DocumentSortType.title:
                return sortA.title.toLowerCase().compareTo(sortB.title.toLowerCase());
              case DocumentSortType.modifiedAt:
                return sortA.modifiedAt.compareTo(sortB.modifiedAt);
              case DocumentSortType.documentDate:
                return sortA.documentDate != null && sortB.documentDate != null ? sortA.documentDate!.compareTo(sortB.documentDate!) : 0;
              default:
                return 0;
            }
          });
        emit(
          (state as FloorListStateData).copyWith(
            sortType: sortType,
            sortDirection: sortDirection,
            documentPreviews: documentPreviews,
          ),
        );
      },
    );
  }

  void setSelectionMode() {
    state.whenOrNull(
      data: (documentPreviews, isSelectionMode, selectedDocuments, documentViewType, sortType, sortDirection) => emit(
        (state as FloorListStateData).copyWith(isSelectionMode: true),
      ),
    );
  }

  void setDocumentViewType(DocumentViewType newDocumentViewType) => state.whenOrNull(
        data: (documentPreviews, isSelectionMode, selectedDocuments, documentViewType, sortType, sortDirection) => emit(
          (state as FloorListStateData).copyWith(
            documentViewType: newDocumentViewType,
          ),
        ),
      );

  void deleteSelectedDocuments() {
    state.whenOrNull(
      data: (documentPreviews, isSelectionMode, selectedDocuments, documentViewType, sortType, sortDirection) async {
        for (final document in selectedDocuments) {
          await _repository.deleteDocumentById(document.uuid);
        }
      },
    );
  }
}
