import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'chat_page_cubit.freezed.dart';

@freezed
class ChatPageState with _$ChatPageState {
  const factory ChatPageState({
    required bool isSendOptionsShowing,
  }) = _ChatPageState;

  factory ChatPageState.initial() => const ChatPageState(
        isSendOptionsShowing: false,
      );
}

@injectable
class ChatPageCubit extends Cubit<ChatPageState> {
  ChatPageCubit() : super(ChatPageState.initial());

  final FocusNode inputFocusNode = FocusNode();
  final TextEditingController inputEditingController = TextEditingController();

  @override
  Future<void> close() async {
    inputFocusNode.dispose();

    return super.close();
  }

  void onMorePressed() {
    if (!state.isSendOptionsShowing) {
      inputFocusNode.unfocus();
    }

    emit(state.copyWith(isSendOptionsShowing: !state.isSendOptionsShowing));
  }

  void onCameraPressed() {}

  void onVideoCameraPressed() {}

  void onDocumentPressed() {}

  void onVoicePressed() {}
}
