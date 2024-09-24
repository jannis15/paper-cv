import 'package:floor_cv/components/floor_app_bar.dart';
import 'package:flutter/material.dart';

class FloorMainScreen extends StatefulWidget {
  const FloorMainScreen({super.key});

  @override
  State<FloorMainScreen> createState() => _FloorMainScreenState();
}

class _FloorMainScreenState extends State<FloorMainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FloorAppBar(
        title: Text('Demo'),
      ),
      body: Placeholder(),
    );
  }
}
