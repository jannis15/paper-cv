import 'package:flutter/material.dart';

class FloorLoaderOverlay extends StatelessWidget {
  final Widget child;
  final bool loading;
  final Widget? loadingWidget;

  const FloorLoaderOverlay({super.key, required this.child, required this.loading, this.loadingWidget});

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return PopScope(
      canPop: !loading,
      child: Stack(
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
      ),
    );
  }
}
