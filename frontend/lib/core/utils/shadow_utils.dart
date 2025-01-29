import 'package:flutter/material.dart';

final boxShadow = [
  BoxShadow(
    color: Colors.grey.withOpacity(0.5),
    blurRadius: 10.0,
    spreadRadius: 1.0,
    offset: Offset(0, 2),
  ),
];

class ShadowBox extends StatefulWidget {
  final Widget? child;
  final bool isShowing;

  const ShadowBox({super.key, this.child, this.isShowing = true});

  @override
  State<ShadowBox> createState() => _ShadowBoxState();
}

class _ShadowBoxState extends State<ShadowBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: widget.isShowing ? BoxDecoration(boxShadow: boxShadow) : null,
      child: widget.child,
    );
  }
}
