import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:static_i18n/static_i18n.dart';

import '../../../bl/sign_up/sign_up_page_cubit.dart';
import '../../../i18n/translation_keys.dart';

class Conditions extends StatelessWidget {
  const Conditions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Row(
      children: <Widget>[
        BlocBuilder<SignUpPageCubit, SignUpPageState>(
          buildWhen: (SignUpPageState previous, SignUpPageState current) =>
              previous.agreedToConditions != current.agreedToConditions,
          builder: (_, SignUpPageState state) {
            return Checkbox(
              value: state.agreedToConditions,
              onChanged: (bool? value) =>
                  context.read<SignUpPageCubit>().onToggleConditions(isSelected: value),
            );
          },
        ),
        Expanded(
          child: Text.rich(
            TextSpan(
              text: TkSignUp.captionAgreeWithProvided.i18n,
              style: const TextStyle(fontSize: 15),
              children: <InlineSpan>[
                TextSpan(
                  text: TkSignUp.termsOfService.i18n,
                  style: TextStyle(color: theme.colorScheme.secondary),
                  recognizer: TapGestureRecognizer()
                    ..onTap = context.read<SignUpPageCubit>().onTermsOfServicePressed,
                ),
                TextSpan(text: TkSignUp.and.i18n),
                TextSpan(
                  text: TkSignUp.privacyPolicy.i18n,
                  style: TextStyle(color: theme.colorScheme.secondary),
                  recognizer: TapGestureRecognizer()
                    ..onTap = context.read<SignUpPageCubit>().onPrivacyPolicyPressed,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
