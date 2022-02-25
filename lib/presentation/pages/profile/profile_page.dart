import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../di/di_config.dart';
import '../../bl/profile/profile_page_cubit.dart';
import '../../core/widgets/common/simple_app_bar.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProfilePageCubit>(
      create: (_) => getIt<ProfilePageCubit>(),
      child: const _Content(),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SimpleAppBar(),
      body: SafeArea(
        child: TextButton(
          onPressed: context.read<ProfilePageCubit>().onLogoutPressed,
          child: const Text('logout'),
        ),
      ),
    );
  }
}
