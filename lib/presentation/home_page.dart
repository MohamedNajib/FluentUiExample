import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/foundation.dart';
import 'package:shareholder/app/appCubit/app_cubit.dart';
import 'package:window_manager/window_manager.dart';

import 'settings_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WindowListener {
  bool value = false;

  int index = 0;

  final settingsController = ScrollController();
  final viewKey = GlobalKey();

  @override
  void initState() {
    windowManager.addListener(this);
    super.initState();
  }

  @override
  void dispose() {
    windowManager.removeListener(this);
    settingsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = AppCubit.get(context);
    return NavigationView(
      key: viewKey,
      appBar: NavigationAppBar(
        title: () {
          if (kIsWeb) return const Text("app Title");
          return const DragToMoveArea(
            child: Align(
              alignment: AlignmentDirectional.centerStart,
              child: Text("app Title"),
            ),
          );
        }(),
        actions: kIsWeb
            ? null
            : DragToMoveArea(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [Spacer(), WindowButtons()],
          ),
        ),
      ),
      pane: NavigationPane(
        selected: index,
        onChanged: (i) => setState(() => index = i),
        size: const NavigationPaneSize(
          openMinWidth: 250,
          openMaxWidth: 320,
        ),
        header: Container(
          height: kOneLineTileHeight,
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: const FlutterLogo(
            style: FlutterLogoStyle.horizontal,
            size: 100,
          ),
        ),
        displayMode: appTheme.displayMode,
        indicator: () {
          switch (appTheme.indicator) {
            case NavigationIndicators.end:
              return const EndNavigationIndicator();
            case NavigationIndicators.sticky:
            default:
              return const StickyNavigationIndicator();
          }
        }(),
        items: [
          // PaneItem(
          //   icon: const Icon(FluentIcons.checkbox_composite),
          //   title: const Text('Inputs'),
          // ),
          // PaneItem(
          //   icon: const Icon(FluentIcons.text_field),
          //   title: const Text('Forms'),
          // ),
          // PaneItemSeparator(),
          // PaneItem(
          //   icon: const Icon(FluentIcons.color),
          //   title: const Text('Colors'),
          // ),
          // PaneItem(
          //   icon: const Icon(FluentIcons.icon_sets_flag),
          //   title: const Text('Icons'),
          // ),
          // PaneItem(
          //   icon: const Icon(FluentIcons.plain_text),
          //   title: const Text('Typography'),
          // ),
          // PaneItem(
          //   icon: const Icon(FluentIcons.cell_phone),
          //   title: const Text('Mobile'),
          // ),
          // PaneItem(
          //   icon: const Icon(FluentIcons.toolbox),
          //   title: const Text('Command bars'),
          // ),
          // PaneItem(
          //   icon: const Icon(FluentIcons.pop_expand),
          //   title: const Text('Popups, Flyouts and Context Menus'),
          // ),
          // PaneItem(
          //   icon: Icon(
          //     appTheme.displayMode == PaneDisplayMode.top
          //         ? FluentIcons.more
          //         : FluentIcons.more_vertical,
          //   ),
          //   title: const Text('Others'),
          //   infoBadge: const InfoBadge(
          //     source: Text('9'),
          //   ),
          // ),
        ],
        autoSuggestBox: AutoSuggestBox(
          controller: TextEditingController(),
          items: const ['Item 1', 'Item 2', 'Item 3', 'Item 4'],
        ),
        autoSuggestBoxReplacement: const Icon(FluentIcons.search),
        footerItems: [
          PaneItemSeparator(),
          PaneItem(
            icon: const Icon(FluentIcons.settings),
            title: const Text('Settings'),
          ),
          // _LinkPaneItemAction(
          //   icon: const Icon(FluentIcons.open_source),
          //   title: const Text('Source code'),
          //   link: 'https://github.com/bdlukaa/fluent_ui',
          // ),
        ],
      ),
      content: NavigationBody(index: index, children: [
        Settings(controller: settingsController),
      ]),
    );
  }

  @override
  void onWindowClose() async {
    bool _isPreventClose = await windowManager.isPreventClose();
    if (_isPreventClose) {
      showDialog(
        context: context,
        builder: (_) {
          return ContentDialog(
            title: const Text('Confirm close'),
            content: const Text('Are you sure you want to close this window?'),
            actions: [
              FilledButton(
                child: const Text('Yes'),
                onPressed: () {
                  Navigator.pop(context);
                  windowManager.destroy();
                },
              ),
              Button(
                child: const Text('No'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        },
      );
    }
  }
}

class WindowButtons extends StatelessWidget {
  const WindowButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = FluentTheme.of(context);

    return SizedBox(
      width: 138,
      height: 50,
      child: WindowCaption(
        brightness: theme.brightness,
        backgroundColor: Colors.transparent,
      ),
    );
  }
}