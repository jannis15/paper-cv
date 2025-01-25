import 'package:paper_cv/config/config.dart';
import 'package:paper_cv/utils/list_utils.dart';
import 'package:flutter/material.dart';

enum FloorButtonType {
  filled,
  outlined,
  transparent;
}

class FloorButton extends StatelessWidget {
  final bool loading;
  final IconData? iconData;
  final String? text;
  final void Function()? onPressed;
  final Color? foregroundColor;
  final Color? backgroundColor;
  final TextDecoration? textDecoration;

  final FloorButtonType type;

  FloorButton({
    super.key,
    this.iconData,
    this.text,
    this.onPressed,
    this.loading = false,
    required this.type,
    this.foregroundColor,
    this.backgroundColor,
    this.textDecoration,
  });

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final TextTheme textTheme = Theme.of(context).textTheme;
    final baseBackgroundColor = backgroundColor ?? colorScheme.primary;

    Color getBackgroundColor() => type == FloorButtonType.filled
        ? onPressed == null
            ? Color.alphaBlend(colorScheme.surface.withOpacity(.5), baseBackgroundColor)
            : baseBackgroundColor
        : Colors.transparent;
    Color getForegroundColor() {
      final calcForegroundColor = foregroundColor != null
          ? foregroundColor!
          : type == FloorButtonType.filled
              ? colorScheme.onPrimary
              : colorScheme.onSurface;
      return onPressed == null ? Color.alphaBlend(colorScheme.surface.withOpacity(.5), calcForegroundColor) : calcForegroundColor;
    }

    Color getBorderColor() => onPressed == null ? Color.alphaBlend(colorScheme.surface.withOpacity(.5), colorScheme.outline) : colorScheme.outline;

    return IgnorePointer(
      ignoring: loading,
      child: SizedBox(
        height: AppSizes.kComponentHeight,
        child: FilledButton(
          onPressed: loading ? null : onPressed,
          child: RowGap(
            gap: AppSizes.kSmallGap,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (loading)
                SizedBox(
                  height: AppSizes.kSubIconSize / 2,
                  width: AppSizes.kSubIconSize / 2,
                  child: CircularProgressIndicator(strokeWidth: 1, color: getForegroundColor()),
                )
              else if (iconData != null)
                SizedBox(width: AppSizes.kSubIconSize, child: Icon(iconData, size: AppSizes.kSubIconSize, color: getForegroundColor())),
              if (text != null)
                Text(
                  text!,
                  style: textTheme.labelLarge?.copyWith(color: getForegroundColor(), decoration: textDecoration),
                ),
            ],
          ),
          style: ButtonStyle(
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            visualDensity: VisualDensity.compact,
            side: type == FloorButtonType.outlined ? WidgetStatePropertyAll(BorderSide(width: 1, color: getBorderColor())) : null,
            overlayColor: type != FloorButtonType.filled ? WidgetStatePropertyAll(getForegroundColor().withOpacity(.1)) : null,
            foregroundColor: WidgetStatePropertyAll(getForegroundColor()),
            backgroundColor: WidgetStatePropertyAll(getBackgroundColor()),
            padding: WidgetStatePropertyAll(
              EdgeInsets.fromLTRB(AppSizes.kGap, 0, iconData != null && text != null ? AppSizes.kMediumBigGap : AppSizes.kGap, 0),
            ),
          ),
        ),
      ),
    );
  }
}

class FloorTransparentButton extends FloorButton {
  FloorTransparentButton({
    super.key,
    super.iconData,
    super.foregroundColor,
    super.text,
    super.onPressed,
    super.textDecoration,
    super.loading,
  }) : super(type: FloorButtonType.transparent);
}

class FloorOutlinedButton extends FloorButton {
  FloorOutlinedButton({
    super.key,
    super.iconData,
    super.text,
    super.onPressed,
    super.textDecoration,
    super.loading,
  }) : super(type: FloorButtonType.outlined);
}

class FloorFilledButton extends FloorButton {
  FloorFilledButton({
    super.key,
    super.iconData,
    super.text,
    super.onPressed,
    super.textDecoration,
    super.loading,
  }) : super(type: FloorButtonType.filled);
}
