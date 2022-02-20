import 'package:common_models/common_models.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/stores/authentication_token_store.dart';
import '../../core/routes/screens_navigator.dart';

@injectable
class InitPageCubit extends Cubit<Unit> {
  InitPageCubit(
    this._authenticationTokenStore,
    this._screensNavigator,
  ) : super(unit);

  final AuthenticationTokenStore _authenticationTokenStore;
  final ScreensNavigator _screensNavigator;

  Future<void> init() async {
    final bool isAuthenticated = await _authenticationTokenStore.hasAccessToken();

    if (isAuthenticated) {
      _screensNavigator.toChatsPage();
    } else {
      _screensNavigator.toSignInPage();
    }
  }
}
