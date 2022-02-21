import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:static_i18n/static_i18n.dart';

import '../../../bl/sign_in/sign_in_page_cubit.dart';
import '../../../core/values/assets.dart';
import '../../../i18n/translation_keys.dart';

class ButtonGoogle extends StatelessWidget {
  const ButtonGoogle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _SocialButton(
      label: TkSignIn.google.i18n,
      assetName: Assets.iconGoogle,
      onPressed: context.read<SignInPageCubit>().onGooglePressed,
    );
  }
}

class ButtonFacebook extends StatelessWidget {
  const ButtonFacebook({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _SocialButton(
      label: TkSignIn.facebook.i18n,
      assetName: Assets.iconFacebook,
      onPressed: context.read<SignInPageCubit>().onFacebookPressed,
    );
  }
}

class _SocialButton extends StatelessWidget {
  const _SocialButton({
    Key? key,
    required this.label,
    required this.assetName,
    required this.onPressed,
  }) : super(key: key);

  final String label;
  final String assetName;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 120,
        height: 40,
        decoration: BoxDecoration(
          border: Border.all(color: theme.primaryColorDark),
          borderRadius: BorderRadius.circular(4),
          color: Colors.transparent,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SvgPicture.asset(
              assetName,
              width: 18,
              height: 18,
            ),
            const SizedBox(width: 12),
            Text(label),
          ],
        ),
      ),
    );
  }
}
