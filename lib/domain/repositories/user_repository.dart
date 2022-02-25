import 'package:common_models/common_models.dart';

import '../models/user/user.dart';

abstract class UserRepository {
  Future<Either<FetchFailure, List<User>>> searchUsers({
    required String keyword,
  });

  Future<Either<FetchFailure, User>> getUser({
    required int userId,
  });

  Future<Either<FetchFailure, List<User>>> getChatRecommendedUsers();

  Future<Either<FetchFailure, User>> getCurrentUser();
}
