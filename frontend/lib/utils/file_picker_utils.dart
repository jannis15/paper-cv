import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:paper_cv/utils/alert_dialog.dart';
import 'package:paper_cv/utils/file_picker_models.dart';
import 'package:permission_handler/permission_handler.dart';

abstract class FilePickerHelper {
  static Future<List<SelectedFile>> pickImageSelectedFile(BuildContext context, {required bool allowMultiple}) async {
    final List<SelectedFile> images = [];
    try {
      if (allowMultiple) {
        final selectedFiles = await Future.wait(
          (await ImagePicker().pickMultiImage()).map(
            (xFile) async {
              final fileBytes = await xFile.readAsBytes();
              final now = DateTime.now();
              return SelectedFile(
                filename: xFile.name,
                data: fileBytes,
                createdAt: now,
                modifiedAt: now,
              );
            },
          ),
        );
        images.addAll((selectedFiles));
      } else {
        final image = await ImagePicker().pickImage(source: ImageSource.gallery);
        if (image != null) {
          final fileBytes = await image.readAsBytes();
          final now = DateTime.now();
          final selectedFile = SelectedFile(
            filename: image.name,
            data: fileBytes,
            createdAt: now,
            modifiedAt: now,
          );
          images.add(selectedFile);
        }
      }
    } on PlatformException catch (_) {
      if (context.mounted) {
        final AlertOption? result = await showAlertDialog(
          context,
          title: 'Zugriff verweigert',
          content: 'Die App benötigt die Berechtigung, um Fotos aus Ihrer Galerie nutzen zu können',
          optionData: [AlertOptionData.yes(customText: 'Einstellungen öffnen')],
          barrierDismissible: true,
        );
        if (result != null && result == AlertOption.yes) {
          openAppSettings();
        }
      }
    }
    return images;
  }
}
