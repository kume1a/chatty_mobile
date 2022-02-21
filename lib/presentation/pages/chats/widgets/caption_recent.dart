import 'package:flutter/material.dart';
import 'package:static_i18n/static_i18n.dart';

import '../../../i18n/translation_keys.dart';

class CaptionRecent extends StatelessWidget {
  const CaptionRecent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.only(top: 12, left: 18, bottom: 6),
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      child: Text(
        TkCommon.recent.i18n,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          color: theme.secondaryHeaderColor,
        ),
      ),
    );
  }
}
