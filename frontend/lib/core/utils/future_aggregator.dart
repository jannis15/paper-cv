import 'dart:async';

abstract class FutureAggregator {
  static Future<List<Result<T>>> waitForAll<T>(List<Future<T>> futures) async {
    final List<Result<T>> results = [];
    final List<Future<void>> wrappedFutures = futures.map((future) async {
      try {
        final value = await future;
        results.add(Result.success(value));
      } catch (error, stackTrace) {
        results.add(Result.failure(error, stackTrace));
      }
    }).toList();

    // Wait for all futures to complete
    await Future.wait(wrappedFutures);

    return results;
  }
}

class Result<T> {
  final T? value;
  final Object? error;
  final StackTrace? stackTrace;

  bool get isSuccess => error == null;

  bool get isFailure => error != null;

  Result.success(this.value)
      : error = null,
        stackTrace = null;

  Result.failure(this.error, this.stackTrace) : value = null;

  @override
  String toString() {
    if (isSuccess) {
      return 'Success: $value';
    } else {
      return 'Failure: $error\nStackTrace: $stackTrace';
    }
  }
}
