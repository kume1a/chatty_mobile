import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../bl/chat/chat_page_cubit.dart';
import '../../../bl/chat/chat_page_image_cubit.dart';
import '../../../bl/chat/chat_page_input_cubit.dart';
import '../../../core/values/assets.dart';

class SendOptionsWrapper extends StatefulWidget {
  const SendOptionsWrapper({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  State<SendOptionsWrapper> createState() => _SendOptionsWrapperState();
}

class _SendOptionsWrapperState extends State<SendOptionsWrapper>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  late final Animation<double> _translationAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _translationAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
      reverseCurve: Curves.easeInCubic,
    );
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final MediaQueryData mediaQueryData = MediaQuery.of(context);

    return BlocListener<ChatPageInputCubit, ChatPageInputState>(
      listener: (_, ChatPageInputState state) {
        if (state.isSendOptionsShowing) {
          _controller.forward();
        } else {
          _controller.reverse();
        }
      },
      child: Stack(
        children: <Widget>[
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 200,
              color: theme.primaryColor,
            ),
          ),
          Positioned(
            left: 12,
            right: 12,
            bottom: mediaQueryData.padding.bottom + 12,
            child: const _SendOptions(),
          ),
          AnimatedBuilder(
            animation: _translationAnimation,
            builder: (_, Widget? child) {
              return Positioned(
                left: 0,
                right: 0,
                top: 0,
                bottom: _translationAnimation.value * 142,
                child: Container(
                  height: 150,
                  decoration: BoxDecoration(
                    color: theme.scaffoldBackgroundColor,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(_translationAnimation.value * 12),
                      bottomRight: Radius.circular(_translationAnimation.value * 12),
                    ),
                  ),
                ),
              );
            },
          ),
          AnimatedBuilder(
            animation: _translationAnimation,
            builder: (_, Widget? child) {
              return Positioned(
                left: 0,
                right: 0,
                top: 0,
                bottom: _translationAnimation.value * 142 +
                    mediaQueryData.padding.bottom * (1 - _translationAnimation.value),
                child: child!,
              );
            },
            child: widget.child,
          ),
        ],
      ),
    );
  }
}

class _SendOptions extends StatelessWidget {
  const _SendOptions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: _SendOption(
            assetName: Assets.iconCamera,
            onPressed: context.read<ChatPageImageCubit>().onCameraPressed,
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: _SendOption(
            assetName: Assets.iconVideoCamera,
            onPressed: context.read<ChatPageCubit>().onVideoCameraPressed,
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: _SendOption(
            assetName: Assets.iconDocument,
            onPressed: context.read<ChatPageCubit>().onDocumentPressed,
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: _SendOption(
            assetName: Assets.iconMicrophone,
            onPressed: context.read<ChatPageCubit>().onVoicePressed,
          ),
        ),
      ],
    );
  }
}

class _SendOption extends StatelessWidget {
  const _SendOption({
    Key? key,
    required this.assetName,
    required this.onPressed,
  }) : super(key: key);

  final String assetName;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return GestureDetector(
      onTap: onPressed,
      child: AspectRatio(
        aspectRatio: 1,
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: theme.colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(4),
          ),
          child: SvgPicture.asset(
            assetName,
            width: 28,
            height: 28,
          ),
        ),
      ),
    );
  }
}
