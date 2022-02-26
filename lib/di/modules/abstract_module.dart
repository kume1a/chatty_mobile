import 'package:common_utilities/common_utilities.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';

@module
abstract class AbstractModule {
  @lazySingleton
  EventBus get eventBus => EventBus();

  @lazySingleton
  ImagePicker get imagePicker => ImagePicker();
}
