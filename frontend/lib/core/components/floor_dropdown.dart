import 'package:flutter/material.dart';
import 'package:paper_cv/core/components/floor_card.dart';
import 'package:paper_cv/config/config.dart';

class FloorDropdown<T> extends StatelessWidget {
  final T? value;
  final IconData? iconData;
  final List<DropdownMenuItem<T>> items;
  final String? labelText;
  final void Function(T? value)? onChanged;
  final String? hintText;

  const FloorDropdown({
    super.key,
    this.value,
    required this.items,
    this.labelText,
    this.onChanged,
    this.hintText,
    this.iconData,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppSizes.kComponentHeight + 2 * AppSizes.kSmallGap,
      child: FloorCard(
        usePadding: false,
        child: DropdownButtonFormField<T>(
          padding: EdgeInsets.only(top: AppSizes.kSmallGap / 2),
          isExpanded: true,
          hint: hintText != null ? Text(hintText!) : null,
          value: value,
          items: items,
          itemHeight: AppSizes.kComponentHeight + 2 * AppSizes.kSmallGap,
          onChanged: onChanged,
          decoration: InputDecoration(
            labelText: labelText,
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(horizontal: AppSizes.kGap, vertical: AppSizes.kSmallGap),
            prefixIconConstraints: BoxConstraints(maxHeight: AppSizes.kIconSize, maxWidth: AppSizes.kIconSize + 2 * AppSizes.kGap),
            prefixIcon: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSizes.kGap),
                child: Icon(
                  iconData,
                  size: AppSizes.kIconSize,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ),
          ),
          icon: Icon(
            Icons.expand_more,
            size: AppSizes.kIconSize,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
      ),
    );
  }
}
