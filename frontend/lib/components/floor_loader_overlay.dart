import 'package:flutter/material.dart';

class FloorLoaderOverlay extends StatelessWidget {
  final Widget child;
  final bool loading;
  final Widget? loadingWidget;
  final bool disableBackButton;

  const FloorLoaderOverlay({
    super.key,
    required this.child,
    required this.loading,
    this.loadingWidget,
    this.disableBackButton = true,
  });

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    Widget buildStack() => Stack(
          fit: StackFit.expand,
          alignment: Alignment.center,
          children: [
            child,
            if (loading) ...[
              Container(
                color: colorScheme.surface.withOpacity(.5),
                child: loadingWidget ?? Center(child: CircularProgressIndicator()),
              )
            ],
          ],
        );
    return disableBackButton ? PopScope(canPop: !loading, child: buildStack()) : buildStack();
  }
}
