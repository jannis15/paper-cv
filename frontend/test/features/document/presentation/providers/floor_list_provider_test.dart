import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:paper_cv/core/utils/sort_enums.dart';
import 'package:paper_cv/features/document/domain/models/floor_models.dart';
import 'package:paper_cv/features/document/presentation/providers/floor_list_provider.dart';
import 'package:paper_cv/features/document/presentation/states/floor_list_state.dart';

import '../../../../mocks/floor_repository_mock.dart';

void main() {
  blocTest<FloorListProvider, FloorListState>(
    'Emits data state when repository provides documents',
    build: () {
      final MockFloorRepository repository = MockFloorRepository();
      registerFallbackValue(DocumentSortType.documentDate);
      registerFallbackValue(SortDirection.descending);
      when(() => repository.watchDocumentPreviews(
            sortType: any(named: 'sortType'),
            sortDirection: any(named: 'sortDirection'),
          )).thenAnswer((_) => Stream.value([
            DocumentPreviewDto(
              uuid: '1',
              title: 'Test Document',
              createdAt: DateTime(2024, 1, 1),
              modifiedAt: DateTime(2024, 1, 2),
              documentDate: DateTime(2024, 1, 3),
              isExample: false,
            ),
          ]));
      return FloorListProvider(repository: repository);
    },
    expect: () => [
      FloorListState.data(
        documentPreviews: [
          DocumentPreviewDto(
            uuid: '1',
            title: 'Test Document',
            createdAt: DateTime(2024, 1, 1),
            modifiedAt: DateTime(2024, 1, 2),
            documentDate: DateTime(2024, 1, 3),
            isExample: false,
          ),
        ],
      ),
    ],
  );
}
