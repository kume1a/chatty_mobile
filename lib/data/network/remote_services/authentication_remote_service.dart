import 'package:common_models/common_models.dart';
import 'package:common_network_components/common_network_components.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/failures/authentication/sign_in_failure.dart';
import '../../../domain/failures/authentication/sign_up_failure.dart';
import '../api/api_service.dart';
import '../schema/authentication/authentication_payload_schema.dart';
import '../schema/body/sign_in_body.dart';
import '../schema/body/sign_up_body.dart';
import '../schema/common/generic_error_schema.dart';

@lazySingleton
class AuthenticationRemoteService extends BaseService {
  AuthenticationRemoteService(
    this._apiService,
  );

  final ApiService _apiService;

  Future<Either<SignInFailure, AuthenticationPayloadSchema>> signIn({
    required String email,
    required String password,
  }) async {
    return safeCall(
      call: () {
        final SignInBody body = SignInBody(
          email: email,
          password: password,
        );

        return _apiService.signIn(body);
      },
      onNetworkError: () => const SignInFailure.network(),
      onUnknownError: (_) => const SignInFailure.unknown(),
      onResponseError: (Response<dynamic>? response) {
        if (response?.data == null || response?.data is! Map<String, dynamic>) {
          return const SignInFailure.unknown();
        }

        final GenericErrorSchema result =
            GenericErrorSchema.fromJson(response!.data! as Map<String, dynamic>);

        switch (result.messageCode) {
          case 'EMAIL_OR_PASSWORD_INVALID':
            return const SignInFailure.invalidEmailOrPassword();
          default:
            return const SignInFailure.unknown();
        }
      },
    );
  }

  Future<Either<SignUpFailure, AuthenticationPayloadSchema>> signUp({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  }) async {
    return safeCall(
      call: () {
        final SignUpBody body = SignUpBody(
          firstName: firstName,
          lastName: lastName,
          email: email,
          password: password,
        );

        return _apiService.signUp(body);
      },
      onNetworkError: () => const SignUpFailure.network(),
      onUnknownError: (_) => const SignUpFailure.unknown(),
      onResponseError: (Response<dynamic>? response) {
        if (response?.data == null || response?.data is! Map<String, dynamic>) {
          return const SignUpFailure.unknown();
        }

        final GenericErrorSchema result =
            GenericErrorSchema.fromJson(response!.data! as Map<String, dynamic>);

        switch (result.messageCode) {
          case 'EMAIL_ALREADY_EXISTS':
            return const SignUpFailure.emailAlreadyUsed();
          default:
            return const SignUpFailure.unknown();
        }
      },
    );
  }
}
