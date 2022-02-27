import 'package:common_models/common_models.dart';
import 'package:common_widgets/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/models/user/user.dart';
import '../../../bl/core/shared_blocs/current_user_cubit.dart';
import '../../../core/values/assets.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return BlocBuilder<CurrentUserCubit, DataState<FetchFailure, User>>(
      builder: (_, DataState<FetchFailure, User> state) {
        return state.maybeWhen(
          success: (User data) => Row(
            children: <Widget>[
              SafeImage.withAssetPlaceholder(
                url: data.profileImageUrl,
                placeholderAssetPath: Assets.imageDefaultProfile,
                width: 68,
                height: 68,
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    data.fullName,
                    style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    data.email,
                    style: TextStyle(color: theme.secondaryHeaderColor, fontSize: 13),
                  ),
                ],
              ),
            ],
          ),
          orElse: () => const SizedBox.shrink(),
        );
      },
    );
  }
}
