import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/values/assets.dart';

class ButtonSend extends StatelessWidget {
  const ButtonSend({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Container(
      width: 42,
      height: 42,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: theme.colorScheme.secondaryContainer,
      ),
      child: SvgPicture.asset(
        Assets.iconSend,
        width: 20,
        height: 20,
      ),
    );
  }
}
