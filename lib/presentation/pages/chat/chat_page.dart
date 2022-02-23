import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/bloc_provider_alias.dart';
import '../../../di/di_config.dart';
import '../../bl/chat/chat_page_cubit.dart';
import '../../core/routes/route_arguments/chat_page_args.dart';
import 'widgets/widgets.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({
    Key? key,
    required this.args,
  }) : super(key: key);

  final ChatPageArgs args;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: <BlocProviderAlias>[
        BlocProvider<ChatPageCubit>(
          create: (_) => getIt<ChatPageCubit>(),
        )
      ],
      child: const _Content(),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ChatAppBar(),
      body: SafeArea(
        bottom: false,
        child: SendOptionsWrapper(
          child: Column(
            children: <Widget>[
              const Expanded(child: Messages()),
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
      ),
    );
  }
}
