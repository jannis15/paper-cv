import 'package:package_info_plus/package_info_plus.dart';
import 'package:paper_cv/config/system.dart';
import 'package:paper_cv/config/text_theme.dart';
import 'package:paper_cv/package_info.dart';
import 'package:paper_cv/presentation/floor_main_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  packageInfo = await PackageInfo.fromPlatform();
  FlutterError.onError = (details) {
    if (details.exception.toString().contains('overflowed')) return;
    FlutterError.presentError(details);
    logException(details, StackTrace.current);
    WidgetsBinding.instance.addPostFrameCallback((_) => showException(details.exception));
  };
  PlatformDispatcher.instance.onError = (error, stackTrace) {
    logException(error, stackTrace);
    WidgetsBinding.instance.addPostFrameCallback((_) => showException(error));
    return true;
  };
  timeago.setLocaleMessages('de', timeago.DeMessages());
  runApp(
    ProviderScope(
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      title: 'PaperCV',
      theme: ThemeData(
        colorSchemeSeed: Colors.teal,
        textTheme: FloorTextTheme(),
      ),
      darkTheme: ThemeData(
        colorSchemeSeed: Colors.teal,
        brightness: Brightness.dark,
        textTheme: FloorTextTheme(),
      ),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('de')],
      initialRoute: '/home',
      routes: {
        '/home': (_) => const FloorMainScreen(),
      },
    );
  }
}
