import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

extension WidgetListExtensions<Widget> on Iterable<Widget> {
  List<Widget> listSeparated({required Widget separator}) =>
      mapIndexed((index, element) => [element, if (index < length - 1) separator]).expand((element) => element).toList();
}

class FlexGap extends StatelessWidget {
  final Axis direction;
  final Widget separator;
  final List<Widget> children;
  final CrossAxisAlignment crossAxisAlignment;
  final MainAxisAlignment mainAxisAlignment;
  final MainAxisSize mainAxisSize;

  const FlexGap({
    super.key,
    required this.direction,
    required this.children,
    required this.separator,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.mainAxisSize = MainAxisSize.max,
  });

  @override
  Widget build(BuildContext context) {
    return Flex(
      textBaseline: TextBaseline.alphabetic,
      direction: direction,
      mainAxisSize: mainAxisSize,
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      children: children.listSeparated(separator: separator),
    );
  }
}

class ColumnGap extends FlexGap {
  ColumnGap({
    super.key,
    super.mainAxisAlignment,
    super.crossAxisAlignment,
    super.mainAxisSize,
    required double gap,
    required super.children,
  }) : super(direction: Axis.vertical, separator: SizedBox(height: gap));
}

class RowGap extends FlexGap {
  RowGap({
    super.key,
    super.mainAxisAlignment,
    super.crossAxisAlignment,
    super.mainAxisSize,
    required double gap,
    required super.children,
  }) : super(direction: Axis.horizontal, separator: SizedBox(width: gap));
}
