import 'package:freezed_annotation/freezed_annotation.dart';

part 'image_meta_schema.freezed.dart';

part 'image_meta_schema.g.dart';

@freezed
class ImageMetaSchema with _$ImageMetaSchema {
  const factory ImageMetaSchema({
    int? width,
    int? height,
  }) = _ImageMetaSchema;

  factory ImageMetaSchema.fromJson(Map<String, dynamic> json) => _$ImageMetaSchemaFromJson(json);
}
