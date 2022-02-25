import 'package:common_models/common_models.dart';
import 'package:common_utilities/common_utilities.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../core/composite_disposable.dart';
import '../../../domain/models/chat/chat.dart';
import '../../../domain/repositories/chat_repository.dart';
import '../../core/routes/route_arguments/chat_page_args.dart';
import '../core/events/event_chat.dart';

@injectable
class ChatPageCubit extends Cubit<DataState<FetchFailure, Chat>>
    with CompositeDisposable<DataState<FetchFailure, Chat>> {
  ChatPageCubit(
    this._chatRepository,
    this._eventBus,
  ) : super(const DataState<FetchFailure, Chat>.idle());

  final ChatRepository _chatRepository;
  final EventBus _eventBus;

  late final ChatPageArgs _args;

  Future<void> init(ChatPageArgs args) async {
    _args = args;

    addSubscription(_eventBus.on<EventChat>().listen((EventChat event) {
      event.whenOrNull(
        chatLoaded: (Either<FetchFailure, Chat> chat) =>
            emit(DataState<FetchFailure, Chat>.fromEither(chat)),
      );
    }));

    await _fetchChat();
  }

  Future<void> onRefresh() async => _fetchChat();

  void onCameraPressed() {}

  void onVideoCameraPressed() {}

  void onDocumentPressed() {}

  void onVoicePressed() {}

  Future<Chat?> _fetchChat() async {
    final Either<FetchFailure, Chat> chat =
        await _chatRepository.getChatByUserId(userId: _args.userId);

    _eventBus.fire(EventChat.chatLoaded(chat));

    return chat.get;
  }
}
