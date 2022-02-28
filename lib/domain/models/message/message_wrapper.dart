import 'dart:typed_data';

import 'package:common_models/common_models.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uuid/uuid.dart';

import 'message.dart';

part 'message_wrapper.freezed.dart';

@freezed
class MessageWrapper with _$MessageWrapper {
  const factory MessageWrapper({
    required String id,
    required Message? message,
    required bool isSent,
    required double progress,
    SimpleActionFailure? failure,
    Uint8List? inMemoryImage,
    Uint8List? inMemoryVideo,
    Uint8List? inMemoryVoice,
    Uint8List? inMemoryFile,
  }) = _MessageWrapper;

  const MessageWrapper._();

  factory MessageWrapper.fromMessage(Message message) {
    return MessageWrapper(
      id: const Uuid().v4(),
      message: message,
      isSent: true,
      progress: 100,
    );
  }
}
