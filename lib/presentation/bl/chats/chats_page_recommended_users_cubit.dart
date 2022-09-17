import 'package:common_models/common_models.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/models/user/user.dart';
import '../../../domain/repositories/user_repository.dart';

@injectable
class ChatsPageRecommendedUsersCubit extends Cubit<DataState<FetchFailure, List<User>>> {
  ChatsPageRecommendedUsersCubit(
    this._userRepository,
  ) : super(DataState<FetchFailure, List<User>>.idle());

  final UserRepository _userRepository;

  Future<void> init() async => _fetchRecommendedUsers();

  Future<void> onRefresh() async => _fetchRecommendedUsers();

  Future<void> _fetchRecommendedUsers() async {
    emit(DataState<FetchFailure, List<User>>.loading());
    final Either<FetchFailure, List<User>> result = await _userRepository.getChatRecommendedUsers();
    emit(DataState<FetchFailure, List<User>>.fromEither(result));
  }
}
