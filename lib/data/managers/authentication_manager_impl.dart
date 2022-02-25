import 'package:common_models/common_models.dart';
import 'package:injectable/injectable.dart';

import '../../domain/failures/authentication/sign_in_failure.dart';
import '../../domain/failures/authentication/sign_up_failure.dart';
import '../../domain/helpers/app_jwt_parser.dart';
import '../../domain/managers/authentication_manager.dart';
import '../../domain/models/misc/app_jwt_payload.dart';
import '../../domain/stores/authentication_token_store.dart';
import '../../domain/stores/current_user_info_store.dart';
import '../../main.dart';
import '../network/remote_services/authentication_remote_service.dart';
import '../network/schema/authentication/authentication_payload_schema.dart';

@LazySingleton(as: AuthenticationManager)
class AuthenticationMangerImpl implements AuthenticationManager {
  AuthenticationMangerImpl(
    this._authenticationRemoteService,
    this._authenticationTokenStore,
    this._currentUserInfoStore,
    this._appJwtParser,
  );

  final AuthenticationRemoteService _authenticationRemoteService;
  final AuthenticationTokenStore _authenticationTokenStore;
  final CurrentUserInfoStore _currentUserInfoStore;
  final AppJwtParser _appJwtParser;

  @override
  Future<Either<SignInFailure, Unit>> signIn({
    required String email,
    required String password,
  }) async {
    final Either<SignInFailure, AuthenticationPayloadSchema> result =
        await _authenticationRemoteService.signIn(
      email: email,
      password: password,
    );

    if (result.isRight()) {
      final String? accessToken = result.rightOrThrow.accessToken;

      if (accessToken == null) {
        logger.wtf('access token was null');
        return left(const SignInFailure.unknown());
      }

      await _authenticationTokenStore.writeAccessToken(accessToken: accessToken);

      final AppJwtPayload? jwtPayload = await _appJwtParser.parseJwtToken(accessToken);

      if (jwtPayload != null) {
        await _currentUserInfoStore.writeCurrentUserId(userId: jwtPayload.userId);
      }
    }

    return result.map((_) => unit);
  }

  @override
  Future<Either<SignUpFailure, Unit>> signUp({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  }) async {
    final Either<SignUpFailure, AuthenticationPayloadSchema> result =
        await _authenticationRemoteService.signUp(
      firstName: firstName,
      lastName: lastName,
      email: email,
      password: password,
    );

    if (result.isRight()) {
      if (result.rightOrThrow.accessToken == null) {
        logger.wtf('access token was null');
        return left(const SignUpFailure.unknown());
      }

      await _authenticationTokenStore.writeAccessToken(
          accessToken: result.rightOrThrow.accessToken!);
    }

    return result.map((_) => unit);
  }

  @override
  Future<void> logout() async {
    await _authenticationTokenStore.clear();
    await _currentUserInfoStore.clear();
  }
}
