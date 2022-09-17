import 'package:common_models/common_models.dart';
import 'package:common_widgets/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/models/user/user.dart';
import '../../../bl/search/search_page_cubit.dart';
import '../../../core/values/assets.dart';

class Users extends StatelessWidget {
  const Users({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchPageCubit, DataState<FetchFailure, List<User>>>(
      builder: (_, DataState<FetchFailure, List<User>> state) {
        return state.maybeWhen(
          success: (List<User> data) => ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 12),
            itemBuilder: (_, int index) => _Item(user: data[index]),
            itemCount: data.length,
          ),
          orElse: () => const SizedBox.shrink(),
        );
      },
    );
  }
}

class _Item extends StatelessWidget {
  const _Item({
    required this.user,
  });

  final User user;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.read<SearchPageCubit>().onUserPressed(user),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 18),
        child: Row(
          children: <Widget>[
            const SafeImage.withAssetPlaceholder(
              url: null,
              placeholderAssetPath: Assets.imageDefaultProfile,
              width: 42,
              height: 42,
            ),
            const SizedBox(width: 10),
            Text(
              user.fullName,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
