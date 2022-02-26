import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:static_i18n/static_i18n.dart';

import '../../../core/bloc_provider_alias.dart';
import '../../../di/di_config.dart';
import '../../bl/chats/chats_page_chats_cubit.dart';
import '../../bl/chats/chats_page_cubit.dart';
import '../../bl/chats/chats_page_recommended_users_cubit.dart';
import '../../bl/core/realtime_data_broadcast_cubit.dart';
import '../../i18n/translation_keys.dart';
import 'widgets/widgets.dart';

class ChatsPage extends StatelessWidget {
  const ChatsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: <BlocProviderAlias>[
        BlocProvider<RealtimeDataBroadcastCubit>(
          create: (_) => getIt<RealtimeDataBroadcastCubit>()..init(),
          lazy: false,
        ),
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
      body: SafeArea(
        top: false,
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Positioned.fill(child: ColoredBox(color: theme.primaryColor)),
                Padding(
                  padding: EdgeInsets.fromLTRB(18, mediaQueryData.padding.top + 18, 18, 16),
                  child: const Header(),
                ),
              ],
            ),
            Expanded(
              child: CustomScrollView(
                slivers: <Widget>[
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: 197,
                      child: Stack(
                        children: <Widget>[
                          Positioned.fill(child: ColoredBox(color: theme.primaryColor)),
                          Column(
                            children: <Widget>[
                              const SizedBox(height: 28),
                              const Padding(
                                padding: padding,
                                child: FieldSearch(),
                              ),
                              const SizedBox(height: 24),
                              const RecommendedUsers(),
                              Expanded(
                                child: Container(
                                  height: 16,
                                  decoration: BoxDecoration(
                                    color: theme.scaffoldBackgroundColor,
                                    borderRadius: const BorderRadius.vertical(
                                      top: Radius.circular(8),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.fromLTRB(18, 12, 18, 0),
                    sliver: SliverToBoxAdapter(
                      child: Text(
                        TkCommon.recent.i18n,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: theme.secondaryHeaderColor,
                        ),
                      ),
                    ),
                  ),
                  const Chats(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
