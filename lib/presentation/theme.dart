import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_acrylic/flutter_acrylic.dart';
import 'package:shareholder/app/appCubit/app_cubit.dart';
import 'package:system_theme/system_theme.dart';

import '../app/functions.dart';

const int systemThemeMode = 1;
const int lightThemeMode = 2;
const int darkThemeMode = 3;

ThemeData? darkTheme(BuildContext context) => ThemeData(
  brightness: Brightness.dark,
  accentColor: AppCubit.get(context).color,
  visualDensity: VisualDensity.standard,
  focusTheme: FocusThemeData(
    glowFactor: is10footScreen() ? 2.0 : 0.0,
  ),
);

ThemeData? theme(BuildContext context) => ThemeData(
  accentColor: AppCubit.get(context).color,
  visualDensity: VisualDensity.standard,
  focusTheme: FocusThemeData(
    glowFactor: is10footScreen() ? 2.0 : 0.0,
  ),
);

AccentColor get systemAccentColor {
  if (defaultTargetPlatform == TargetPlatform.windows ||
      defaultTargetPlatform == TargetPlatform.android ||
      kIsWeb) {
    return AccentColor('normal', {
      'darkest': SystemTheme.accentColor.darkest,
      'darker': SystemTheme.accentColor.darker,
      'dark': SystemTheme.accentColor.dark,
      'normal': SystemTheme.accentColor.accent,
      'light': SystemTheme.accentColor.light,
      'lighter': SystemTheme.accentColor.lighter,
      'lightest': SystemTheme.accentColor.lightest,
    });
  }
  return Colors.blue;
}

const List<String> accentColorNames = [
  'System',
  'Yellow',
  'Orange',
  'Red',
  'Magenta',
  'Purple',
  'Blue',
  'Teal',
  'Green',
];

List<WindowEffect> get currentWindowEffects {
  if (kIsWeb) return [];

  if (defaultTargetPlatform == TargetPlatform.windows) {
    return windowsWindowEffects;
  } else if (defaultTargetPlatform == TargetPlatform.linux) {
    return linuxWindowEffects;
  } else if (defaultTargetPlatform == TargetPlatform.macOS) {
    return macosWindowEffects;
  }

  return [];
}