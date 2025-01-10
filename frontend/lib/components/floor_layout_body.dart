import 'package:flutter/material.dart';
import 'package:paper_cv/components/floor_app_bar.dart';
import 'package:paper_cv/components/floor_card.dart';
import 'package:paper_cv/config/config.dart';
import 'package:paper_cv/utils/list_utils.dart';
import 'package:paper_cv/utils/shadow_utils.dart';
import 'package:paper_cv/utils/widget_utils.dart';

class FloorLayoutBody extends StatefulWidget {
  final Widget? title;
  final void Function()? customPop;
  final List<Widget>? actions;
  final Widget? floatingActionButton;
  final List<Widget> sideChildren;
  final Widget? bottomNavigationBar;
  final Widget child;

  const FloorLayoutBody({
    super.key,
    this.floatingActionButton,
    this.sideChildren = const [],
    required this.child,
    this.title,
    this.actions,
    this.customPop,
    this.bottomNavigationBar,
  });

  @override
  State<FloorLayoutBody> createState() => _FloorLayoutBodyState();
}

class _FloorLayoutBodyState extends State<FloorLayoutBody> {
  @override
  Widget build(BuildContext context) {
    Widget buildBody() => LayoutBuilder(
          builder: (context, constraints) {
            return ConstrainedBox(
              constraints: BoxConstraints(minWidth: constraints.maxWidth, minHeight: constraints.maxHeight),
              child: widget.child,
            );
          },
        );

    return Scaffold(
      appBar: useDesktopLayout
          ? null
          : FloorAppBar(
              title: widget.title,
              actions: widget.actions,
              showBackButton: !useDesktopLayout,
              customPop: widget.customPop,
            ),
      floatingActionButton: widget.floatingActionButton,
      backgroundColor: useDesktopLayout ? colorScheme.surfaceContainer : null,
      body: useDesktopLayout
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (widget.sideChildren.isEmpty && widget.title == null)
                  SizedBox(width: AppSizes.kComponentHeight)
                else
                  SizedBox(
                    width: 6 * AppSizes.kComponentHeight,
                    child: SingleChildScrollView(
                      padding: EdgeInsets.all(AppSizes.kGap),
                      child: ColumnGap(
                        gap: AppSizes.kSmallGap,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          widget.title,
                          ...widget.sideChildren,
                        ].whereType<Widget>().toList(),
                      ),
                    ),
                  ),
                Expanded(
                  child: ShadowBox(
                    isShowing: Theme.of(context).brightness == Brightness.light,
                    child: Padding(
                      padding: EdgeInsets.only(top: AppSizes.kGap),
                      child: FloorCard(
                        color: Theme.of(context).colorScheme.surface,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(AppSizes.kComponentHeight / 2),
                          topRight: Radius.circular(AppSizes.kComponentHeight / 2),
                        ),
                        usePadding: false,
                        child: buildBody(),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: AppSizes.kComponentHeight + AppSizes.kSmallGap,
                  child: SingleChildScrollView(
                    padding: EdgeInsets.only(
                      top: AppSizes.kSmallGap,
                      right: AppSizes.kSmallGap,
                      bottom: AppSizes.kSmallGap,
                    ),
                    child: ColumnGap(
                      gap: AppSizes.kSmallGap,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: widget.actions ?? [],
                    ),
                  ),
                ),
              ],
            )
          : buildBody(),
      bottomNavigationBar: widget.bottomNavigationBar,
    );
  }
}
