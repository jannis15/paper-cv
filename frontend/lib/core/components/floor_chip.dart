import 'package:flutter/material.dart';
import 'package:paper_cv/config/config.dart';
import 'package:paper_cv/core/utils/list_utils.dart';
import 'package:paper_cv/core/utils/widget_utils.dart';

class FloorChip extends StatefulWidget {
  final IconData? iconData;
  final String? text;
  final bool isTrailingIcon;
  final void Function()? onPressed;
  final bool? isSelected;

  const FloorChip({
    super.key,
    this.iconData,
    this.text,
    this.onPressed,
    this.isTrailingIcon = false,
    this.isSelected,
  });

  @override
  State<FloorChip> createState() => _FloorChipState();
}

class _FloorChipState extends State<FloorChip> {
  @override
  Widget build(BuildContext context) {
    List<Widget> getChildren() => [
          if (widget.iconData != null)
            Icon(
              widget.iconData,
              size: AppSizes.kSubIconSize,
              color: widget.isSelected == true
                  ? colorScheme.onSecondary
                  : widget.isTrailingIcon
                      ? null
                      : colorScheme.secondary,
            ),
          if (widget.text != null)
            Text(
              widget.text!,
              style: textTheme.labelLarge?.copyWith(
                color: widget.isSelected == true ? colorScheme.onSecondary : colorScheme.onSurfaceVariant,
              ),
            ),
        ];

    return ActionChip(
      color: widget.isSelected == true ? WidgetStatePropertyAll(colorScheme.secondary) : null,
      padding: EdgeInsets.fromLTRB(
        !widget.isTrailingIcon && widget.iconData != null
            ? AppSizes.kSmallGap
            : widget.text == null
                ? AppSizes.kSmallGap
                : AppSizes.kGap,
        0,
        widget.isTrailingIcon && widget.iconData != null
            ? AppSizes.kSmallGap
            : widget.text == null
                ? AppSizes.kSmallGap
                : AppSizes.kGap,
        0,
      ),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      visualDensity: VisualDensity.compact,
      labelPadding: EdgeInsets.zero,
      onPressed: widget.onPressed,
      side: BorderSide(color: widget.isSelected == true ? Colors.transparent : colorScheme.outline),
      label: SizedBox(
        height: AppSizes.kComponentHeight,
        child: RowGap(
          gap: AppSizes.kGap,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: widget.isTrailingIcon ? getChildren().reversed.toList() : getChildren(),
        ),
      ),
    );
  }
}
