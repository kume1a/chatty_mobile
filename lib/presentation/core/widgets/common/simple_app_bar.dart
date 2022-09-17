import 'package:flutter/material.dart';

import 'default_back_button.dart';

class SimpleAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SimpleAppBar({
    super.key,
    this.title,
    this.centerTitle = true,
  });

  final String? title;
  final bool centerTitle;

  @override
  Size get preferredSize => const Size(0, 64);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return AppBar(
      elevation: 0,
      backgroundColor: theme.primaryColor,
      centerTitle: centerTitle,
      title: title != null
          ? Text(
              title!,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            )
          : null,
      automaticallyImplyLeading: false,
      leading: const DefaultBackButton(),
    );
  }
}
