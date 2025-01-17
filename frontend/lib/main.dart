import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:paper_cv/config/system.dart';
import 'package:paper_cv/config/text_theme.dart';
import 'package:paper_cv/generated/l10n.dart';
import 'package:paper_cv/package_info.dart';
import 'package:paper_cv/presentation/floor_main_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:flutter_localizations/flutter_localizations.dart';
import 'config/settings_notifier.dart';
import 'config/supported_locales.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  packageInfo = await PackageInfo.fromPlatform();
  FlutterError.onError = (details) {
    if (details.exception.toString().contains('overflowed')) return;
    try {
      logException(details, StackTrace.current);
    } finally {
      WidgetsBinding.instance.addPostFrameCallback((_) => showException(details.exception));
      FlutterError.presentError(details);
    }
  };
  PlatformDispatcher.instance.onError = (error, stackTrace) {
    try {
      logException(error, stackTrace);
    } finally {
      WidgetsBinding.instance.addPostFrameCallback((_) => showException(error));
    }
    return true;
  };
  final container = ProviderContainer();
  await container.read(settingsFutureProvider.future);
  timeago.setLocaleMessages('de', timeago.DeMessages());
  timeago.setLocaleMessages('en', timeago.EnMessages());
  runApp(ProviderScope(parent: container, child: MyApp()));
}

class MyApp extends ConsumerWidget {
  @override
  Widget build(_, WidgetRef ref) {
    final settings = ref.watch(settingsNotifierProvider);
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
        AppLocalizationDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: SupportedLocale.values.map((value) => value.locale).toList(),
      locale: Locale(settings.locale),
      initialRoute: '/home',
      routes: {
        '/home': (_) => const FloorMainScreen(),
      },
    );
  }
}
