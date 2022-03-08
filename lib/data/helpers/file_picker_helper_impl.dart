import 'dart:io';
import 'dart:typed_data';

import 'package:collection/collection.dart';
import 'package:common_models/common_models.dart';
import 'package:file_picker/file_picker.dart';
import 'package:injectable/injectable.dart';

import '../../core/named_file.dart';
import '../../domain/helpers/file_picker_helper.dart';
import '../../main.dart';

@LazySingleton(as: FilePickerHelper)
class FilePickerHelperImpl implements FilePickerHelper {
  @override
  Future<Either<Unit, NamedFile?>> pickFile() async {
    try {
      final FilePickerResult? result = await FilePicker.platform.pickFiles();
      if (result == null || result.files.firstOrNull?.path == null || result.count == 0) {
        return right(null);
      }

      final File file = File(result.files.single.path!);
      final String fileName = result.files.single.name;
      final Uint8List fileBytes = await file.readAsBytes();

      return right(NamedFile(data: fileBytes, name: fileName));
    } on Exception catch (e) {
      logger.e(e);
    }
    return left(unit);
  }
}
