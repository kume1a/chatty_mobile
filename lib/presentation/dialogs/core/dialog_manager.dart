import 'package:global_navigator/global_navigator.dart';
import 'package:injectable/injectable.dart';

import '../overlay_loading_dialog.dart';

@lazySingleton
class DialogManager {
  void dismiss() => GlobalNavigator.pop();

  Future<void> closeOverlays() async {
    await GlobalNavigator.closeAllOverlays();
    await GlobalNavigator.closeAllSnackbars();
  }

  void showLoadingOverlay() =>
      GlobalNavigator.dialog(const OverlayLoadingDialog(), barrierDismissible: false);
}
