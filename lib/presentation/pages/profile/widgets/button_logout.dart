import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:static_i18n/static_i18n.dart';

import '../../../bl/profile/profile_page_cubit.dart';
import '../../../i18n/translation_keys.dart';

class ButtonLogout extends StatelessWidget {
  const ButtonLogout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: context.read<ProfilePageCubit>().onLogoutPressed,
      child: Text(TkCommon.logout.i18n),
    );
  }
}
