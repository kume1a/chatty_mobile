import 'package:common_models/common_models.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/models/chat/chat.dart';
import '../../../domain/repositories/chat_repository.dart';
import '../core/data_pager_with_last_id_cubit.dart';

@injectable
class ChatsPageChatsCubit extends DataPagerWithLastIdCubit<FetchFailure, Chat, int> {
  ChatsPageChatsCubit(
    this._chatRepository,
  );

  final ChatRepository _chatRepository;

  @override
  Future<Either<FetchFailure, DataPage<Chat>>> provideDataPage(int? lastId) async =>
      _chatRepository.getChats(lastId: lastId);

  @override
  int resolveId(Chat t) => t.id;
}
