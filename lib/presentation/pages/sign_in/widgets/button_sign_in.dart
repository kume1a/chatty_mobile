import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:static_i18n/static_i18n.dart';

import '../../../bl/sign_in/sign_in_page_cubit.dart';
import '../../../i18n/translation_keys.dart';

class ButtonSignIn extends StatelessWidget {
  const ButtonSignIn({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: context.read<SignInPageCubit>().onSignInPressed,
      child: Text(TkCommon.signIn.i18n),
    );
  }
}
