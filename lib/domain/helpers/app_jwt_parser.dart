import '../models/misc/app_jwt_payload.dart';

abstract class AppJwtParser {
  Future<AppJwtPayload?> parseJwtToken(String jwtToken);
}
