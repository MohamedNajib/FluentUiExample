import 'package:fluent_ui/fluent_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../presentation/theme.dart';

const String prefsKeyLang = "PREFS_KEY_LANG";
const String prefsKeyMode = "PREFS_KEY_MODE";
const String themeModeKey = "ThemeModeKey";
const String accentColorKey = "AccentColor";


bool isDarkMode = false;
bool isRTL = false;
ThemeMode currentThemeMode = ThemeMode.system;
AccentColor accentColor = systemAccentColor;

class AppPreferences {
  final SharedPreferences _sharedPreferences;

  AppPreferences(this._sharedPreferences);

  Future<String> getAppLanguage() async {
    String? language = _sharedPreferences.getString(prefsKeyLang);

    if (language != null && language.isNotEmpty) {
      return language;
    } else {
      return LanguageType.english.getValue();
    }
  }

  Future<void> setLanguageChanged() async {
    String currentLanguage = await getAppLanguage();
    if (currentLanguage == LanguageType.arabic.getValue()) {
      // save prefs with english lang
      isRTL = false;
      _sharedPreferences.setString(prefsKeyLang, LanguageType.english.getValue());
    } else {
      // save prefs with arabic lang
      isRTL = true;
      _sharedPreferences.setString(prefsKeyLang, LanguageType.arabic.getValue());
    }
  }

  Future<Locale> getLocal() async {
    String currentLanguage = await getAppLanguage();
    if (currentLanguage == LanguageType.arabic.getValue()) {
      // return arabic local
      isRTL = true;
      return arabicLocal;
    } else {
      // return english local
      isRTL = false;
      return englishLocale;
    }
  }

  Future<bool> setUIMode() async {
    bool uiDarkMode = await getUIMode();
    isDarkMode = !uiDarkMode;
    return await _sharedPreferences.setBool(prefsKeyMode, !uiDarkMode);
  }

  Future<bool> getUIMode() async {
    isDarkMode = _sharedPreferences.getBool(prefsKeyMode) ?? false;
    return isDarkMode;
  }
  Future<bool> setThemeMode(ThemeMode themeMode) async {
    late int theme;
    if(themeMode == ThemeMode.system){
      theme = systemThemeMode;
    } else if(themeMode == ThemeMode.light){
      theme = lightThemeMode;
    } else if(themeMode == ThemeMode.dark){
      theme = darkThemeMode;
    } else {
      theme = systemThemeMode;
    }
    currentThemeMode = themeMode;
    return await _sharedPreferences.setInt(themeModeKey, theme);
  }

  Future<ThemeMode> getThemeMode() async{
    late ThemeMode theme;
    int themeMode = _sharedPreferences.getInt(themeModeKey) ?? 0;
    if(themeMode == systemThemeMode){
      theme = ThemeMode.system;
    } else if(themeMode == lightThemeMode){
      theme = ThemeMode.light;
    } else if(themeMode == darkThemeMode){
      theme = ThemeMode.dark;
    } else {
      theme = ThemeMode.system;
    }
    currentThemeMode = theme;
    return theme;
  }

  Future<bool> setAccentColor(int index) async {
    accentColor = Colors.accentColors[index];
    return await _sharedPreferences.setInt(accentColorKey, index);
  }

  Future<AccentColor> getAccentColor() async{
    int colorIndex = _sharedPreferences.getInt(accentColorKey) ?? 0;
    accentColor = Colors.accentColors[colorIndex];
    return accentColor;
  }
}

enum LanguageType { arabic, english }
const String arabic = "ar";
const String english = "en";

const String assetsPathLocalisations = "assets/translations";
const Locale arabicLocal = Locale("ar", "SA");
const Locale englishLocale = Locale("en", "US");

extension LanguageTypeExtension on LanguageType {
  String getValue() {
    switch (this) {
      case LanguageType.english:
        return arabic;
      case LanguageType.arabic:
        return english;
    }
  }
}