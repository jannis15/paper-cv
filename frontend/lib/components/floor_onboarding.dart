import 'package:flutter/material.dart';

class FloorOnboarding extends StatefulWidget {
  final Widget child;

  const FloorOnboarding({super.key, required this.child});

  @override
  State<FloorOnboarding> createState() => _FloorOnboardingState();
}

class _FloorOnboardingState extends State<FloorOnboarding> {
  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
