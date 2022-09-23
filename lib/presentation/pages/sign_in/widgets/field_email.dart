import 'package:common_models/common_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:static_i18n/static_i18n.dart';

import '../../../bl/sign_in/sign_in_page_cubit.dart';
import '../../../core/values/assets.dart';
import '../../../i18n/translation_keys.dart';

class FieldEmail extends StatelessWidget {
  const FieldEmail({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLength: 255,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        hintText: TkCommon.email.i18n,
        counterText: '',
        prefixIconConstraints: BoxConstraints.tight(const Size(42, 42)),
        prefixIcon: Padding(
          padding: const EdgeInsets.only(left: 12, right: 8),
          child: SvgPicture.asset(
            Assets.iconEmail,
            width: 20,
            height: 20,
          ),
        ),
      ),
      onChanged: context.read<SignInPageCubit>().onEmailChanged,
      validator: (_) => context.read<SignInPageCubit>().state.email.failureToString(
            (ValueFailure l) => l.when(
              empty: () => TkValidationError.fieldIsRequired.i18n,
              invalid: () => TkValidationError.invalidEmail.i18n,
            ),
          ),
    );
  }
}
