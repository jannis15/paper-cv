import 'package:dio/dio.dart';
import 'package:paper_cv/config/config.dart';
import 'package:paper_cv/utils/list_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_logs/flutter_logs.dart';
import 'mobile_system.dart' if (dart.library.html) 'web_system.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey();

Future<void> logException(Object e, StackTrace stackTrace, {String subTag = ''}) async {
  late String logMessage;
  logMessage = 'EXCEPTION_RUNTIME_TYPE: ${e.runtimeType}\n';
  final String platformMessage = platformException(e);
  if (platformMessage.isNotEmpty) {
    logMessage += platformMessage;
  } else {
    switch (e) {
      case DioException _:
        logMessage += 'OPTIONS_PATH: ${e.requestOptions.path}\n'
            'OPTIONS_HEADERS: ${e.requestOptions.headers}\n'
            'OPTIONS_HTTP_METHOD: ${e.requestOptions.method}\n'
            'RESPONSE_STATUS_CODE: ${e.response?.statusCode}\n'
            'RESPONSE_STATUS_MESSAGE: ${e.response?.statusMessage}\n'
            'RESPONSE_DATA: ${e.response?.data}\n'
            'ERROR: ${e.error}\n'
            'TYPE: ${e.type}\n'
            'MESSAGE: ${e.message}\n'
            'STACKTRACE:\n${e.stackTrace}';
        break;
      case FlutterErrorDetails _:
        logMessage += 'EXCEPTION: ${e.exception}\n'
            'DIAGNOSTIC_MODE: ${e.context}\n'
            'STACKTRACE:\n${e.stack}';
        break;
      default:
        logMessage += e.toString();
        break;
    }
  }

  if (e is! FlutterErrorDetails && e is! DioException) {
    logMessage += '\nSTACKTRACE: \n$stackTrace';
  }
  logMessage = '\n$logMessage\n';
  FlutterLogs.logError('ERROR', subTag, logMessage);
}

void showException(Object e) {
  if (e is DioException) {
    if ([DioExceptionType.connectionTimeout, DioExceptionType.connectionError].contains(e.type)) {
      showError('Keine Verbindung zur REST-API', icon: Icons.wifi_off);
    } else {
      final errorText = e.response?.data != null && e.response!.data!.toString().trim().isNotEmpty
          ? e.response!.data.toString()
          : e.error != null && e.error!.toString().isNotEmpty
              ? e.error.toString()
              : e.response?.statusMessage != null && e.response?.statusCode != null
                  ? '${e.response?.statusCode} - ${e.response?.statusMessage}'
                  : 'Unbekannter Fehler';
      showError(errorText);
    }
  } else if (e is FormatException) {
    showError(e.message);
  } else {
    showError('Fehler: $e');
  }
}

void showError(String txt, {IconData? icon}) {
  final BuildContext? context = navigatorKey.currentContext;
  if (context == null) return;
  final snackBar = SnackBar(
    backgroundColor: Theme.of(context).colorScheme.onSurface,
    duration: const Duration(seconds: 3),
    content: RowGap(
      gap: AppSizes.kGap,
      children: [
        Icon(icon ?? Icons.error, color: Theme.of(context).colorScheme.surface),
        Expanded(child: Text(txt, style: TextStyle(color: Theme.of(context).colorScheme.surface)))
      ],
    ),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
