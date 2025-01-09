import 'package:flutter/material.dart';
import 'package:paper_cv/config/config.dart';

import '../utils/list_utils.dart';

class FloorWrapView extends StatefulWidget {
  final int itemsPerRow;
  final List<Widget> children;
  final double aspectRatio;
  final Widget? endGap;

  FloorWrapView({required this.itemsPerRow, required this.children, this.aspectRatio = 1.0, this.endGap});

  @override
  _FloorWrapViewState createState() => _FloorWrapViewState();
}

class _FloorWrapViewState extends State<FloorWrapView> {
  @override
  Widget build(BuildContext context) {
    List<Widget> rows = [];
    int totalItems = widget.children.length;

    for (int i = 0; i < totalItems; i += widget.itemsPerRow) {
      int end = (i + widget.itemsPerRow) > totalItems ? totalItems : i + widget.itemsPerRow;
      List<Widget> rowItems = widget.children.sublist(i, end);

      while (rowItems.length < widget.itemsPerRow) {
        rowItems.add(SizedBox());
      }

      rows.add(
        RowGap(
          gap: AppSizes.kSmallGap,
          mainAxisAlignment: MainAxisAlignment.start,
          children: rowItems.map((child) {
            return Expanded(
              child: AspectRatio(
                aspectRatio: widget.aspectRatio,
                child: child,
              ),
            );
          }).toList(),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ColumnGap(
          gap: AppSizes.kSmallGap,
          children: rows,
        ),
        if (widget.endGap != null) widget.endGap!,
      ],
    );
  }
}
