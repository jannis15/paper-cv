import 'dart:async';

class Debouncer {
  Debouncer({required this.milliseconds});

  final int milliseconds;
  Timer? _timer;

  bool get isActive => _timer?.isActive ?? false;

  void run(void Function() action) {
    cancelTimer();
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }

  void cancelTimer() {
    if (isActive) _timer?.cancel();
  }
}
