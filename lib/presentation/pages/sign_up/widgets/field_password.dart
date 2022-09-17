import 'package:common_models/common_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:static_i18n/static_i18n.dart';

import '../../../bl/sign_up/sign_up_page_cubit.dart';
import '../../../core/values/assets.dart';
import '../../../i18n/translation_keys.dart';

class FieldPassword extends StatelessWidget {
  const FieldPassword({super.key});

  @override
  Widget build(_) {
    return BlocBuilder<SignUpPageCubit, SignUpPageState>(
      buildWhen: (SignUpPageState previous, SignUpPageState current) =>
          previous.isPasswordFieldObscured != current.isPasswordFieldObscured,
      builder: (BuildContext context, SignUpPageState state) {
        return TextFormField(
          maxLength: 255,
          obscureText: state.isPasswordFieldObscured,
          decoration: InputDecoration(
            hintText: TkCommon.password.i18n,
            counterText: '',
            suffixIconConstraints: BoxConstraints.tight(const Size(42, 42)),
            suffixIcon: GestureDetector(
              onTap: context.read<SignUpPageCubit>().onObscurePasswordFieldPressed,
              child: Padding(
                padding: const EdgeInsets.only(right: 12, left: 8),
                child: SvgPicture.asset(
                  state.isPasswordFieldObscured ? Assets.iconEye : Assets.iconEyeOff,
                ),
              ),
            ),
          ),
          onChanged: context.read<SignUpPageCubit>().onPasswordChanged,
          validator: (_) => context.read<SignUpPageCubit>().state.password.value.fold(
                (PasswordFailure l) => l.maybeWhen(
                  tooShort: () => TkValidationError.shortPassword.i18n,
                  empty: () => TkValidationError.fieldIsRequired.i18n,
                  orElse: () => null,
                ),
                (_) => null,
              ),
        );
      },
    );
  }
}
