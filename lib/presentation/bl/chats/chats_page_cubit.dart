import 'package:common_models/common_models.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/models/chat/chat.dart';
import '../../../domain/models/user/user.dart';
import '../../core/navigation/route_arguments/chat_page_args.dart';
import '../../core/navigation/screens_navigator.dart';

@injectable
class ChatsPageCubit extends Cubit<Unit> {
  ChatsPageCubit(
    this._screensNavigator,
  ) : super(unit);

  final ScreensNavigator _screensNavigator;

  void onProfilePressed() => _screensNavigator.toProfilePage();

  void onSearchPressed() => _screensNavigator.toSearchPage();

  void onUserPressed(User user) {
    final ChatPageArgs args = ChatPageArgs(
      userId: user.id,
    );

    _screensNavigator.toChatPage(args);
  }

  void onChatPressed(Chat chat) {
    if (chat.user?.id == null) {
      return;
    }

    final ChatPageArgs args = ChatPageArgs(
      userId: chat.user!.id,
    );

    _screensNavigator.toChatPage(args);
  }
}
