import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_acrylic/flutter_acrylic.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../presentation/state_renderer/state_render_impl.dart';
import '../app_prefs.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  final AppPreferences appPreferences;

  AppCubit({required this.appPreferences}) : super(AppInitial());

  static AppCubit get(context) => BlocProvider.of<AppCubit>(context);


  void start(){
    initTheme();
  }

  initTheme(){
    appPreferences.getThemeMode();
    appPreferences.getAccentColor();
    emit(AppChangeThemeState());
  }

  AccentColor get color => accentColor;
  set color(AccentColor color) {
    appPreferences.setAccentColor(Colors.accentColors.indexOf(color)).then((value) => emit(AppChangeThemeState()));
  }

  ThemeMode get mode => currentThemeMode;
  set mode(ThemeMode mode) {
    appPreferences.setThemeMode(mode).then((value) => emit(AppChangeThemeState()));
  }

  PaneDisplayMode _displayMode = PaneDisplayMode.auto;
  PaneDisplayMode get displayMode => _displayMode;
  set displayMode(PaneDisplayMode displayMode) {
    _displayMode = displayMode;
    emit(AppChangeThemeState());
  }

  NavigationIndicators _indicator = NavigationIndicators.sticky;
  NavigationIndicators get indicator => _indicator;
  set indicator(NavigationIndicators indicator) {
    _indicator = indicator;
    emit(AppChangeThemeState());
  }

  WindowEffect _windowEffect = WindowEffect.disabled;
  WindowEffect get windowEffect => _windowEffect;
  set windowEffect(WindowEffect windowEffect) {
    _windowEffect = windowEffect;
    emit(AppChangeThemeState());
  }

  void setEffect(WindowEffect effect, BuildContext context) {
    Window.setEffect(
      effect: effect,
      color: [
        WindowEffect.solid,
        WindowEffect.acrylic,
      ].contains(effect)
          ? FluentTheme.of(context).micaBackgroundColor.withOpacity(0.05)
          : Colors.transparent,
      dark: FluentTheme.of(context).brightness.isDark,
    );
  }

  TextDirection _textDirection = TextDirection.rtl;
  TextDirection get textDirection => _textDirection;
  set textDirection(TextDirection direction) {
    _textDirection = direction;
    emit(AppChangeThemeState());
  }
}
enum NavigationIndicators { sticky, end }