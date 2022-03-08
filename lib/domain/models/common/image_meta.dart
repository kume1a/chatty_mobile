import 'package:freezed_annotation/freezed_annotation.dart';

part 'image_meta.freezed.dart';

@freezed
class ImageMeta with _$ImageMeta {
  const factory ImageMeta({
    required int width,
    required int height,
  }) = _ImageMeta;
}
