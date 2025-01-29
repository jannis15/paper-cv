import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:paper_cv/generated/l10n.dart';
import 'package:paper_cv/config/config.dart';
import 'package:paper_cv/core/utils/alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gal/gal.dart';
import 'package:paper_cv/core/utils/file_picker_models.dart';
import 'package:paper_cv/core/utils/file_picker_utils.dart';
import 'package:paper_cv/core/utils/list_utils.dart';
import 'package:paper_cv/core/utils/orientation_helper.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wakelock_plus/wakelock_plus.dart';
import 'camera/camera_rectangular_overlay_painter.mobile.dart' if (dart.library.html) 'camera/camera_rectangular_overlay_painter.web.dart';
import 'package:paper_cv/core/utils/access_file.unimplemented.dart' if (dart.library.html) 'package:paper_cv/core/utils/access_file.web.dart';
import 'package:image/image.dart' as img;

part 'camera/camera_confirm_view.dart';

part 'camera/camera_rectangular_overlay_painter.dart';

part 'camera/camera_view.dart';

const double cameraFeedOverlayMargin = 32.0;

abstract class FloorCamera {
  static Future<List<SelectedFile>> takePicture(
    BuildContext context, {
    bool allowGalleryPictures = true,
    bool allowMultiple = false,
    double? aspectRatioOverlay = 29.7 / 21,
  }) async {
    return await (Navigator.of(context).push<List<SelectedFile>>(
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
