import 'package:paper_cv/core/utils/file_picker_models.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

import 'floor_camera.dart';

abstract class FloorFilePicker {
  static Future<SelectedFile?> pickFile(
    BuildContext context, {
    required FilePickerOption pickerOption,
  }) async {
    final List<SelectedFile>? result = await FloorFilePicker.pickFiles(
      context,
      pickerOption: pickerOption,
      allowMultiple: false,
    );
    if (result != null && result.isNotEmpty) return result.first;
    return null;
  }

  static Future<List<SelectedFile>?> pickFiles(
    BuildContext context, {
    required FilePickerOption pickerOption,
    bool allowMultiple = true,
  }) async {
    Future<List<SelectedFile>?> pickGalleryFiles() async {
      final List<XFile> xFiles = [];
      if (allowMultiple) {
        final List<XFile> tmpXFiles = await ImagePicker().pickMultiImage();
        xFiles.addAll(tmpXFiles);
      } else {
        final XFile? tmpXFile = await ImagePicker().pickImage(source: ImageSource.gallery);
        if (tmpXFile != null) xFiles.add(tmpXFile);
      }
      if (xFiles.isNotEmpty) {
        final now = DateTime.now();
        final List<Future<SelectedFile>> futures = xFiles
            .map(
              (file) async => SelectedFile(
                filename: file.name,
                data: await file.readAsBytes(),
                createdAt: now,
                modifiedAt: now,
              ),
            )
            .toList();
        return Future.wait(futures);
      } else {
        return null;
      }
    }

    Future<List<SelectedFile>?> pickCameraFiles() async {
      final List<SelectedFile> selectedFiles = await FloorCamera.takePicture(context, allowMultiple: allowMultiple);
      if (selectedFiles.isNotEmpty) {
        return selectedFiles;
      } else {
        return null;
      }
    }

    late final List<SelectedFile>? selectedFiles;
    switch (pickerOption) {
      case FilePickerOption.gallery:
        selectedFiles = await pickGalleryFiles();
      case FilePickerOption.camera:
        selectedFiles = await pickCameraFiles();
      default:
        selectedFiles = null;
    }
    return selectedFiles;
  }
}
