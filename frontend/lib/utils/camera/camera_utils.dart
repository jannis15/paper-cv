import 'package:camera/camera.dart';
import 'package:paper_cv/utils/alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gal/gal.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

part 'camera_confirm_view.dart';

part 'camera_view.dart';

abstract class CameraUtils {
  static Future<List<XFile>> takePicture(BuildContext context, {bool allowGalleryPictures = true, bool allowMultiple = false}) async {
    return await (Navigator.of(context).push<List<XFile>>(
          MaterialPageRoute(
            builder: (context) => _CameraView(
              allowGalleryPictures: allowGalleryPictures,
              allowMultiple: allowMultiple,
            ),
          ),
        )) ??
        [];
  }
}
