import 'package:common_models/common_models.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/models/user/user.dart';
import '../../network/schema/user/user_schema.dart';

@lazySingleton
class UserMapper extends BaseMapper<UserSchema, User> {
  @override
  User mapToRight(UserSchema l) {
    return User(
      id: l.id ?? -1,
      firstName: l.firstName ?? '',
      lastName: l.lastName ?? '',
      email: l.email ?? '',
      profileImageUrl: l.profileImageUrl,
    );
  }
}
