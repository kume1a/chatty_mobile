import 'package:common_models/common_models.dart';
import 'package:common_utilities/common_utilities.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:static_i18n/static_i18n.dart';

import '../../../core/composite_disposable.dart';
import '../../../core/constants.dart';
import '../../../domain/enums/message_type.dart';
import '../../../domain/helpers/file_downloader.dart';
import '../../../domain/models/chat/chat.dart';
import '../../../domain/models/message/message.dart';
import '../../../domain/repositories/chat_repository.dart';
import '../../core/navigation/route_arguments/chat_page_args.dart';
import '../../i18n/translation_keys.dart';
import '../../toasts/core/toast_notifier.dart';
import '../../toasts/failure_notifiers/fetch_failure_notifier.dart';
import '../core/events/event_chat.dart';

@injectable
class ChatPageCubit extends Cubit<DataState<FetchFailure, Chat>>
    with CompositeDisposable<DataState<FetchFailure, Chat>> {
  ChatPageCubit(
    this._chatRepository,
    this._eventBus,
    this._fileDownloader,
    this._fetchFailureNotifier,
    this._toastNotifier,
  ) : super(DataState<FetchFailure, Chat>.idle());

  final ChatRepository _chatRepository;
  final EventBus _eventBus;
  final FileDownloader _fileDownloader;
  final FetchFailureNotifier _fetchFailureNotifier;
  final ToastNotifier _toastNotifier;

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

  void onVideoCameraPressed() {}

  void onVoicePressed() {}

  Future<Chat?> _fetchChat() async {
    final Either<FetchFailure, Chat> chat =
        await _chatRepository.getChatByUserId(userId: _args.userId);

    _eventBus.fire(EventChat.chatLoaded(chat));

    return chat.get;
  }

  Future<void> onMessagePressed(Message? message) async {
    if (message == null) {
      return;
    }

    switch (message.type) {
      case MessageType.text:
        break;
      case MessageType.voice:
        break;
      case MessageType.video:
        break;
      case MessageType.image:
        break;
      case MessageType.file:
        if (message.filePath == null) {
          return;
        }
        final Either<FetchFailure, Unit> result =
            await _fileDownloader.download(Constants.apiUrl + message.filePath!);
        result.fold(
          _fetchFailureNotifier.notify,
          (_) => _toastNotifier.notifyInfo(
            title: TkCommon.success.i18n,
            message: TkSuccess.fileDownloaded.i18n,
          ),
        );

        break;
      case MessageType.gif:
        break;
      case MessageType.unknown:
        break;
    }
  }
}
