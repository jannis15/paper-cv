import 'package:flutter/material.dart';
import 'package:paper_cv/config/config.dart';
import 'package:paper_cv/core/utils/widget_utils.dart';
import '../utils/sort_enums.dart';
import '../utils/list_utils.dart';

class FloorDropdownSort<E extends Enum> extends StatefulWidget {
  final List<E> options;
  final Map<E, String> labels;
  final E value;
  final SortDirection sortDirection;
  final ValueChanged<E> onOptionChanged;

  FloorDropdownSort({
    super.key,
    required this.options,
    required this.labels,
    required this.value,
    required this.onOptionChanged,
    required this.sortDirection,
  });

  @override
  FloorDropdownSortState<E> createState() => FloorDropdownSortState<E>();
}

class FloorDropdownSortState<E extends Enum> extends State<FloorDropdownSort<E>> {
  bool _isPopupOpen = false;

  BorderRadius borderRadius(int index, {double borderRadius = AppSizes.kComponentHeight / 2}) => BorderRadius.only(
        topLeft: index == 0 ? Radius.circular(borderRadius) : Radius.zero,
        bottomLeft: index == 0 ? Radius.circular(borderRadius) : Radius.zero,
        topRight: index == 1 ? Radius.circular(borderRadius) : Radius.zero,
        bottomRight: index == 1 ? Radius.circular(borderRadius) : Radius.zero,
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppSizes.kComponentHeight,
      decoration: ShapeDecoration(
        shape: StadiumBorder(side: BorderSide(color: colorScheme.outline)),
        color: Colors.transparent,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: InkWell(
              borderRadius: borderRadius(0),
              onTap: () {
                widget.onOptionChanged(widget.value);
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: AppSizes.kSmallGap),
                height: AppSizes.kComponentHeight,
                child: RowGap(
                  mainAxisSize: MainAxisSize.min,
                  gap: AppSizes.kSmallGap,
                  children: [
                    Icon(
                      widget.sortDirection == SortDirection.ascending ? Icons.arrow_upward : Icons.arrow_downward,
                      size: AppSizes.kSubIconSize,
                      color: colorScheme.secondary,
                    ),
                    Flexible(
                      child: Text(
                        widget.labels[widget.value]!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Container(
            width: 1.0,
            color: colorScheme.outline,
            height: AppSizes.kComponentHeight,
          ),
          Material(
            color: Colors.transparent,
            borderRadius: borderRadius(1),
            clipBehavior: Clip.hardEdge,
            child: PopupMenuButton<E>(
              onOpened: () {
                setState(() {
                  _isPopupOpen = true;
                });
              },
              onCanceled: () {
                setState(() {
                  _isPopupOpen = false;
                });
              },
              onSelected: (E selectedValue) {
                setState(() {
                  _isPopupOpen = false;
                });
                widget.onOptionChanged(selectedValue);
              },
              itemBuilder: (context) => widget.options
                  .map((option) => PopupMenuItem<E>(
                        value: option,
                        child: Text(widget.labels[option]!),
                      ))
                  .toList(),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: AppSizes.kSmallGap),
                height: AppSizes.kComponentHeight,
                child: Icon(_isPopupOpen ? Icons.expand_less : Icons.expand_more),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
