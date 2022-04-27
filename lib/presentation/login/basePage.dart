import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:window_manager/window_manager.dart';
import '../state_renderer/state_render_impl.dart';

import 'loginCubit/login_cubit.dart';

class BasePage extends StatefulWidget {
  const BasePage({Key? key}) : super(key: key);

  @override
  State<BasePage> createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> with WindowListener {
  @override
  void initState() {
    windowManager.addListener(this);
    super.initState();
  }

  @override
  void dispose() {
    windowManager.removeListener(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NavigationView(
      appBar: NavigationAppBar(
        title: () {
          if (kIsWeb) return const Text("تسجيل الدجول");
          return const DragToMoveArea(
            child: Align(
              alignment: AlignmentDirectional.centerStart,
              child: Text("تسجيل الدجول"),
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
      content: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is AppDialogState) {
            if(state.dialog is LoadingState){
              return state.dialog.getScreenWidget(context, Container(
                child: Center(
                  child: FilledButton(
                    child: Text("Button Title"),
                    onPressed: () {
                      LoginCubit.get(context).showDialog();
                    },
                  ),
                ),
              ), (){
                LoginCubit.get(context).showContentState();
              });
            }
            else if(state.dialog is ContentState){
              return Container(
                child: Center(
                  child: FilledButton(
                    child: Text("Button Title"),
                    onPressed: () {
                      LoginCubit.get(context).showDialog();
                    },
                  ),
                ),
              );
            } else {
              return Container(
                child: Center(
                  child: FilledButton(
                    child: Text("Button Title"),
                    onPressed: () {
                      LoginCubit.get(context).showDialog();
                    },
                  ),
                ),
              );
            }

          } else {
            return Container(
              child: Center(
                child: FilledButton(
                  child: Text("Button Title"),
                  onPressed: () {
                    LoginCubit.get(context).showDialog();
                  },
                ),
              ),
            );
          }
        },
      ),
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
