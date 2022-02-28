import 'package:common_models/common_models.dart';
import 'package:common_utilities/common_utilities.dart';
import 'package:injectable/injectable.dart';

import '../../../core/composite_disposable.dart';
import '../../../domain/models/chat/chat.dart';
import '../../../domain/models/message/message_wrapper.dart';
import '../../../domain/repositories/chat_repository.dart';
import '../core/data_pager_with_page_cubit.dart';
import '../core/events/event_message.dart';

@injectable
class ChatsPageChatsCubit extends DataPagerWithPageCubit<FetchFailure, Chat>
    with CompositeDisposable<DataState<FetchFailure, DataPage<Chat>>> {
  ChatsPageChatsCubit(
    this._chatRepository,
    this._eventBus,
  );

  final ChatRepository _chatRepository;
  final EventBus _eventBus;

  @override
  Future<void> init([Object? args]) async {
    addSubscription(_eventBus.on<EventMessage>().listen((EventMessage event) {
      event.when(
        sent: (MessageWrapper messageWrapper) => _updateLatestMessageAndEmit(messageWrapper),
        received: (MessageWrapper messageWrapper) => _updateLatestMessageAndEmit(messageWrapper),
      );
    }));

    super.init(args);
  }

  @override
  Future<Either<FetchFailure, DataPage<Chat>>> provideDataPage(int page) async =>
      _chatRepository.getChats(page: page);

  Future<void> _updateLatestMessageAndEmit(MessageWrapper messageWrapper) async {
    if (messageWrapper.message == null) {
      return;
    }

    final DataState<FetchFailure, DataPage<Chat>>? newState =
        await state.modifyIfHasDataAndGet((DataPage<Chat> data) {
      final List<Chat> chats = List<Chat>.of(data.items);
      final int index = chats.indexWhere((Chat e) => e.id == messageWrapper.message!.chatId);
      if (index == -1) {
        return null;
      }

      final Chat newChat = chats[index].copyWith(lastMessage: messageWrapper.message);
      chats.removeAt(index);
      chats.insert(index, newChat);

      return data.copyWith(items: chats);
    });

    if (newState != null) {
      emit(newState);
    }
  }
}
