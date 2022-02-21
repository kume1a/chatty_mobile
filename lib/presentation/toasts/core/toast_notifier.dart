import 'package:flutter/material.dart';
import 'package:global_navigator/global_navigator.dart';
import 'package:injectable/injectable.dart';
import 'package:static_i18n/static_i18n.dart';

import '../../core/values/palette.dart';
import '../../i18n/translation_keys.dart';

@lazySingleton
class ToastNotifier {
  void notify({
    required String message,
    required String title,
    VoidCallback? onTap,
  }) {
    _notify(
      message: message,
      title: title,
      onTap: onTap,
    );
  }

  void notifyError({
    required String message,
    String title = '',
    Icon? icon = const Icon(Icons.cancel_outlined, color: Palette.error),
    TextButton? mainButton,
  }) {
    _notify(
      message: message,
      title: title,
      icon: icon,
      mainButton: mainButton,
    );
  }

  void notifyInfo({
    required String message,
    String title = '',
    Icon? icon = const Icon(Icons.done_rounded, color: Palette.success),
    TextButton? mainButton,
  }) {
    _notify(
      message: message,
      title: title,
      icon: icon,
      mainButton: mainButton,
    );
  }

  void notifyWarning({
    required String message,
    String title = '',
    Icon? icon = const Icon(Icons.info_outline, color: Palette.warning),
    TextButton? mainButton,
  }) {
    _notify(
      message: message,
      title: title,
      icon: icon,
      mainButton: mainButton,
    );
  }

  void notifyNetworkError({
    String? message,
    String? title,
    Icon? icon = const Icon(Icons.wifi_off, color: Palette.warning),
  }) {
    _notify(
      message: message ?? TkCommonErrors.network.i18n,
      title: title ?? TkCommon.error.i18n,
      icon: icon,
    );
  }

  void notifyUnknownError({
    String? message,
    String? title,
    Icon? icon = const Icon(Icons.info_outline, color: Palette.warning),
  }) {
    _notify(
      message: message ?? TkCommonErrors.unknown.i18n,
      title: title ?? TkCommon.error.i18n,
      icon: icon,
    );
  }

  Future<void> dismiss() async => GlobalNavigator.closeCurrentSnackbar();

  void _notify({
    required String message,
    required String title,
    Icon? icon,
    TextButton? mainButton,
    VoidCallback? onTap,
  }) {
    GlobalNavigator.closeAllSnackbars();
    GlobalNavigator.snackbar(
      title,
      message,
      onTap: (_) => onTap?.call(),
      margin: EdgeInsets.zero,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
      colorText: Colors.white,
      animationDuration: const Duration(milliseconds: 800),
      borderRadius: 0,
      icon: icon != null
          ? Padding(
              padding: const EdgeInsets.only(left: 12, right: 6),
              child: icon,
            )
          : null,
      mainButton: mainButton ??
          TextButton(
            onPressed: dismiss,
            style: ButtonStyle(
              shape: MaterialStateProperty.all(const CircleBorder()),
              padding: MaterialStateProperty.all(const EdgeInsets.all(8)),
              backgroundColor: MaterialStateProperty.all(
                GlobalNavigator.context != null
                    ? GlobalNavigator.theme.primaryColorLight
                    : Palette.primaryLight,
              ),
            ),
            child: const Icon(Icons.close),
          ),
      backgroundColor: GlobalNavigator.context != null
          ? GlobalNavigator.theme.primaryColorLight
          : Palette.primaryLight,
    );
  }
}
