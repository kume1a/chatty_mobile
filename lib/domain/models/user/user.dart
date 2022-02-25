import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';

@freezed
class User with _$User {
  const factory User({
    required int id,
    required String firstName,
    required String lastName,
    required String email,
  }) = _User;

  const User._();

  String get fullName {
    final String space = firstName.isNotEmpty && lastName.isNotEmpty ? ' ' : '';
    return '$firstName$space$lastName';
  }
}
