import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:static_i18n/static_i18n.dart';

import '../../../i18n/translation_keys.dart';

class ButtonSettings {
  ButtonSettings._();

  static TextButton newInstance() {
    return TextButton(
      onPressed: () => openAppSettings(),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.white12),
        shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(6))),
        padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 12, vertical: 4)),
      ),
      child: Text(TkCommon.settings.i18n),
    );
  }
}
