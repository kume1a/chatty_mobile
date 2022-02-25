import 'package:collection/collection.dart';
import 'package:common_models/common_models.dart';
import 'package:common_utilities/common_utilities.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../core/composite_disposable.dart';
import '../../../domain/models/chat/chat.dart';
import '../../../domain/models/message/message.dart';
import '../../../domain/repositories/message_repository.dart';
import '../core/events/event_chat.dart';
import '../core/events/event_message.dart';

@injectable
class ChatPageMessagesCubit extends Cubit<DataState<FetchFailure, DataPage<Message>>>
    with CompositeDisposable<DataState<FetchFailure, DataPage<Message>>> {
  ChatPageMessagesCubit(
    this._messageRepository,
    this._eventBus,
  ) : super(const DataState<FetchFailure, DataPage<Message>>.idle());

  final MessageRepository _messageRepository;
  final EventBus _eventBus;

  // ignore: use_late_for_private_fields_and_variables
  Either<FetchFailure, Chat>? _chat;

  bool _fetching = false;

  Future<void> init([Object? args]) async {
    addSubscription(_eventBus.on<EventMessage>().listen((EventMessage event) {
      event.whenOrNull(
        sent: (Message message) => _addMessageAndEmit(message),
      );
    }));

    addSubscription(_eventBus.on<EventChat>().listen((EventChat event) {
      event.when(
        chatLoaded: (Either<FetchFailure, Chat> chat) {
          _chat = chat;

          if (chat.isRight()) {
            emit(const DataState<FetchFailure, DataPage<Message>>.idle());

            _fetchNextPage();
          }
        },
      );
    }));
  }

  Future<void> onScrolledToEnd() async => _fetchNextPage();

  Future<void> onRefreshPressed() async => _fetchNextPage();

  Future<void> onRefresh() async {
    emit(const DataState<FetchFailure, DataPage<Message>>.idle());

    return _fetchNextPage();
  }

  Future<void> _fetchNextPage() async {
    if (_fetching) {
      return;
    }

    _fetching = true;

    if (state == const DataState<FetchFailure, DataPage<Message>>.idle()) {
      emit(const DataState<FetchFailure, DataPage<Message>>.loading());
    }

    final Either<FetchFailure, DataPage<Message>> result = await _messageRepository.getMessages(
      lastId: state.get?.items.lastOrNull?.id,
      chatId: _chat!.rightOrThrow.id,
    );

    result.fold(
      (FetchFailure l) => emit(DataState<FetchFailure, DataPage<Message>>.error(l, state.get)),
      (DataPage<Message> r) {
        if (state.hasData) {
          r.items.insertAll(0, state.getOrThrow.items);
        }

        emit(DataState<FetchFailure, DataPage<Message>>.success(r));
      },
    );

    _fetching = false;
  }

  Future<void> _addMessageAndEmit(Message message) async {
    final DataState<FetchFailure, DataPage<Message>>? newState =
        await state.modifyIfHasDataAndGet((DataPage<Message> data) {
      data.items.insert(0, message);

      return data.copyWith(
        items: data.items,
        count: data.count + 1,
      );
    });

    if (newState != null) {
      emit(newState);
    }
  }
}
