import 'package:common_models/common_models.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../core/routes/route_arguments/chat_page_args.dart';
import '../../core/routes/screens_navigator.dart';

@injectable
class ChatsPageCubit extends Cubit<Unit> {
  ChatsPageCubit(
    this._screensNavigator,
  ) : super(unit);

  final ScreensNavigator _screensNavigator;

  void onProfilePressed() {}

  void onSearchPressed() => _screensNavigator.toSearchPage();

  void onUserPressed() {
    const ChatPageArgs args = ChatPageArgs(userId: 1);

    _screensNavigator.toChatPage(args);
  }

  void onChatPressed() {
    const ChatPageArgs args = ChatPageArgs(userId: 1);

    _screensNavigator.toChatPage(args);
  }
}