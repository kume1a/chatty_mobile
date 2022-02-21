import 'package:common_models/common_models.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../core/routes/screens_navigator.dart';

part 'sign_up_page_cubit.freezed.dart';

@freezed
class SignUpPageState with _$SignUpPageState {
  const factory SignUpPageState({
    required bool showErrors,
    required NameVVO firstName,
    required NameVVO lastName,
    required EmailVVO email,
    required PasswordVVO password,
    required RepeatedPasswordVVO repeatedPassword,
    required bool agreedToConditions,
    required bool isPasswordFieldObscured,
    required bool isRepeatedPasswordFieldObscured,
  }) = _SignUpPageState;

  factory SignUpPageState.initial() => SignUpPageState(
        showErrors: false,
        firstName: NameVVO.empty(),
        lastName: NameVVO.empty(),
        email: EmailVVO.empty(),
        password: PasswordVVO.empty(),
        repeatedPassword: RepeatedPasswordVVO.empty(),
        agreedToConditions: false,
        isPasswordFieldObscured: true,
        isRepeatedPasswordFieldObscured: true,
      );
}

@injectable
class SignUpPageCubit extends Cubit<SignUpPageState> {
  SignUpPageCubit(
    this._screensNavigator,
  ) : super(SignUpPageState.initial());

  final ScreensNavigator _screensNavigator;

  String _repeatedPasswordValue = '';

  void onFirstNameChanged(String value) => emit(state.copyWith(firstName: NameVVO(value)));

  void onLastNameChanged(String value) => emit(state.copyWith(lastName: NameVVO(value)));

  void onEmailChanged(String value) => emit(state.copyWith(email: EmailVVO(value)));

  void onPasswordChanged(String value) => emit(state.copyWith(
        password: PasswordVVO(value),
        repeatedPassword: RepeatedPasswordVVO(value, _repeatedPasswordValue),
      ));

  void onRepeatedPasswordChanged(String value) {
    _repeatedPasswordValue = value;
    emit(state.copyWith(
      repeatedPassword: RepeatedPasswordVVO(state.password.get ?? '', value),
    ));
  }

  void onObscurePasswordFieldPressed() =>
      emit(state.copyWith(isPasswordFieldObscured: !state.isPasswordFieldObscured));

  void onObscureRepeatedPasswordFieldPressed() =>
      emit(state.copyWith(isRepeatedPasswordFieldObscured: !state.isRepeatedPasswordFieldObscured));

  void onTermsOfServicePressed() => _screensNavigator.toTermsOfServicePage();

  void onPrivacyPolicyPressed() => _screensNavigator.toPrivacyPolicyPage();

  void onToggleConditions({required bool? isSelected}) =>
      emit(state.copyWith(agreedToConditions: isSelected ?? false));

  Future<void> onSignUpPressed() async {
    emit(state.copyWith(showErrors: true));
  }
}
