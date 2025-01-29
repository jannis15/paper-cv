import 'dart:async';
import 'package:flutter/foundation.dart';

abstract class OffloadTask {
  static Future<T> runInBackground<T, P>(Future<T> Function(P input) operation, P input) async {
    if (kIsWeb) {
      return await operation(input);
    } else {
      return compute(_execute, _TaskParams(operation, input));
    }
  }

  static Future<T> _execute<T, P>(_TaskParams<T, P> params) async {
    return params.operation(params.input);
  }
}

class _TaskParams<T, P> {
  final Future<T> Function(P input) operation;
  final P input;

  _TaskParams(this.operation, this.input);
}
