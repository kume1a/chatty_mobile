import 'package:common_models/common_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:static_i18n/static_i18n.dart';

import '../../../bl/sign_in/sign_in_page_cubit.dart';
import '../../../core/values/assets.dart';
import '../../../i18n/translation_keys.dart';

class FieldPassword extends StatelessWidget {
  const FieldPassword({Key? key}) : super(key: key);

  @override
  Widget build(_) {
    return BlocBuilder<SignInPageCubit, SignInPageState>(
      buildWhen: (SignInPageState previous, SignInPageState current) =>
          previous.isPasswordFieldObscured != current.isPasswordFieldObscured,
      builder: (BuildContext context, SignInPageState state) {
        return TextFormField(
          maxLength: 255,
          obscureText: state.isPasswordFieldObscured,
          decoration: InputDecoration(
            hintText: TkCommon.password.i18n,
            counterText: '',
            prefixIconConstraints: BoxConstraints.tight(const Size(42, 42)),
            prefixIcon: Padding(
              padding: const EdgeInsets.only(left: 12, right: 8),
              child: SvgPicture.asset(
                Assets.iconLock,
                width: 20,
                height: 20,
              ),
            ),
            suffixIconConstraints: BoxConstraints.tight(const Size(42, 42)),
            suffixIcon: GestureDetector(
              onTap: context.read<SignInPageCubit>().onObscurePasswordPressed,
              child: Padding(
                padding: const EdgeInsets.only(right: 12, left: 8),
                child: SvgPicture.asset(
                  state.isPasswordFieldObscured ? Assets.iconEye : Assets.iconEyeOff,
                  width: 20,
                  height: 20,
                ),
              ),
            ),
          ),
          onChanged: context.read<SignInPageCubit>().onPasswordChanged,
          validator: (_) => context.read<SignInPageCubit>().state.password.value.fold(
                (PasswordFailure l) => l.whenOrNull(
                  shortPassword: () => TkValidationErrors.shortPassword.i18n,
                  empty: () => TkValidationErrors.fieldIsRequired.i18n,
                ),
                (_) => null,
              ),
        );
      },
    );
  }
}
