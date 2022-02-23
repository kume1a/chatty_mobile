import 'package:common_models/common_models.dart';
import 'package:injectable/injectable.dart';

import '../../domain/models/user/user.dart';
import '../../domain/repositories/user_repository.dart';
import '../mappers/user/user_mapper.dart';
import '../network/remote_services/user_remote_service.dart';
import '../network/schema/user/user_schema.dart';

@LazySingleton(as: UserRepository)
class UserRepositoryImpl implements UserRepository {
  UserRepositoryImpl(
    this._userRemoteService,
    this._userMapper,
  );

  final UserRemoteService _userRemoteService;
  final UserMapper _userMapper;

  @override
  Future<Either<FetchFailure, User>> getUser({
    required int userId,
  }) async {
    final Either<FetchFailure, UserSchema> result =
        await _userRemoteService.getUser(userId: userId);

    return result.map((UserSchema r) => _userMapper.mapToRight(r));
  }

  @override
  Future<Either<FetchFailure, List<User>>> searchUsers({
    required String keyword,
  }) async {
    final Either<FetchFailure, List<UserSchema>> result = await _userRemoteService.searchUsers(
      keyword: keyword,
      takeCount: 20,
    );

    return result
        .map((List<UserSchema> r) => r.map((UserSchema e) => _userMapper.mapToRight(e)).toList());
  }

  @override
  Future<Either<FetchFailure, List<User>>> getChatRecommendedUsers() async {
    final Either<FetchFailure, List<UserSchema>> result =
        await _userRemoteService.getChatRecommendedUsers(takeCount: 20);

    return result
        .map((List<UserSchema> r) => r.map((UserSchema e) => _userMapper.mapToRight(e)).toList());
  }
}
