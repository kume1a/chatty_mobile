import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_in_body.freezed.dart';

part 'sign_in_body.g.dart';

@freezed
class SignInBody with _$SignInBody {
  const factory SignInBody({
    required String email,
    required String password,
  }) = _SignInBody;

  factory SignInBody.fromJson(Map<String, dynamic> json) => _$SignInBodyFromJson(json);
}
