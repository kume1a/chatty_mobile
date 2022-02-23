import 'package:freezed_annotation/freezed_annotation.dart';

part 'message.freezed.dart';

@freezed
class Message with _$Message {
  const factory Message({
    required int id,
    required String? type,
    required String? textMessage,
    required String? imageUrl,
    required String? videoUrl,
    required String? gifUrl,
    required DateTime? createdAt,
  }) = _Message;
}
