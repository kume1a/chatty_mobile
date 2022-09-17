import 'package:common_models/common_models.dart';
import 'package:common_widgets/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/bloc_provider_alias.dart';
import '../../../di/di_config.dart';
import '../../../domain/models/chat/chat.dart';
import '../../bl/chat/chat_page_cubit.dart';
import '../../bl/chat/chat_page_file_cubit.dart';
import '../../bl/chat/chat_page_image_cubit.dart';
import '../../bl/chat/chat_page_input_cubit.dart';
import '../../bl/chat/chat_page_messages_cubit.dart';
import '../../bl/chat/chat_page_user_cubit.dart';
import '../../core/navigation/route_arguments/chat_page_args.dart';
import 'widgets/widgets.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({
    super.key,
    required this.args,
  });

  final ChatPageArgs args;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: <BlocProviderAlias>[
        BlocProvider<ChatPageCubit>(
          create: (_) => getIt<ChatPageCubit>()..init(args),
        ),
        BlocProvider<ChatPageMessagesCubit>(
          create: (_) => getIt<ChatPageMessagesCubit>()..init(args),
          lazy: false,
        ),
        BlocProvider<ChatPageInputCubit>(
          create: (_) => getIt<ChatPageInputCubit>()..init(args),
          lazy: false,
        ),
        BlocProvider<ChatPageUserCubit>(
          create: (_) => getIt<ChatPageUserCubit>()..init(args),
          lazy: false,
        ),
        BlocProvider<ChatPageImageCubit>(
          create: (_) => getIt<ChatPageImageCubit>()..init(args),
          lazy: false,
        ),
        BlocProvider<ChatPageFileCubit>(
          create: (_) => getIt<ChatPageFileCubit>()..init(args),
          lazy: false,
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
    return Scaffold(
      appBar: const ChatAppBar(),
      body: SafeArea(
        bottom: false,
        child: BlocBuilder<ChatPageCubit, DataState<FetchFailure, Chat>>(
          builder: (_, DataState<FetchFailure, Chat> state) {
            return state.maybeWhen(
              success: (Chat data) => SendOptionsWrapper(
                child: Column(
                  children: <Widget>[
                    const Expanded(
                      child: CustomScrollView(
                        reverse: true,
                        slivers: <Widget>[
                          SliverSizedBox.shrink(),
                          Messages(),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      child: Row(
                        children: const <Widget>[
                          Expanded(child: FieldInput()),
                          SizedBox(width: 8),
                          ButtonSend(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
              failure: (_, __) => Center(
                child: IconButton(
                  onPressed: context.read<ChatPageCubit>().onRefresh,
                  icon: const Icon(Icons.refresh),
                ),
              ),
              orElse: () => const SizedBox.shrink(),
            );
          },
        ),
      ),
    );
  }
}
