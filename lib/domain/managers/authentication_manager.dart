import 'package:common_models/common_models.dart';

import '../failures/authentication/sign_in_failure.dart';
import '../failures/authentication/sign_up_failure.dart';

abstract class AuthenticationManager {
  Future<Either<SignInFailure, Unit>> signIn({
    required String email,
    required String password,
  });

  Future<Either<SignUpFailure, Unit>> signUp({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  });

  Future<void> logout();
}
