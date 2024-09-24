import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FloorAppBar extends ConsumerWidget implements PreferredSizeWidget {
  final Widget? title;

  FloorAppBar({required this.title});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppBar(title: title);
  }

  @override
  Size get preferredSize => const Size.fromHeight(45);
}
