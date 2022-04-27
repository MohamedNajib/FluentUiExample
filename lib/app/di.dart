import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../presentation/login/loginCubit/login_cubit.dart';
import 'appCubit/app_cubit.dart';
import 'app_prefs.dart';

final instance = GetIt.instance;
//final GetIt instance = GetIt.I..allowReassignment = true;

Future<void> init() async {
  /// Features ->
  instance.registerFactory<AppCubit>(
          () => AppCubit(appPreferences: instance<AppPreferences>()));
  instance.registerFactory<LoginCubit>(
          () => LoginCubit());
  final sharedPrefs = await SharedPreferences.getInstance();
  instance.registerLazySingleton<SharedPreferences>(
        () => sharedPrefs,
  );

  // app prefs instance
  instance.registerLazySingleton<AppPreferences>(
        () => AppPreferences(instance<SharedPreferences>()),
  );
}