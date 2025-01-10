import 'package:flutter/material.dart';

Future<T?> pushNoAnimation<T>(BuildContext context, {required Widget widget}) => Navigator.of(context).push<T>(
      PageRouteBuilder(pageBuilder: (_, __, ___) => widget, transitionDuration: Duration(seconds: 0)),
    );
