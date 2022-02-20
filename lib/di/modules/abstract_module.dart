import 'package:common_utilities/common_utilities.dart';
import 'package:injectable/injectable.dart';

@module
abstract class AbstractModule {
  @lazySingleton
  EventBus get eventBus => EventBus();
}
