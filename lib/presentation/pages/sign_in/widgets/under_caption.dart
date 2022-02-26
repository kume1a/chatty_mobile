import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:static_i18n/static_i18n.dart';

import '../../../bl/sign_in/sign_in_page_cubit.dart';
import '../../../i18n/translation_keys.dart';

class UnderCaption extends StatelessWidget {
  const UnderCaption({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: TkPageSignIn.captionDontHaveAccount.i18n,
        children: <InlineSpan>[
          TextSpan(
            text: TkCommon.signUp.i18n,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = context.read<SignInPageCubit>().onSignUpPressed,
          ),
        ],
      ),
    );
  }
}
