import 'package:floor_cv/utils/camera/camera_utils.dart';
import 'package:floor_cv/utils/file_picker_models.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

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
        final List<Future<SelectedFile>> futures =
            xFiles.map((file) async => SelectedFile(name: file.name, bytes: await file.readAsBytes())).toList();
        return Future.wait(futures);
      } else {
        return null;
      }
    }

    Future<List<SelectedFile>?> pickCameraFiles() async {
      final List<XFile> xFiles = await CameraUtils.takePicture(context, allowMultiple: allowMultiple);
      if (xFiles.isNotEmpty) {
        final futures = xFiles.map((file) async => SelectedFile(name: file.name, bytes: await file.readAsBytes())).toList();
        return Future.wait(futures);
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
