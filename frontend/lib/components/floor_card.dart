import 'package:paper_cv/config/config.dart';
import 'package:flutter/material.dart';

class FloorCard extends StatefulWidget {
  final void Function(DismissDirection dismissDirection)? onDismissed;
  final Future<bool?> Function(DismissDirection dismissDirection)? confirmDismiss;
  final void Function()? onTap;
  final Widget child;

  const FloorCard({
    super.key,
    this.onDismissed,
    this.confirmDismiss,
    required this.child,
    this.onTap,
  });

  @override
  State<FloorCard> createState() => _FloorCardState();
}

class _FloorCardState extends State<FloorCard> {
  @override
  Widget build(BuildContext context) {
    Widget buildCardChild() => Padding(padding: const EdgeInsets.all(AppSizes.kGap), child: widget.child);

    return Card(
      margin: EdgeInsets.zero,
      clipBehavior: Clip.hardEdge,
      child: InkWell(
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
                child: buildCardChild(),
              )
            : buildCardChild(),
      ),
    );
  }
}
