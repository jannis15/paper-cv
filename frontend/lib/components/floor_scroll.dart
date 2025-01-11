import 'package:flutter/material.dart';

class FloorScroll extends StatefulWidget {
  final Widget child;

  const FloorScroll({super.key, required this.child});

  @override
  State<FloorScroll> createState() => _FloorScrollState();
}

class _FloorScrollState extends State<FloorScroll> {
  final ScrollController _horzController = ScrollController();
  final ScrollController _vertController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      controller: _vertController,
      thumbVisibility: true,
      child: Scrollbar(
        controller: _horzController,
        thumbVisibility: true,
        notificationPredicate: (notif) => notif.depth == 1,
        child: SingleChildScrollView(
          controller: _vertController,
          child: SingleChildScrollView(
            controller: _horzController,
            scrollDirection: Axis.horizontal,
            child: widget.child,
          ),
        ),
      ),
    );
  }
}
