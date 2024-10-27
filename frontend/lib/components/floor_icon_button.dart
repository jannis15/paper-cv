import 'package:paper_cv/config/config.dart';
import 'package:flutter/material.dart';

class FloorIconButton extends StatelessWidget {
  final void Function()? onPressed;
  final IconData iconData;
  final String? tooltip;
  final Color? foregroundColor;
  final Color? backgroundColor;

  const FloorIconButton({
    super.key,
    this.onPressed,
    required this.iconData,
    this.tooltip,
    this.foregroundColor,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip ?? '',
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(
          iconData,
          size: AppSizes.kMainIconSize,
          color: foregroundColor ?? Theme.of(context).colorScheme.onSurfaceVariant,
        ),
        style: ButtonStyle(
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          visualDensity: VisualDensity.compact,
          padding: WidgetStatePropertyAll(EdgeInsets.zero),
          elevation: WidgetStatePropertyAll(0),
          foregroundColor: WidgetStatePropertyAll(foregroundColor ?? Theme.of(context).colorScheme.onSurfaceVariant),
          backgroundColor: WidgetStatePropertyAll(backgroundColor ?? Theme.of(context).colorScheme.surfaceContainerHighest),
        ),
      ),
    );
  }
}
