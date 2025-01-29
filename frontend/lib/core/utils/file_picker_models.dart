import 'dart:convert';
import 'dart:typed_data';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uuid/uuid.dart';
import 'enum_utils.dart';

part 'file_picker_models.g.dart';

@JsonEnum(alwaysCreate: true)
enum FileType implements IJsonEnum<FileType> {
  @JsonValue(0)
  attachment,
  @JsonValue(1)
  capture,
  @JsonValue(2)
  report,
  @JsonValue(3)
  scan;

  @override
  int toJson() => _$FileTypeEnumMap[this]!;
}

enum FilePickerOption {
  camera,
  gallery;
}

class SelectedFile {
  final String uuid;
  String? refUuid;
  String filename;
  final Uint8List data;
  final int? index;
  FileType fileType;
  final DateTime createdAt;
  final DateTime modifiedAt;

  String get base64String => base64Encode(data);

  SelectedFile({
    String? uuid,
    this.refUuid,
    required this.filename,
    required this.data,
    this.index,
    this.fileType = FileType.attachment,
    required this.createdAt,
    required this.modifiedAt,
  }) : uuid = uuid ?? Uuid().v4();

  SelectedFile copyWith({
    String? uuid,
    String? refUuid,
    String? filename,
    Uint8List? data,
    int? index,
    FileType? fileType,
    DateTime? createdAt,
    DateTime? modifiedAt,
  }) {
    return SelectedFile(
      uuid: uuid ?? this.uuid,
      refUuid: refUuid ?? this.refUuid,
      filename: filename ?? this.filename,
      data: data ?? this.data,
      index: index ?? this.index,
      fileType: fileType ?? this.fileType,
      createdAt: createdAt ?? this.createdAt,
      modifiedAt: modifiedAt ?? this.modifiedAt,
    );
  }
}
