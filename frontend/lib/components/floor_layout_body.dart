import 'package:flutter/material.dart';
import 'package:paper_cv/components/floor_card.dart';
import 'package:paper_cv/config/config.dart';
import 'package:paper_cv/utils/widget_utils.dart';

class FloorLayoutBody extends StatefulWidget {
  final Widget child;
  final List<Widget> sideChildren;

  const FloorLayoutBody({super.key, required this.child, required this.sideChildren});

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

    return useDesktopLayout
        ? Column(
            children: [
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 6 * AppSizes.kComponentHeight,
                      child: SingleChildScrollView(
                        padding: EdgeInsets.all(AppSizes.kGap),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: widget.sideChildren,
                        ),
                      ),
                    ),
                    Expanded(
                      child: FloorCard(
                        color: colorScheme.surface,
                        borderRadius: BorderRadius.circular(AppSizes.kComponentHeight / 2),
                        usePadding: false,
                        child: buildBody(),
                      ),
                    ),
                    SizedBox(width: AppSizes.kComponentHeight),
                  ],
                ),
              ),
              SizedBox(height: AppSizes.kGap),
            ],
          )
        : buildBody();
  }
}
