import 'package:fluent_ui/fluent_ui.dart';
import 'package:shareholder/app/appCubit/app_cubit.dart';
import 'package:shareholder/presentation/theme.dart';

import '../app/functions.dart';



class Settings extends StatelessWidget {
  const Settings({Key? key, this.controller}) : super(key: key);

  final ScrollController? controller;

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMediaQuery(context));
    final appTheme = AppCubit.get(context);
    const spacer = SizedBox(height: 10.0);
    const biggerSpacer = SizedBox(height: 40.0);
    return ScaffoldPage.scrollable(
      header: const PageHeader(title: Text('Settings')),
      scrollController: controller,
      children: [
         SettingsSection(sectionTitle: 'Theme mode', sectionWidget: ThemeModeWidget(appTheme: appTheme)),
         SettingsSection(sectionTitle: 'Navigation Pane Display Mode', sectionWidget: NavigationDisplayWidget(appTheme: appTheme)),
         biggerSpacer,
        Text('Accent Color',
            style: FluentTheme.of(context).typography.subtitle),
        spacer,
        Wrap(children: [
          ...List.generate(Colors.accentColors.length, (index) {
            final color = Colors.accentColors[index];
            return Tooltip(
              message: accentColorNames[index + 1],
              child: _buildColorBlock(appTheme, color),
            );
          }),
        ]),
      ],
    );
  }
  Widget _buildColorBlock(AppCubit appTheme, AccentColor color) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Button(
        onPressed: () {
          appTheme.color = color;
        },
        style: ButtonStyle(
          padding: ButtonState.all(EdgeInsets.zero),
          backgroundColor: ButtonState.resolveWith((states) {
            if (states.isPressing) {
              return color.light;
            } else if (states.isHovering) {
              return color.lighter;
            }
            return color;
          }),
        ),
        child: Container(
          height: 40,
          width: 40,
          alignment: Alignment.center,
          child: appTheme.color == color
              ? Icon(
            FluentIcons.check_mark,
            color: color.basedOnLuminance(),
            size: 22.0,
          )
              : null,
        ),
      ),
    );
  }
}

class SettingsSection extends StatelessWidget {
  final String sectionTitle;
  final Widget sectionWidget;
  SettingsSection({Key? key, required this.sectionTitle, required this.sectionWidget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 40.0),
        Text(sectionTitle,
            style: FluentTheme.of(context).typography.subtitle),
        const SizedBox(height: 10.0),
        sectionWidget,
      ],
    );
  }
}

class ThemeModeWidget extends StatelessWidget {
  final  AppCubit appTheme;
  ThemeModeWidget({Key? key, required this.appTheme}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppCubit appTheme = AppCubit.get(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: ThemeMode.values.map((item) {
        final mode = item;
        return Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: RadioButton(
            checked: appTheme.mode == mode,
            onChanged: (value) {
              if (value) {
                appTheme.mode = mode;
                if (kIsWindowEffectsSupported) {
                  // some window effects require on [dark] to look good.
                  appTheme.setEffect(appTheme.windowEffect, context);
                }
              }
            },
            content: Text('$mode'.replaceAll('ThemeMode.', '')),
          ),
        );
      }
    ).toList(),
    );
  }
}
class NavigationDisplayWidget extends StatelessWidget {
  final  AppCubit appTheme;
  NavigationDisplayWidget({Key? key, required this.appTheme}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: PaneDisplayMode.values.map((item) {
        final mode = item;
        return Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: RadioButton(
            checked: appTheme.displayMode == mode,
            onChanged: (value) {
              if (value) appTheme.displayMode = mode;
            },
            content: Text(
              mode.toString().replaceAll('PaneDisplayMode.', ''),
            ),
          ),
        );
      }).toList(),
    );
  }
}

