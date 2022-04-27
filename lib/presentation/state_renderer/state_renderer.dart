import 'package:fluent_ui/fluent_ui.dart';
import 'package:lottie/lottie.dart';

import '../src/assets_manager.dart';
import '../src/font_manager.dart';
import '../src/styles_manager.dart';
import '../src/values_manager.dart';


enum StateRendererType {
  // Dialog State
  popupLoadingState,
  popupErrorState,
  popupSuccessState,
  // // FULL SCREEN STATES
  // FULL_SCREEN_LOADING_STATE,
  // FULL_SCREEN_ERROR_STATE,
  contentState, // THE UI OF THE SCREEN
  fullScreenEmptyState
}

class StateRenderer extends StatelessWidget {
  final StateRendererType stateRendererType;
  final String message;
  final String title;
  final Function? retryActionFunction;

  const StateRenderer(
      {Key? key,
      required this.stateRendererType,
      String? message,
      String? title,
      required this.retryActionFunction})
      : message = message ?? "",
        title = title ?? "",
        super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (stateRendererType) {
      case StateRendererType.popupLoadingState:
        return const PopUpDialogWidget(
          width: 100,
          height: 200,
          children: [AnimatedImageWidget(animationName: JsonAssets.loading), MessageWidget(message: 'Loading..'),],
        );
      case StateRendererType.popupErrorState:
        return PopUpDialogWidget(children: [
          const AnimatedImageWidget(animationName: JsonAssets.error),
          MessageWidget(message: message),
          ButtonWidget(buttonTitle: "ok", actionFunction: retryActionFunction),
        ]);
      case StateRendererType.popupSuccessState:
        return PopUpDialogWidget(children: [
          const AnimatedImageWidget(),
          MessageWidget(message: title),
          MessageWidget(message: message),
          ButtonWidget(buttonTitle: "ok", actionFunction: retryActionFunction),
        ]);
      case StateRendererType.contentState:
        return Container();
      case StateRendererType.fullScreenEmptyState:
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const AnimatedImageWidget(animationName: JsonAssets.empty),
            MessageWidget(message: message),
          ],
        );

      default:
        return Container();
    }
  }
}

class PopUpDialogWidget extends StatelessWidget {
  final List<Widget> children;
  final Function? retryActionFunction;
  final double? width;
  final double? height;

  const PopUpDialogWidget(
      {Key? key, required this.children, this.width = 500, this.height = 500, this.retryActionFunction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ContentDialog(
      backgroundDismiss: false,
      title: const Text('Confirm close'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: children,
      ),
      actions: [
        FilledButton(
          child: const Text('Yes'),
          onPressed: () {
            Navigator.pop(context);
            if (retryActionFunction != null) {
              retryActionFunction!();
            }
          },
        ),
        Button(
          child: const Text('No'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
      // shape: RoundedRectangleBorder(
      //     borderRadius: BorderRadius.circular(AppSize.s14)),
      // elevation: AppSize.s1_5,
      // backgroundColor: Colors.transparent,
      // child: Container(
      //   height: height,
      //   width: width,
      //   decoration: BoxDecoration(
      //       color: Colors.white,
      //       shape: BoxShape.rectangle,
      //       borderRadius: BorderRadius.circular(AppSize.s14),
      //       boxShadow: const [
      //         BoxShadow(
      //             color: Colors.black26,
      //             blurRadius: AppSize.s12,
      //             offset: Offset(AppSize.s0, AppSize.s12))
      //       ]),
      //   child: Column(
      //     mainAxisSize: MainAxisSize.min,
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     crossAxisAlignment: CrossAxisAlignment.center,
      //     children: children,
      //   ),
      // ),
    );
  }
}

class MessageWidget extends StatelessWidget {
  final String message;

  const MessageWidget({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Text(
          message,
          style: getMediumStyle(color: Colors.black, fontSize: FontSize.s16),
        ),
      ),
    );
  }
}

class ButtonWidget extends StatelessWidget {
  final String buttonTitle;
  final Function? actionFunction;

  const ButtonWidget({Key? key, required this.buttonTitle, this.actionFunction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FilledButton(
        child: Text(buttonTitle),
        onPressed: () {
          Navigator.of(context).pop();
              if (actionFunction != null) {
                actionFunction!();
              }
        },
      ),
      // PrimaryButton.normal(
      //   text: buttonTitle,
      //   onPressed: () {
      //     Navigator.of(context).pop();
      //     if (actionFunction != null) {
      //       actionFunction!();
      //     }
      //   },
      // ),
    );
  }
}

class AnimatedImageWidget extends StatelessWidget {
  final String? animationName;

  const AnimatedImageWidget({Key? key, this.animationName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppSize.s100,
      width: AppSize.s100,
      child: animationName != null
          ? Lottie.asset(animationName!)
          : const Icon(FluentIcons.warning),
    );
  }
}
