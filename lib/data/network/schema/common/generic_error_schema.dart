import 'package:freezed_annotation/freezed_annotation.dart';

part 'generic_error_schema.freezed.dart';

part 'generic_error_schema.g.dart';

@freezed
class GenericErrorSchema with _$GenericErrorSchema {
  const factory GenericErrorSchema({
    String? messageCode,
    String? message,
    int? statusCode,
    List<String>? validationErrors,
  }) = _GenericErrorSchema;

  factory GenericErrorSchema.fromJson(Map<String, dynamic> json) =>
      _$GenericErrorSchemaFromJson(json);
}
