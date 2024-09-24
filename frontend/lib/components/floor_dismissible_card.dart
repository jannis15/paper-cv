import 'package:floor_cv/config/config.dart';
import 'package:flutter/material.dart';

class FloorDismissibleCard extends StatefulWidget {
  final void Function(DismissDirection dismissDirection)? onDismissed;
  final Future<bool?> Function(DismissDirection dismissDirection)? confirmDismiss;
  final void Function()? onTap;
  final Widget child;

  const FloorDismissibleCard({
    super.key,
    this.onDismissed,
    this.confirmDismiss,
    required this.child,
    this.onTap,
  });

  @override
  State<FloorDismissibleCard> createState() => _FloorDismissibleCardState();
}

class _FloorDismissibleCardState extends State<FloorDismissibleCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: widget.onTap,
        child: Dismissible(
          key: UniqueKey(),
          direction: DismissDirection.endToStart,
          onDismissed: widget.onDismissed,
          confirmDismiss: widget.confirmDismiss,
          background: Container(
            color: Colors.red,
            padding: EdgeInsets.all(AppSizes.kGap),
            alignment: AlignmentDirectional.centerEnd,
            child: Icon(Icons.delete, size: AppSizes.kIconSize),
          ),
          child: Padding(padding: const EdgeInsets.all(AppSizes.kGap), child: widget.child),
        ),
      ),
    );
  }
}
