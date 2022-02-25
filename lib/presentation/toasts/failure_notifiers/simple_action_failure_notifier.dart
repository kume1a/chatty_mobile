import 'package:common_models/common_models.dart';
import 'package:injectable/injectable.dart';

import '../core/failure_notifier.dart';
import '../core/toast_notifier.dart';

@lazySingleton
class SimpleActionFailureNotifier extends FailureNotifier<SimpleActionFailure> {
  SimpleActionFailureNotifier(
    this._toastNotifier,
  );

  final ToastNotifier _toastNotifier;

  @override
  void notify(SimpleActionFailure failure) {
    failure.when(
      network: () => _toastNotifier.notifyNetworkError(),
      unknown: () => _toastNotifier.notifyUnknownError(),
    );
  }
}
