import 'package:common_models/common_models.dart';
import 'package:common_widgets/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/models/user/user.dart';
import '../../../bl/chats/chats_page_cubit.dart';
import '../../../bl/chats/chats_page_recommended_users_cubit.dart';
import '../../../core/values/assets.dart';

class RecommendedUsers extends StatelessWidget {
  const RecommendedUsers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 94,
      child: BlocBuilder<ChatsPageRecommendedUsersCubit, DataState<FetchFailure, List<User>>>(
        builder: (_, DataState<FetchFailure, List<User>> state) {
          return state.maybeWhen(
            success: (List<User> data) => ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              scrollDirection: Axis.horizontal,
              itemCount: data.length,
              itemBuilder: (_, int index) => _Item(user: data[index]),
            ),
            orElse: () => const SizedBox.shrink(),
          );
        },
      ),
    );
  }
}

class _Item extends StatelessWidget {
  const _Item({
    Key? key,
    required this.user,
  }) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9),
      width: 80,
      child: GestureDetector(
        onTap: () => context.read<ChatsPageCubit>().onUserPressed(user),
        child: Column(
          children: <Widget>[
            SafeImage.withAssetPlaceholder(
              url: user.profileImageUrl,
              width: 46,
              height: 46,
              placeholderAssetPath: Assets.imageDefaultProfile,
            ),
            const SizedBox(height: 6),
            Text(
              user.fullName,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}
