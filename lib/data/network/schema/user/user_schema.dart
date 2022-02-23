import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_schema.freezed.dart';

part 'user_schema.g.dart';

@freezed
class UserSchema with _$UserSchema {
  const factory UserSchema({
    int? id,
    String? firstName,
    String? lastName,
    String? email,
  }) = _UserSchema;

  factory UserSchema.fromJson(Map<String, dynamic> json) => _$UserSchemaFromJson(json);
}
