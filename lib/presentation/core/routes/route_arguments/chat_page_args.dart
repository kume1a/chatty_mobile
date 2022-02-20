import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_page_args.freezed.dart';

@freezed
class ChatPageArgs with _$ChatPageArgs {
  const factory ChatPageArgs({
    required int chatId,
  }) = _ChatPageArgs;
}
