import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../bl/chat/chat_page_input_cubit.dart';
import '../../../core/values/assets.dart';

class ButtonSend extends StatelessWidget {
  const ButtonSend({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return GestureDetector(
      onTap: context.read<ChatPageInputCubit>().onSendPressed,
      child: Container(
        width: 42,
        height: 42,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: theme.colorScheme.secondaryContainer,
        ),
        child: BlocBuilder<ChatPageInputCubit, ChatPageInputState>(
          buildWhen: (ChatPageInputState previous, ChatPageInputState current) =>
              previous.isSendButtonEnabled != current.isSendButtonEnabled,
          builder: (_, ChatPageInputState state) {
            return SvgPicture.asset(
              Assets.iconSend,
              width: 20,
              height: 20,
              color: state.isSendButtonEnabled
                  ? theme.primaryColor
                  : theme.primaryColor.withOpacity(.6),
            );
          },
        ),
      ),
    );
  }
}
