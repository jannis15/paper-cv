import 'package:freezed_annotation/freezed_annotation.dart';

part 'floor_dto_models.freezed.dart';

@freezed
class DocumentPreviewDto with _$DocumentPreviewDto {
  const factory DocumentPreviewDto({
    required String? uuid,
    required String title,
    required DateTime createdAt,
    required DateTime modifiedAt,
  }) = _DocumentPreviewDto;
}
