import 'package:common_models/common_models.dart';
import 'package:common_utilities/common_utilities.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:static_i18n/static_i18n.dart';

import '../../../core/composite_disposable.dart';
import '../../../domain/helpers/image_picker_helper.dart';
import '../../../domain/helpers/present_message_generator.dart';
import '../../../domain/managers/permission_manager.dart';
import '../../../domain/models/chat/chat.dart';
import '../../../domain/models/message/message.dart';
import '../../../domain/models/message/message_wrapper.dart';
import '../../../domain/models/misc/named_file.dart';
import '../../../domain/repositories/chat_repository.dart';
import '../../../domain/repositories/message_repository.dart';
import '../../core/routes/route_arguments/chat_page_args.dart';
import '../../i18n/translation_keys.dart';
import '../../toasts/common/permission_status_notifier.dart';
import '../../toasts/core/toast_notifier.dart';
import '../core/events/event_chat.dart';
import '../core/events/event_message.dart';

@injectable
class ChatPageImageCubit extends Cubit<Unit> with CompositeDisposable<Unit> {
  ChatPageImageCubit(
    this._permissionManager,
    this._imagePickerHelper,
    this._toastNotifier,
    this._permissionStatusNotifier,
    this._eventBus,
    this._chatRepository,
    this._messageRepository,
    this._presentMessageGenerator,
  ) : super(unit);

  final PermissionManager _permissionManager;
  final ImagePickerHelper _imagePickerHelper;
  final ToastNotifier _toastNotifier;
  final PermissionStatusNotifier _permissionStatusNotifier;
  final EventBus _eventBus;
  final ChatRepository _chatRepository;
  final MessageRepository _messageRepository;
  final PresentMessageGenerator _presentMessageGenerator;

  late final ChatPageArgs _args;

  Either<FetchFailure, Chat>? _chat;

  Future<void> init(ChatPageArgs args) async {
    _args = args;

    addSubscription(_eventBus.on<EventChat>().listen((EventChat event) {
      event.when(
        chatLoaded: (Either<FetchFailure, Chat> chat) => _chat = chat,
      );
    }));
  }

  Future<void> onCameraPressed() async {
    if (!await _permissionManager.isStoragePermissionGranted()) {
      final PermissionStatus returnedPermissionStatus =
          await _permissionManager.requestStoragePermission();

      switch (returnedPermissionStatus) {
        case PermissionStatus.granted:
        case PermissionStatus.limited:
          break;
        case PermissionStatus.permanentlyDenied:
          _permissionStatusNotifier.notifyStoragePermissionPermanentlyDenied();
          return;
        case PermissionStatus.denied:
        case PermissionStatus.restricted:
          _permissionStatusNotifier.notifyStoragePermissionDenied();
          return;
      }
    }

    final Either<Unit, NamedFile?> pickedImageResult = await _imagePickerHelper.pickImage();
    if (pickedImageResult.get == null) {
      _toastNotifier.notifyWarning(
        message: TkError.unknown.i18n,
        title: TkError.pickImage.i18n,
      );
      return;
    }

    final Chat? chat = await _resolveChat();
    if (chat == null) {
      return;
    }

    final MessageWrapper messageWrapper = await _presentMessageGenerator.generateFromImage(
      chatId: chat.id,
      image: pickedImageResult.rightOrThrow!.data,
    );
    _eventBus.fire(EventMessage.sent(messageWrapper));

    final Either<SimpleActionFailure, Message> result = await _messageRepository.sendMessage(
      sendId: messageWrapper.id,
      chatId: chat.id,
      imageFile: pickedImageResult.rightOrThrow!.data,
    );

    result.fold(
      (SimpleActionFailure l) {
        final MessageWrapper sentMessage = messageWrapper.copyWith(
          failure: l,
          isSent: true,
          progress: 100,
        );
        _eventBus.fire(EventMessage.sent(sentMessage));
      },
      (Message r) {
        final MessageWrapper sentMessage = messageWrapper.copyWith(
          message: r,
          isSent: true,
          progress: 100,
        );
        _eventBus.fire(EventMessage.sent(sentMessage));
      },
    );
  }

  Future<Chat?> _resolveChat() async {
    if (_chat != null && _chat!.isRight()) {
      return _chat!.rightOrThrow;
    }

    final Either<FetchFailure, Chat> chat = await _chatRepository.getChatByUserId(
      userId: _args.userId,
    );

    _eventBus.fire(EventChat.chatLoaded(chat));
    return chat.get;
  }
}
