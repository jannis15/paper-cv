import 'dart:math';

import 'package:camera/camera.dart';
import 'package:paper_cv/utils/alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gal/gal.dart';
import 'package:image_picker/image_picker.dart';
import 'package:paper_cv/utils/list_utils.dart';
import 'package:paper_cv/utils/orientation_helper.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wakelock_plus/wakelock_plus.dart';
import 'package:image/image.dart' as img;

part 'camera_confirm_view.dart';

part 'camera_rectangular_overlay_painter.dart';

part 'camera_view.dart';

const double cameraFeedOverlayMargin = 32.0;

abstract class CameraUtils {
  static Future<List<XFile>> takePicture(
    BuildContext context, {
    bool allowGalleryPictures = true,
    bool allowMultiple = false,
    double? aspectRatioOverlay = 29.7 / 21,
  }) async {
    return await (Navigator.of(context).push<List<XFile>>(
          MaterialPageRoute(
            builder: (context) => _CameraView(
              allowGalleryPictures: allowGalleryPictures,
              allowMultiple: allowMultiple,
              aspectRatioOverlay: aspectRatioOverlay,
            ),
          ),
        )) ??
        [];
  }
}
