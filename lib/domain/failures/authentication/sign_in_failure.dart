import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_in_failure.freezed.dart';

@freezed
class SignInFailure with _$SignInFailure {
  const factory SignInFailure.unknown() = _Unknown;

  const factory SignInFailure.network() = _Network;

  const factory SignInFailure.invalidEmailOrPassword() = _InvalidEmailOrPassword;
}
