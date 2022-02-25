import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_jwt_payload.freezed.dart';

@freezed
class AppJwtPayload with _$AppJwtPayload {
  const factory AppJwtPayload({
    required int userId,
  }) = _AppJwtPayload;
}
