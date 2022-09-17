import 'package:common_widgets/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/bloc_provider_alias.dart';
import '../../../di/di_config.dart';
import '../../bl/search/search_page_cubit.dart';
import '../../core/widgets/common/default_back_button.dart';
import 'widgets/widgets.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: <BlocProviderAlias>[
        BlocProvider<SearchPageCubit>(
          create: (_) => getIt<SearchPageCubit>(),
        ),
      ],
      child: const _Content(),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content();

  @override
  Widget build(BuildContext context) {
    const EdgeInsets padding = EdgeInsets.symmetric(horizontal: 18);

    return TapOutsideToClearFocus(
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Padding(
                padding: padding,
                child: Row(
                  children: const <Widget>[
                    DefaultBackButton(),
                    Expanded(child: FieldSearch()),
                  ],
                ),
              ),
              const Expanded(child: Users()),
            ],
          ),
        ),
      ),
    );
  }
}
