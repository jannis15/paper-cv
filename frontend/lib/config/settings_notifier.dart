import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paper_cv/config/supported_locales.dart';
import 'settings_repository.dart';
import 'settings.dart';

class SettingsNotifier extends StateNotifier<Settings> {
  SettingsNotifier(super.settings);

  Future<void> setLocale(String locale) async {
    final isSupportedLanguage = SupportedLocale.values.map((value) => value.key).contains(locale);
    final internalLocale = isSupportedLanguage ? locale : 'en';
    await SettingsRepository.instance.saveLocale(internalLocale);
    state = state.copyWith(locale: internalLocale);
  }

  Future<void> setShowAdBanner(bool showAdBanner) async {
    await SettingsRepository.instance.saveShowAdBanner(showAdBanner);
    state = state.copyWith(showAdBanner: showAdBanner);
  }
}

final settingsFutureProvider = FutureProvider<Settings>((ref) async {
  final settings = await SettingsRepository.instance.loadSettings();
  return settings;
});

final settingsNotifierProvider = StateNotifierProvider<SettingsNotifier, Settings>((ref) {
  final settings = ref.watch(settingsFutureProvider).value;
  if (settings == null) {
    throw Exception('Settings are not loaded yet');
  }
  return SettingsNotifier(settings);
});
