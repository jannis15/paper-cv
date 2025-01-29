import 'package:desktop_drop/desktop_drop.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:paper_cv/config/config.dart';
import 'package:paper_cv/core/utils/list_utils.dart';
import 'package:paper_cv/core/utils/widget_utils.dart';

import '../../generated/l10n.dart';

class FloorDrag extends StatefulWidget {
  final void Function(DropDoneDetails detail)? onDragDone;
  final Widget child;

  const FloorDrag({
    super.key,
    required this.child,
    this.onDragDone,
  });

  @override
  State<FloorDrag> createState() => _FloorDragState();
}

class _FloorDragState extends State<FloorDrag> {
  bool _dragging = false;

  @override
  Widget build(BuildContext context) {
    return DropTarget(
      onDragDone: widget.onDragDone,
      onDragEntered: (detail) {
        setState(() {
          _dragging = true;
        });
      },
      onDragExited: (detail) {
        setState(() {
          _dragging = false;
        });
      },
      child: DottedBorder(
        dashPattern: [6, 3],
        radius: Radius.circular(AppSizes.kBorderRadius),
        borderType: BorderType.RRect,
        color: _dragging ? colorScheme.primary : Colors.transparent,
        child: IntrinsicHeight(
          child: Stack(
            fit: StackFit.expand,
            children: [
              widget.child,
              if (_dragging)
                Container(
                  decoration: BoxDecoration(
                    color: colorScheme.onSurface.withOpacity(.3),
                    borderRadius: BorderRadius.circular(AppSizes.kBorderRadius),
                  ),
                  child: ColumnGap(
                    gap: AppSizes.kSmallGap,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.file_download, color: colorScheme.primary, size: AppSizes.kComponentHeight),
                      Text(
                        S.current.dropHere,
                        style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
