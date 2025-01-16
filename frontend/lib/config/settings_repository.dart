import 'package:shared_preferences/shared_preferences.dart';
import 'settings.dart';

class SettingsRepository {
  SettingsRepository._();

  static final SettingsRepository _instance = SettingsRepository._();

  static SettingsRepository get instance => _instance;

  Future<Settings> loadSettings() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final localeString = sharedPreferences.getString('locale');
    final showAdBanner = sharedPreferences.getBool('showAdBanner');
    return Settings(
      locale: localeString ?? Settings().locale,
      showAdBanner: showAdBanner ?? Settings().showAdBanner,
    );
  }

  Future<void> saveLocale(String locale) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString('locale', locale);
  }

  Future<void> saveShowAdBanner(bool showAdBanner) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setBool('showAdBanner', showAdBanner);
  }
}
