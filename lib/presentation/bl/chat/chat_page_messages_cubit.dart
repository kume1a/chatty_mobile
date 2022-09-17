import 'package:collection/collection.dart';
import 'package:common_models/common_models.dart';
import 'package:common_utilities/common_utilities.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../core/composite_disposable.dart';
import '../../../domain/models/chat/chat.dart';
import '../../../domain/models/message/message.dart';
import '../../../domain/models/message/message_wrapper.dart';
import '../../../domain/repositories/message_repository.dart';
import '../core/events/event_chat.dart';
import '../core/events/event_message.dart';

@injectable
class ChatPageMessagesCubit extends Cubit<DataState<FetchFailure, DataPage<MessageWrapper>>>
    with CompositeDisposable<DataState<FetchFailure, DataPage<MessageWrapper>>> {
  ChatPageMessagesCubit(
    this._messageRepository,
    this._eventBus,
  ) : super(DataState<FetchFailure, DataPage<MessageWrapper>>.idle());

  final MessageRepository _messageRepository;
  final EventBus _eventBus;

  // ignore: use_late_for_private_fields_and_variables
  Either<FetchFailure, Chat>? _chat;

  bool _fetching = false;

  Future<void> init([Object? args]) async {
    addSubscription(_eventBus.on<EventMessage>().listen((EventMessage event) {
      event.whenOrNull(
        sent: (MessageWrapper messageWrapper) => _addMessageAndEmit(messageWrapper),
        received: (MessageWrapper messageWrapper) => _addMessageAndEmit(messageWrapper),
      );
    }));

    addSubscription(_eventBus.on<EventChat>().listen((EventChat event) {
      event.when(
        chatLoaded: (Either<FetchFailure, Chat> chat) {
          _chat = chat;

          if (chat.isRight()) {
            emit(DataState<FetchFailure, DataPage<MessageWrapper>>.idle());

            _fetchNextPage();
          }
        },
      );
    }));
  }

  Future<void> onScrolledToEnd() async => _fetchNextPage();

  Future<void> onRefreshPressed() async => _fetchNextPage();

  Future<void> onRefresh() async {
    emit(DataState<FetchFailure, DataPage<MessageWrapper>>.idle());

    return _fetchNextPage();
  }

  Future<void> _fetchNextPage() async {
    if (_fetching) {
      return;
    }

    _fetching = true;

    if (state == DataState<FetchFailure, DataPage<MessageWrapper>>.idle()) {
      emit(DataState<FetchFailure, DataPage<MessageWrapper>>.loading());
    }

    final Either<FetchFailure, DataPage<Message>> result = await _messageRepository.getMessages(
      lastId: state.get?.items.lastOrNull?.message?.id,
      chatId: _chat!.rightOrThrow.id,
    );

    result.fold(
      (FetchFailure l) =>
          emit(DataState<FetchFailure, DataPage<MessageWrapper>>.failure(l, state.get)),
      (DataPage<Message> r) {
        final List<MessageWrapper> mapped =
            r.items.map((Message e) => MessageWrapper.fromMessage(e)).toList();
        if (state.hasData) {
          mapped.insertAll(0, state.getOrThrow.items);
        }

        emit(DataState<FetchFailure, DataPage<MessageWrapper>>.success(DataPage<MessageWrapper>(
          items: mapped,
          count: r.count,
        )));
      },
    );

    _fetching = false;
  }

  Future<void> _addMessageAndEmit(MessageWrapper messageWrapper) async {
    if (messageWrapper.message == null) {
      return;
    }

    final DataState<FetchFailure, DataPage<MessageWrapper>> newState =
        await state.modifyData((DataPage<MessageWrapper> data) {
      final List<MessageWrapper> messages = List<MessageWrapper>.of(data.items);
      final int presentMessageIndex =
          messages.indexWhere((MessageWrapper e) => e.id == messageWrapper.id);

      if (presentMessageIndex == -1) {
        messages.insert(0, messageWrapper);
        return data.copyWith(
          items: messages,
          count: data.count + 1,
        );
      }

      messages.removeAt(presentMessageIndex);
      messages.insert(presentMessageIndex, messageWrapper);

      return data.copyWith(items: messages);
    });

    emit(newState);
  }
}
