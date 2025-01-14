import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:paper_cv/config/config.dart';
import 'package:paper_cv/utils/widget_utils.dart';

class IconWithBackground extends StatefulWidget {
  final Widget iconWidget;
  final String? text;

  const IconWithBackground({super.key, required this.iconWidget, this.text});

  @override
  _IconWithBackgroundState createState() => _IconWithBackgroundState();
}

class _IconWithBackgroundState extends State<IconWithBackground> {
  GlobalKey iconKey = GlobalKey();
  Color? dominantColor;
  Color iconColor = Colors.black;

  Color get oppositeIconColor => iconColor == Colors.black ? Colors.white : Colors.black;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _extractDominantColor());
  }

  Future<void> _extractDominantColor() async {
    try {
      RenderRepaintBoundary boundary = iconKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 2.0);
      ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      final imageBytes = byteData!.buffer.asUint8List();
      final paletteGenerator = await PaletteGenerator.fromImageProvider(
        MemoryImage(imageBytes),
      );
      setState(() {
        dominantColor = paletteGenerator.dominantColor?.color ?? Colors.grey;
        iconColor = _getContrastingColor(dominantColor!);
      });
    } catch (e) {
      setState(() {
        dominantColor = Colors.grey;
        iconColor = Colors.white;
      });
    }
  }

  Color _getContrastingColor(Color color) {
    double luminance = color.computeLuminance();
    return luminance > 0.5 ? Colors.black : Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          color: dominantColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ColorFiltered(
                colorFilter: ColorFilter.mode(
                  iconColor,
                  BlendMode.srcIn,
                ),
                child: RepaintBoundary(
                  key: iconKey,
                  child: widget.iconWidget,
                ),
              ),
              if (widget.text != null && dominantColor != null)
                Container(
                  padding: EdgeInsets.symmetric(vertical: AppSizes.kSmallGap / 2),
                  color: colorScheme.primaryContainer,
                  child: Text(
                    widget.text!,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    style: textTheme.labelMedium?.copyWith(color: colorScheme.onPrimaryContainer),
                  ),
                ),
            ],
          ),
        ),
        if (dominantColor == null) Container(color: colorScheme.surface),
      ],
    );
  }
}
