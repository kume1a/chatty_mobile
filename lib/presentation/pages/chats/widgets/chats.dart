import 'package:common_models/common_models.dart';
import 'package:common_widgets/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:static_i18n/static_i18n.dart';
import 'package:timeago/timeago.dart';

import '../../../../domain/models/chat/chat.dart';
import '../../../bl/chats/chats_page_chats_cubit.dart';
import '../../../bl/chats/chats_page_cubit.dart';
import '../../../core/values/assets.dart';

class Chats extends StatelessWidget {
  const Chats({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatsPageChatsCubit, DataState<FetchFailure, DataPage<Chat>>>(
      builder: (_, DataState<FetchFailure, DataPage<Chat>> state) {
        return state.maybeWhen(
          success: (DataPage<Chat> data) => SliverList(
            delegate: SliverChildBuilderDelegate(
              (_, int index) => _Item(chat: data.items[index]),
              childCount: data.items.length,
            ),
          ),
          orElse: () => const SliverToBoxAdapter(),
        );
      },
    );
  }
}

class _Item extends StatelessWidget {
  const _Item({
    required this.chat,
  });

  final Chat chat;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return GestureDetector(
      onTap: () => context.read<ChatsPageCubit>().onChatPressed(chat),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 9),
        color: theme.scaffoldBackgroundColor,
        child: Row(
          children: <Widget>[
            SafeImage.withAssetPlaceholder(
              url: chat.user?.profileImageUrl,
              placeholderAssetPath: Assets.imageDefaultProfile,
              width: 46,
              height: 46,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          chat.user?.fullName ?? '',
                          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 12),
                      if (chat.lastMessage?.createdAt != null)
                        Text(
                          formatElapsedTime(
                            chat.lastMessage!.createdAt!,
                            locale: StaticI18N.locale?.languageCode,
                            short: true,
                          ),
                          style: TextStyle(fontSize: 13, color: theme.secondaryHeaderColor),
                        ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          chat.lastMessage?.textMessage ?? '',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 12),
                      // Container(
                      //   padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 5),
                      //   decoration: BoxDecoration(
                      //     borderRadius: BorderRadius.circular(2),
                      //     color: theme.colorScheme.secondary,
                      //   ),
                      //   child: const Text(
                      //     '1',
                      //     style: TextStyle(color: Colors.white, fontSize: 11),
                      //   ),
                      // ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
