import 'package:common_models/common_models.dart';
import 'package:common_widgets/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:static_i18n/static_i18n.dart';

import '../../../../domain/models/user/user.dart';
import '../../../bl/chats/chats_page_cubit.dart';
import '../../../bl/core/shared_blocs/current_user_cubit.dart';
import '../../../core/values/assets.dart';
import '../../../i18n/translation_keys.dart';

class Header extends StatelessWidget {
  const Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          TkCommon.messages.i18n,
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        GestureDetector(
          onTap: context.read<ChatsPageCubit>().onProfilePressed,
          child: BlocBuilder<CurrentUserCubit, DataState<FetchFailure, User>>(
            builder: (_, DataState<FetchFailure, User> state) {
              return SafeImage.withAssetPlaceholder(
                url: state.get?.profileImageUrl,
                placeholderAssetPath: Assets.imageDefaultProfile,
                width: 42,
                height: 42,
              );
            },
          ),
        ),
      ],
    );
  }
}
