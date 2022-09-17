import 'package:common_models/common_models.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../domain/models/user/user.dart';
import '../../../../domain/repositories/user_repository.dart';

@injectable
class CurrentUserCubit extends Cubit<DataState<FetchFailure, User>> {
  CurrentUserCubit(
    this._userRepository,
  ) : super(DataState<FetchFailure, User>.idle());

  final UserRepository _userRepository;

  Future<void> init() async => _fetchUser();

  Future<void> onRefresh() async => _fetchUser();

  Future<void> _fetchUser() async {
    emit(DataState<FetchFailure, User>.loading());
    final Either<FetchFailure, User> result = await _userRepository.getCurrentUser();
    emit(DataState<FetchFailure, User>.fromEither(result));
  }
}
