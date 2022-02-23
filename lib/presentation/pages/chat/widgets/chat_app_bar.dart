import 'package:common_widgets/common_widgets.dart';
import 'package:flutter/material.dart';

import '../../../core/values/assets.dart';
import '../../../core/values/palette.dart';
import '../../../core/widgets/common/default_back_button.dart';

class ChatAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ChatAppBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size(0, 60);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return SafeArea(
      bottom: false,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        color: theme.scaffoldBackgroundColor,
        child: Row(
          children: <Widget>[
            const DefaultBackButton(),
            const SizedBox(height: 10),
            const SafeImage.withAssetPlaceholder(
              url: null,
              placeholderAssetPath: Assets.imageDefaultProfile,
              width: 36,
              height: 36,
              borderRadius: 2,
            ),
            const SizedBox(width: 6),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: const <Widget>[
                  Text(
                    'name',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    'online',
                    style: TextStyle(fontSize: 12, color: Palette.online),
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
