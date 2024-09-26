import 'dart:typed_data';

import 'package:floor_cv/data/models/floor_enums.dart';
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

@freezed
class FileDto with _$FileDto {
  const factory FileDto({
    required String? uuid,
    required String? refUuid,
    required String filename,
    required Uint8List data,
    required int? index,
    required FileType fileType,
    required DateTime createdAt,
    required DateTime modifiedAt,
  }) = _FileDto;
}
