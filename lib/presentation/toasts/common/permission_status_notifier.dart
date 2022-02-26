import 'package:injectable/injectable.dart';
import 'package:static_i18n/static_i18n.dart';

import '../../core/widgets/common/button_settings.dart';
import '../../i18n/translation_keys.dart';
import '../core/toast_notifier.dart';

@lazySingleton
class PermissionStatusNotifier {
  PermissionStatusNotifier(
    this._toastNotifier,
  );

  final ToastNotifier _toastNotifier;

  void notifyMicrophonePermissionDenied() => _toastNotifier.notifyWarning(
        message: TkError.microphonePermissionDenied.i18n,
        title: TkError.permissionDenied.i18n,
      );

  void notifyMicrophonePermissionPermanentlyDenied() => _toastNotifier.notifyWarning(
        message: TkError.microphonePermissionPermanentlyDenied.i18n,
        title: TkError.permissionDenied.i18n,
        mainButton: ButtonSettings.newInstance(),
      );

  void notifyStoragePermissionDenied() => _toastNotifier.notifyWarning(
        message: TkError.storagePermissionDenied.i18n,
        title: TkError.permissionDenied.i18n,
      );

  void notifyStoragePermissionPermanentlyDenied() => _toastNotifier.notifyWarning(
        message: TkError.storagePermissionPermanentlyDenied.i18n,
        title: TkError.permissionDenied.i18n,
        mainButton: ButtonSettings.newInstance(),
      );

  void notifyCameraPermissionDenied() => _toastNotifier.notifyWarning(
        message: TkError.cameraPermissionDenied.i18n,
        title: TkError.permissionDenied.i18n,
      );

  void notifyCameraPermissionPermanentlyDenied() => _toastNotifier.notifyWarning(
        message: TkError.cameraPermissionPermanentlyDenied.i18n,
        title: TkError.permissionDenied.i18n,
        mainButton: ButtonSettings.newInstance(),
      );
}
