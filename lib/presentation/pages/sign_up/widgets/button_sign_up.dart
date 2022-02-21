import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:static_i18n/static_i18n.dart';

import '../../../bl/sign_up/sign_up_page_cubit.dart';
import '../../../i18n/translation_keys.dart';

class ButtonSignUp extends StatelessWidget {
  const ButtonSignUp({Key? key}) : super(key: key);

  @override
  Widget build(_) {
    return BlocBuilder<SignUpPageCubit, SignUpPageState>(
      buildWhen: (SignUpPageState previous, SignUpPageState current) =>
          previous.agreedToConditions != current.agreedToConditions,
      builder: (BuildContext context, SignUpPageState state) {
        return TextButton(
          onPressed:
              state.agreedToConditions ? context.read<SignUpPageCubit>().onSignUpPressed : null,
          child: Text(TkCommon.signUp.i18n),
        );
      },
    );
  }
}
