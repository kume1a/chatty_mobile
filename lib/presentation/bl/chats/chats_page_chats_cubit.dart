import 'package:common_models/common_models.dart';
import 'package:common_utilities/common_utilities.dart';
import 'package:injectable/injectable.dart';

import '../../../core/composite_disposable.dart';
import '../../../domain/models/chat/chat.dart';
import '../../../domain/models/message/message.dart';
import '../../../domain/repositories/chat_repository.dart';
import '../core/data_pager_with_last_id_cubit.dart';
import '../core/events/event_message.dart';

@injectable
class ChatsPageChatsCubit extends DataPagerWithLastIdCubit<FetchFailure, Chat, int>
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
        sent: (Message message) => _updateLatestMessageAndEmit(message),
        received: (Message message) => _updateLatestMessageAndEmit(message),
      );
    }));

    super.init(args);
  }

  @override
  Future<Either<FetchFailure, DataPage<Chat>>> provideDataPage(int? lastId) async =>
      _chatRepository.getChats(lastId: lastId);

  @override
  int resolveId(Chat t) => t.id;

  Future<void> _updateLatestMessageAndEmit(Message message) async {
    final DataState<FetchFailure, DataPage<Chat>>? newState =
        await state.modifyIfHasDataAndGet((DataPage<Chat> data) {
      final List<Chat> chats = List<Chat>.of(data.items);
      final int index = chats.indexWhere((Chat e) => e.id == message.chatId);
      if (index == -1) {
        return null;
      }

      final Chat newChat = chats[index].copyWith(lastMessage: message);
      chats.removeAt(index);
      chats.insert(index, newChat);

      return data.copyWith(items: chats);
    });

    if (newState != null) {
      emit(newState);
    }
  }
}
