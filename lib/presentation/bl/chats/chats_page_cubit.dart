import 'package:common_models/common_models.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class ChatsPageCubit extends Cubit<Unit> {
  ChatsPageCubit() : super(unit);
}
