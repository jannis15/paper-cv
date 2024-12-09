import 'package:paper_cv/config/config.dart';
import 'package:flutter/material.dart';
import 'package:paper_cv/utils/widget_utils.dart';

class FloorCard extends StatefulWidget {
  final void Function(DismissDirection dismissDirection)? onDismissed;
  final Future<bool?> Function(DismissDirection dismissDirection)? confirmDismiss;
  final void Function()? onTap;
  final void Function()? onLongPress;
  final Color? color;
  final BorderRadiusGeometry? borderRadius;
  final Widget child;
  final bool usePadding;

  const FloorCard({
    super.key,
    this.usePadding = true,
    this.onDismissed,
    this.confirmDismiss,
    this.onTap,
    this.onLongPress,
    this.color,
    this.borderRadius,
    required this.child,
  });

  @override
  State<FloorCard> createState() => _FloorCardState();
}

class _FloorCardState extends State<FloorCard> {
  @override
  Widget build(BuildContext context) {
    Widget buildCardChild() => Padding(padding: const EdgeInsets.all(AppSizes.kGap), child: widget.child);

    return Material(
      color: widget.color ?? colorScheme.surfaceContainer,
      elevation: 0,
      clipBehavior: Clip.hardEdge,
      borderRadius: widget.borderRadius ?? BorderRadius.circular(AppSizes.kBorderRadius),
      child: InkWell(
        onLongPress: widget.onLongPress,
        onTap: widget.onTap,
        child: widget.confirmDismiss != null
            ? Dismissible(
                key: UniqueKey(),
                direction: DismissDirection.endToStart,
                onDismissed: widget.onDismissed,
                confirmDismiss: widget.confirmDismiss,
                background: Container(
                  color: Colors.red,
                  padding: EdgeInsets.all(AppSizes.kGap),
                  alignment: AlignmentDirectional.centerEnd,
                  child: Icon(Icons.delete, size: AppSizes.kIconSize, color: Colors.white),
                ),
                child: widget.usePadding ? buildCardChild() : widget.child,
              )
            : widget.usePadding
                ? buildCardChild()
                : widget.child,
      ),
    );
  }
}
