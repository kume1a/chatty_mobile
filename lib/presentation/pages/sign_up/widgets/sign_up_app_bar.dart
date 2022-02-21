import 'package:flutter/material.dart';
import 'package:static_i18n/static_i18n.dart';

import '../../../core/widgets/common/default_back_button.dart';
import '../../../i18n/translation_keys.dart';

class SignUpAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SignUpAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return AppBar(
      backgroundColor: theme.primaryColor,
      title: Text(TkCommon.signUp.i18n),
      centerTitle: true,
      elevation: 0,
      automaticallyImplyLeading: false,
      leading: const DefaultBackButton(),
    );
  }

  @override
  Size get preferredSize => const Size(0, 70);
}
