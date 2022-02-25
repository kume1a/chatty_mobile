import 'package:common_models/common_models.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/managers/authentication_manager.dart';
import '../../core/routes/screens_navigator.dart';

@injectable
class ProfilePageCubit extends Cubit<Unit> {
  ProfilePageCubit(
    this._authenticationManager,
    this._screensNavigator,
  ) : super(unit);

  final AuthenticationManager _authenticationManager;
  final ScreensNavigator _screensNavigator;

  Future<void> onLogoutPressed() async {
    await _authenticationManager.logout();

    _screensNavigator.toSignInPage();
  }
}
