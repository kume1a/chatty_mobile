import 'dart:io';
import 'dart:typed_data';

import 'package:collection/collection.dart';
import 'package:common_models/common_models.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';

import '../../core/named_file.dart';
import '../../domain/helpers/image_picker_helper.dart';
import '../../main.dart';

@LazySingleton(as: ImagePickerHelper)
class ImagePickerHelperImpl implements ImagePickerHelper {
  ImagePickerHelperImpl(
    this._imagePicker,
  );

  final ImagePicker _imagePicker;

  @override
  Future<Either<Unit, NamedFile?>> pickImage({
    int imageQuality = 100,
  }) async {
    try {
      final XFile? pickedImage = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: imageQuality.clamp(0, 100),
      );

      if (pickedImage == null) {
        return right(null);
      }

      final String fileName = pickedImage.path.split(Platform.pathSeparator).lastOrNull ?? 'file';
      final Uint8List imageBytes = await pickedImage.readAsBytes();

      return right(NamedFile(data: imageBytes, name: fileName));
    } on Exception catch (e) {
      logger.e(e);
    }
    return left(unit);
  }

  @override
  Future<Either<Unit, NamedFile?>> takeImage({
    int imageQuality = 100,
  }) async {
    try {
      final XFile? pickedImage = await _imagePicker.pickImage(
        source: ImageSource.camera,
        imageQuality: imageQuality.clamp(0, 100),
      );

      if (pickedImage == null) {
        return right(null);
      }

      final String fileName = pickedImage.path.split(Platform.pathSeparator).lastOrNull ?? 'file';
      final Uint8List imageBytes = await pickedImage.readAsBytes();

      return right(NamedFile(data: imageBytes, name: fileName));
    } on Exception catch (e) {
      logger.e(e);
    }
    return left(unit);
  }
}
