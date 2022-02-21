import 'package:common_widgets/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:static_i18n/static_i18n.dart';

import '../../../i18n/translation_keys.dart';

class Header extends StatelessWidget {
  const Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          TkCommon.messages.i18n,
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const BlankContainer(
          width: 42,
          height: 42,
          borderRadius: 4,
          color: Colors.grey,
        ),
      ],
    );
  }
}
