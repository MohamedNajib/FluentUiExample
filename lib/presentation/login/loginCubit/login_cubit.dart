import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../state_renderer/state_render_impl.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  static LoginCubit get(context) => BlocProvider.of<LoginCubit>(context);

  showDialog() => emit(AppDialogState(dialog: LoadingState(isPopup: true)));
  showContentState() => emit(AppDialogState(dialog: ContentState()));

}
