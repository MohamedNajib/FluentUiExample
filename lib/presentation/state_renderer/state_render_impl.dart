import 'package:fluent_ui/fluent_ui.dart';

import '../src/strings_manager.dart';
import '../src/values_manager.dart';
import 'state_renderer.dart';

abstract class FlowState {
  StateRendererType get getStateRendererType;

  String get getMessage;
}

class ContentState extends FlowState {
  ContentState();

  @override
  String get getMessage => EMPTY;

  @override
  StateRendererType get getStateRendererType => StateRendererType.contentState;
}

class LoadingState extends FlowState {
  final bool isPopup;
  final String message;

  LoadingState({required this.isPopup, this.message = 'Loading'});

  @override
  String get getMessage => message;

  @override
  StateRendererType get getStateRendererType => StateRendererType.popupLoadingState;
}

class ErrorState extends FlowState {
  final bool isPopup;
  final String message;

  ErrorState({required this.isPopup, this.message = EMPTY});

  @override
  String get getMessage => message;

  @override
  StateRendererType get getStateRendererType => StateRendererType.popupErrorState;
}

class SuccessState extends FlowState {
  String message;

  SuccessState(this.message);

  @override
  String get getMessage => message;

  @override
  StateRendererType get getStateRendererType => StateRendererType.popupSuccessState;
}

class EmptyState extends FlowState {
  String message;

  EmptyState(this.message);

  @override
  String get getMessage => message;

  @override
  StateRendererType get getStateRendererType =>
      StateRendererType.fullScreenEmptyState;
}


extension FlowStateExtension on FlowState {
  Widget getScreenWidget(BuildContext context, Widget contentScreenWidget, Function retryActionFunction) {
    if(this is ContentState){
      dismissDialog(context);
      return contentScreenWidget;
    }
    if(this is LoadingState){
      dismissDialog(context);
      if (getStateRendererType == StateRendererType.popupLoadingState) {
        showPopUp(context, getStateRendererType, getMessage, retryActionFunction);
        return contentScreenWidget;
      } else {
        return StateRenderer(stateRendererType: getStateRendererType, message: getMessage, retryActionFunction: retryActionFunction);
      }
    }
    if(this is ErrorState){
      dismissDialog(context);
      if (getStateRendererType == StateRendererType.popupErrorState) {
        showPopUp(context, getStateRendererType, getMessage, retryActionFunction, title: AppStrings.error);
        return contentScreenWidget;
      } else {
        return StateRenderer(stateRendererType: getStateRendererType, message: getMessage, retryActionFunction: retryActionFunction);
      }
    }
    if(this is SuccessState){
      dismissDialog(context);
      showPopUp(context, StateRendererType.popupSuccessState, getMessage, retryActionFunction, title: AppStrings.success);
      return contentScreenWidget;
    }

    if(this is EmptyState){
      //dismissDialog(context);
      return StateRenderer(
          stateRendererType: getStateRendererType,
          message: getMessage,
          retryActionFunction: retryActionFunction);
    }
    dismissDialog(context);
    return contentScreenWidget;
  }

  void dismissDialog(BuildContext context) {
    if (_isThereCurrentDialogShowing(context)) {
      Navigator.of(context, rootNavigator: true).pop(true);
    }
  }

  bool _isThereCurrentDialogShowing(BuildContext context) => ModalRoute.of(context)?.isCurrent != true;

  void showPopUp(BuildContext context, StateRendererType stateRendererType, String message, Function retryActionFunction, {String title = EMPTY}) {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return StateRenderer(
              stateRendererType: stateRendererType,
              message: message,
              title: title,
              retryActionFunction: retryActionFunction,
            );
          });
    });
  }
}