import 'package:common_models/common_models.dart';
import 'package:injectable/injectable.dart';
import 'package:static_i18n/static_i18n.dart';

import '../../i18n/translation_keys.dart';
import '../core/failure_notifier.dart';
import '../core/toast_notifier.dart';

@lazySingleton
class FetchFailureNotifier extends FailureNotifier<FetchFailure> {
  FetchFailureNotifier(
    this._toastNotifier,
  );

  final ToastNotifier _toastNotifier;

  @override
  void notify(FetchFailure failure) {
    failure.when(
      serverError: () => _toastNotifier.notifyError(
        message: TkError.server.i18n,
        title: TkCommon.error.i18n,
      ),
      networkError: () => _toastNotifier.notifyNetworkError(),
      unknownError: () => _toastNotifier.notifyUnknownError(),
    );
  }
}
