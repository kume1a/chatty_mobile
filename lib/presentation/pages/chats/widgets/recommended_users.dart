import 'package:common_widgets/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bl/chats/chats_page_cubit.dart';
import '../../../core/values/assets.dart';

class RecommendedUsers extends StatelessWidget {
  const RecommendedUsers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 75,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        scrollDirection: Axis.horizontal,
        itemCount: 10,
        itemBuilder: (_, int index) => const _Item(),
      ),
    );
  }
}

class _Item extends StatelessWidget {
  const _Item({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 9),
      child: GestureDetector(
        onTap: context.read<ChatsPageCubit>().onUserPressed,
        child: Column(
          children: const <Widget>[
            SafeImage.withAssetPlaceholder(
              url: null,
              width: 46,
              height: 46,
              placeholderAssetPath: Assets.imageDefaultProfile,
            ),
            SizedBox(height: 6),
            Text(
              'name',
              textAlign: TextAlign.center,
              style: TextStyle(
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
