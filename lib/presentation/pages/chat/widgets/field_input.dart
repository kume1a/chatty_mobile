import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../bl/chat/chat_page_cubit.dart';
import '../../../core/values/assets.dart';

class FieldInput extends StatelessWidget {
  const FieldInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return SizedBox(
      height: 42,
      width: double.infinity,
      child: Stack(
        children: <Widget>[
          Positioned.fill(
            child: TextField(
              maxLength: 2055,
              controller: context.read<ChatPageCubit>().inputEditingController,
              focusNode: context.read<ChatPageCubit>().inputFocusNode,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 46),
                counterText: '',
                hintText: 'Aa',
              ),
            ),
          ),
          Positioned(
            left: 12,
            bottom: 8,
            child: GestureDetector(
              onTap: context.read<ChatPageCubit>().onMorePressed,
              child: Container(
                width: 26,
                height: 26,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: theme.primaryColor,
                  borderRadius: BorderRadius.circular(2),
                ),
                child: BlocBuilder<ChatPageCubit, ChatPageState>(
                  builder: (_, ChatPageState state) {
                    return SvgPicture.asset(
                      state.isSendOptionsShowing ? Assets.iconClose : Assets.iconDashboard,
                      width: 12,
                      height: 12,
                    );
                  },
                ),
              ),
            ),
          ),
          Positioned(
            right: 12,
            bottom: 8,
            child: Container(
              width: 26,
              height: 26,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: theme.colorScheme.onSecondaryContainer,
                borderRadius: BorderRadius.circular(2),
              ),
              child: SvgPicture.asset(
                Assets.iconEmoji,
                width: 16,
                height: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
