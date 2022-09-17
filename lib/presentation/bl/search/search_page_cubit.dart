import 'dart:async';

import 'package:common_models/common_models.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/models/user/user.dart';
import '../../../domain/repositories/user_repository.dart';
import '../../../domain/stores/current_user_info_store.dart';
import '../../core/navigation/route_arguments/chat_page_args.dart';
import '../../core/navigation/screens_navigator.dart';

@injectable
class SearchPageCubit extends Cubit<DataState<FetchFailure, List<User>>> {
  SearchPageCubit(
    this._screensNavigator,
    this._userRepository,
    this._currentUserInfoStore,
  ) : super(DataState<FetchFailure, List<User>>.idle());

  final ScreensNavigator _screensNavigator;
  final UserRepository _userRepository;
  final CurrentUserInfoStore _currentUserInfoStore;

  String _lastQuery = '';
  Timer? _searchDebounce;

  @override
  Future<void> close() async {
    _searchDebounce?.cancel();

    return super.close();
  }

  void onSearchQueryChanged(String value) {
    if (value == _lastQuery) {
      return;
    }
    _lastQuery = value;

    _searchDebounce?.cancel();
    _searchDebounce = Timer(
      const Duration(milliseconds: 500),
      () async {
        final Either<FetchFailure, List<User>> result =
            await _userRepository.searchUsers(keyword: value);

        emit(DataState<FetchFailure, List<User>>.fromEither(result));
      },
    );
  }

  Future<void> onUserPressed(User user) async {
    final int? currentUserId = await _currentUserInfoStore.getCurrentUserId();

    if (currentUserId == user.id) {
      _screensNavigator.toProfilePage();
      return;
    }

    final ChatPageArgs args = ChatPageArgs(
      userId: user.id,
    );

    _screensNavigator.toChatPage(args);
  }
}
