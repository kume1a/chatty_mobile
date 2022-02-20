import 'package:flutter/material.dart';

import '../../core/routes/route_arguments/chat_page_args.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({
    Key? key,
    required this.args,
  }) : super(key: key);

  final ChatPageArgs args;

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('chat'),
      ),
    );
  }
}
