import 'package:common_models/common_models.dart';

import '../../core/named_file.dart';

abstract class FilePickerHelper {
  Future<Either<Unit, NamedFile?>> pickFile();
}
