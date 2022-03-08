import 'package:common_models/common_models.dart';

import '../../core/named_file.dart';

abstract class ImagePickerHelper {
  Future<Either<Unit, NamedFile?>> pickImage({
    int imageQuality = 100,
  });

  Future<Either<Unit, NamedFile?>> takeImage({
    int imageQuality = 100,
  });
}
