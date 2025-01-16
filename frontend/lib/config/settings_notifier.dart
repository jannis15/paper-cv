import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'settings_repository.dart';
import 'settings.dart';

class SettingsNotifier extends StateNotifier<Settings> {
  SettingsNotifier(super.settings);

  Future<void> setLocale(String locale) async {
    await SettingsRepository.instance.saveLocale(locale);
    state = state.copyWith(locale: locale);
  }

  Future<void> toggleAdBanner(bool showAdBanner) async {
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
