import 'package:drift/native.dart';

String platformException(Object e) {
  if (e is SqliteException) {
    return 'MESSAGE: ${e.message}\n'
        'CAUSING_STATEMENT: ${e.causingStatement}\n'
        'EXPLANATION: ${e.explanation}\n'
        'OPERATION: ${e.operation}\n'
        'PARAMETERS_TO_STATEMENT: ${e.parametersToStatement}\n'
        'EXTENDED_RESULT_CODE: ${e.extendedResultCode}';
  }
  return '';
}
