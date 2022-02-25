import 'package:common_models/common_models.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/models/user/user.dart';
import '../../../domain/repositories/user_repository.dart';
import '../../core/routes/route_arguments/chat_page_args.dart';

@injectable
class ChatPageUserCubit extends Cubit<DataState<FetchFailure, User>> {
  ChatPageUserCubit(
    this._userRepository,
  ) : super(const DataState<FetchFailure, User>.idle());

  final UserRepository _userRepository;

  late final ChatPageArgs _args;

  Future<void> init(ChatPageArgs args) async {
    _args = args;

    _fetchUser();
  }

  Future<void> onRefresh() async => _fetchUser();

  Future<void> _fetchUser() async {
    emit(const DataState<FetchFailure, User>.loading());
    final Either<FetchFailure, User> result = await _userRepository.getUser(userId: _args.userId);
    emit(DataState<FetchFailure, User>.fromEither(result));
  }
}
