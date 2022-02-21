import 'package:common_models/common_models.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/failures/authentication/sign_in_failure.dart';
import '../../../domain/managers/authentication_manager.dart';
import '../../core/routes/screens_navigator.dart';
import '../../dialogs/core/dialog_manager.dart';
import '../../toasts/core/toast_notifier.dart';
import '../../toasts/failure_notifiers/sign_in_failure_notifier.dart';

part 'sign_in_page_cubit.freezed.dart';

@freezed
class SignInPageState with _$SignInPageState {
  const factory SignInPageState({
    required bool showErrors,
    required EmailVVO email,
    required PasswordVVO password,
    required bool isPasswordFieldObscured,
  }) = _SignInPageState;

  factory SignInPageState.initial() => SignInPageState(
        showErrors: false,
        email: EmailVVO.empty(),
        password: PasswordVVO.empty(),
        isPasswordFieldObscured: true,
      );
}

@injectable
class SignInPageCubit extends Cubit<SignInPageState> {
  SignInPageCubit(
    this._screensNavigator,
    this._toastNotifier,
    this._dialogManager,
    this._authenticationManager,
    this._signInFailureNotifier,
  ) : super(SignInPageState.initial());

  final ScreensNavigator _screensNavigator;
  final ToastNotifier _toastNotifier;
  final DialogManager _dialogManager;
  final AuthenticationManager _authenticationManager;
  final SignInFailureNotifier _signInFailureNotifier;

  void onEmailChanged(String value) => emit(state.copyWith(email: EmailVVO(value)));

  void onPasswordChanged(String value) => emit(state.copyWith(password: PasswordVVO(value)));

  void onObscurePasswordPressed() =>
      emit(state.copyWith(isPasswordFieldObscured: !state.isPasswordFieldObscured));

  Future<void> onGooglePressed() async {
    _toastNotifier.notify(
      message: 'Functionality not implemented yet',
      title: 'Not implemented',
    );
  }

  Future<void> onFacebookPressed() async {
    _toastNotifier.notify(
      message: 'Functionality not implemented yet',
      title: 'Not implemented',
    );
  }

  Future<void> onSignInPressed() async {
    emit(state.copyWith(showErrors: true));

    if (!state.email.isValid || !state.password.isValid) {
      return;
    }

    _dialogManager.showLoadingOverlay();
    final Either<SignInFailure, Unit> result = await _authenticationManager.signIn(
      email: state.email.getOrThrow.trim(),
      password: state.password.getOrThrow.trim(),
    );
    await _dialogManager.closeOverlays();

    result.fold(
      _signInFailureNotifier.notify,
      (_) => _screensNavigator.toChatsPage(),
    );
  }

  void onSignUpPressed() => _screensNavigator.toSignUpPage();
}
