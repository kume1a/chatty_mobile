import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/bloc_provider_alias.dart';
import '../../../di/di_config.dart';
import '../../bl/chats/chats_page_chats_cubit.dart';
import '../../bl/chats/chats_page_cubit.dart';
import '../../bl/chats/chats_page_recommended_users_cubit.dart';
import 'widgets/widgets.dart';

class ChatsPage extends StatelessWidget {
  const ChatsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: <BlocProviderAlias>[
        BlocProvider<ChatsPageCubit>(
          create: (_) => getIt<ChatsPageCubit>(),
        ),
        BlocProvider<ChatsPageRecommendedUsersCubit>(
          create: (_) => getIt<ChatsPageRecommendedUsersCubit>()..init(),
        ),
        BlocProvider<ChatsPageChatsCubit>(
          create: (_) => getIt<ChatsPageChatsCubit>()..init(),
        ),
      ],
      child: const _Content(),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final MediaQueryData mediaQueryData = MediaQuery.of(context);

    const EdgeInsets padding = EdgeInsets.symmetric(horizontal: 18);

    return Scaffold(
      backgroundColor: theme.primaryColor,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: <Widget>[
            const Padding(
              padding: padding,
              child: Header(),
            ),
            const SizedBox(height: 12),
            const Expanded(
              child: CustomScrollView(
                slivers: <Widget>[
                  SliverList(
                    delegate: SliverChildListDelegate.fixed(
                      <Widget>[
                        SizedBox(height: 28),
                        Padding(
                          padding: padding,
                          child: FieldSearch(),
                        ),
                        SizedBox(height: 32),
                        RecommendedUsers(),
                        SizedBox(height: 16),
                        CaptionRecent(),
                      ],
                    ),
                  ),
                  Chats(),
                ],
              ),
            ),
            Container(
              height: mediaQueryData.padding.bottom,
              color: theme.scaffoldBackgroundColor,
            ),
          ],
        ),
      ),
    );
  }
}
