import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_acrylic/flutter_acrylic.dart' as flutter_acrylic;
import 'package:shareholder/presentation/login/basePage.dart';
import 'package:shareholder/presentation/settings_page.dart';

import '../presentation/home_page.dart';
import '../presentation/login/loginCubit/login_cubit.dart';
import '../presentation/login_page.dart';
import '../presentation/theme.dart';
import 'appCubit/app_cubit.dart';
import 'app_prefs.dart';
import 'di.dart' as di;

class MyApp extends StatefulWidget {
  /// private named constructor.
  const MyApp._internal();

  /// single instance -- singleton.
  static const MyApp instance = MyApp._internal();

  /// factory for the class instance
  factory MyApp() => instance;

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }


  @override
  void dispose() {
    super.dispose();
  }


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProviders(
      child: BlocConsumer<AppCubit, AppState>(
        listener: (context, state) {
        },
        builder: (context, state) {
          return FluentApp(
            debugShowCheckedModeBanner: false,
            theme: theme(context),
            darkTheme: darkTheme(context),
            themeMode:  AppCubit.get(context).mode,
            home: const MyHomePage(),
            // onGenerateRoute: RouteGenerator.getRoute,
            // initialRoute: Routes.landingRoute,
            builder: (context, child) {
              return Directionality(
                textDirection: AppCubit.get(context).textDirection,
                child: NavigationPaneTheme(
                  data: NavigationPaneThemeData(
                    backgroundColor: AppCubit.get(context).windowEffect !=
                        flutter_acrylic.WindowEffect.disabled
                        ? Colors.transparent
                        : null,
                  ),
                  child: child!,
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class BlocProviders extends StatelessWidget {
  final Widget child;

  const BlocProviders({Key? key, required this.child}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => di.instance<AppCubit>()..start()),
        BlocProvider(create: (context) => di.instance<LoginCubit>()),
      ],
      child: child,
    );
  }
}

