import 'package:common_models/common_models.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../core/routes/route_arguments/chat_page_args.dart';
import '../../core/routes/screens_navigator.dart';

@injectable
class SearchPageCubit extends Cubit<Unit> {
  SearchPageCubit(
    this._screensNavigator,
  ) : super(unit);

  final ScreensNavigator _screensNavigator;

  void onSearchQueryChanged(String value) {}

  void onUserPressed() {
    const ChatPageArgs args = ChatPageArgs(chatId: 1);

    _screensNavigator.toChatPage(args);
  }
}
