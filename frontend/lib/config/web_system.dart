import 'package:drift/drift.dart';

String platformException(Object e) {
  if (e is DriftWrappedException) {
    return 'WEB ERROR: ${e.cause}';
  }
  return '';
}
