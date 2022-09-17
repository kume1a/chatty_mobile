import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../di/di_config.dart';
import '../../bl/init/init_page_cubit.dart';

class InitPage extends StatelessWidget {
  const InitPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<InitPageCubit>(
      create: (_) => getIt<InitPageCubit>()..init(),
      lazy: false,
      child: const Scaffold(),
    );
  }
}
