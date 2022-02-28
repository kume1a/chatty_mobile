import 'dart:typed_data';

import '../models/message/message_wrapper.dart';

abstract class PresentMessageGenerator {
  Future<MessageWrapper> generateFromText({
    required int chatId,
    required String text,
  });

  Future<MessageWrapper> generateFromImage({
    required int chatId,
    required Uint8List image,
  });

  Future<MessageWrapper> generateFromVideo({
    required int chatId,
    required Uint8List video,
  });

  Future<MessageWrapper> generateFromVoice({
    required int chatId,
    required Uint8List voice,
  });

  Future<MessageWrapper> generateFromFile({
    required int chatId,
    required Uint8List file,
  });
}
