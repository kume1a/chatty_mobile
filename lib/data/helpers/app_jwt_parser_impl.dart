import 'package:common_network_components/common_network_components.dart';
import 'package:injectable/injectable.dart';

import '../../domain/helpers/app_jwt_parser.dart';
import '../../domain/models/misc/app_jwt_payload.dart';

@LazySingleton(as: AppJwtParser)
class AppJwtParserImpl implements AppJwtParser {
  @override
  Future<AppJwtPayload?> parseJwtToken(String jwtToken) async {
    final Map<String, dynamic> payload = JwtDecoder.parseJwt(jwtToken);

    int userId = -1;
    if (payload.containsKey('userId') && payload['userId'] is int) {
      userId = payload['userId'] as int;
    }

    return AppJwtPayload(
      userId: userId,
    );
  }
}
