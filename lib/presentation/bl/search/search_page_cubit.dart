import 'dart:async';

import 'package:common_models/common_models.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/models/user/user.dart';
import '../../../domain/repositories/user_repository.dart';
import '../../core/routes/route_arguments/chat_page_args.dart';
import '../../core/routes/screens_navigator.dart';

@injectable
class SearchPageCubit extends Cubit<DataState<FetchFailure, List<User>>> {
  SearchPageCubit(
    this._screensNavigator,
    this._userRepository,
  ) : super(const DataState<FetchFailure, List<User>>.idle());

  final ScreensNavigator _screensNavigator;
  final UserRepository _userRepository;

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

  void onUserPressed(User user) {
    final ChatPageArgs args = ChatPageArgs(
      userId: user.id,
    );

    _screensNavigator.toChatPage(args);
  }
}
