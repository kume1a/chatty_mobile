import 'package:common_models/common_models.dart';
import 'package:common_widgets/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/models/user/user.dart';
import '../../../bl/chat/chat_page_user_cubit.dart';
import '../../../core/values/assets.dart';
import '../../../core/widgets/common/default_back_button.dart';

class ChatAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ChatAppBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size(0, 60);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return SafeArea(
      bottom: false,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        color: theme.scaffoldBackgroundColor,
        child: Row(
          children: <Widget>[
            const DefaultBackButton(),
            const SizedBox(height: 10),
            const _UserProfileImage(),
            const SizedBox(width: 6),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  BlocBuilder<ChatPageUserCubit, DataState<FetchFailure, User>>(
                    builder: (_, DataState<FetchFailure, User> state) {
                      return Text(
                        state.get?.fullName ?? '',
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                      );
                    },
                  ),
                  // const Text(
                  //   'online',
                  //   style: TextStyle(fontSize: 12, color: Palette.online),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _UserProfileImage extends StatelessWidget {
  const _UserProfileImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatPageUserCubit, DataState<FetchFailure, User>>(
      builder: (_, DataState<FetchFailure, User> state) {
        return SafeImage.withAssetPlaceholder(
          url: state.get?.profileImageUrl,
          placeholderAssetPath: Assets.imageDefaultProfile,
          width: 36,
          height: 36,
          borderRadius: 2,
        );
      },
    );
  }
}
