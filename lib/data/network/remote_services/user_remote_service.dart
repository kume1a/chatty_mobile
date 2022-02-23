import 'package:common_models/common_models.dart';
import 'package:common_network_components/common_network_components.dart';
import 'package:injectable/injectable.dart';

import '../api/api_service.dart';
import '../schema/user/user_schema.dart';

@lazySingleton
class UserRemoteService extends BaseService {
  UserRemoteService(
    this._apiService,
  );

  final ApiService _apiService;

  Future<Either<FetchFailure, UserSchema>> getUser({required int userId}) async =>
      safeFetch(() => _apiService.getUser(userId));

  Future<Either<FetchFailure, List<UserSchema>>> searchUsers({
    required String keyword,
    required int takeCount,
  }) async =>
      safeFetch(() => _apiService.searchUsers(keyword, takeCount));

  Future<Either<FetchFailure, List<UserSchema>>> getChatRecommendedUsers({
    required int takeCount,
  }) async =>
      safeFetch(() => _apiService.getChatRecommendedUsers(takeCount));
}
