import 'package:common_models/common_models.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/models/common/image_meta.dart';
import '../../network/schema/common/image_meta_schema.dart';

@lazySingleton
class ImageMetaMapper extends BaseMapper<ImageMetaSchema, ImageMeta> {
  @override
  ImageMeta mapToRight(ImageMetaSchema l) {
    return ImageMeta(
      width: l.width ?? 0,
      height: l.height ?? 0,
    );
  }
}
