import 'package:freezed_annotation/freezed_annotation.dart';

part 'authentication_payload_schema.freezed.dart';

part 'authentication_payload_schema.g.dart';

@freezed
class AuthenticationPayloadSchema with _$AuthenticationPayloadSchema {
  const factory AuthenticationPayloadSchema({
    String? accessToken,
  }) = _AuthenticationPayloadSchema;

  factory AuthenticationPayloadSchema.fromJson(Map<String, dynamic> json) =>
      _$AuthenticationPayloadSchemaFromJson(json);
}
