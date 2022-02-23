import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../core/constants.dart';
import '../schema/authentication/authentication_payload_schema.dart';
import '../schema/body/sign_in_body.dart';
import '../schema/body/sign_up_body.dart';
import '../schema/chat/chats_page_schema.dart';
import '../schema/message/messages_page_schema.dart';
import '../schema/user/user_schema.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: Constants.apiUrl)
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @POST('/authentication/signin')
  Future<AuthenticationPayloadSchema> signIn(@Body() SignInBody body);

  @POST('/authentication/signup')
  Future<AuthenticationPayloadSchema> signUp(@Body() SignUpBody body);

  @GET('/users/chat-recommended-users')
  Future<List<UserSchema>> getChatRecommendedUsers(
    @Query('takeCount') int takeCount,
  );

  @GET('/users/search')
  Future<List<UserSchema>> searchUsers(
    @Query('keyword') String keyword,
    @Query('takeCount') int takeCount,
  );

  @GET('/users/{userId}')
  Future<UserSchema> getUser(
    @Path('userId') int userId,
  );

  @GET('/chats')
  Future<ChatsPageSchema> getChats(
    @Query('lastId') int? lastId,
    @Query('takeCount') int takeCount,
  );

  @GET('/messages/{chatId}')
  Future<MessagesPageSchema> getMessages(
    @Path('chatId') int chatId,
    @Query('lastId') int? lastId,
    @Query('takeCount') int takeCount,
  );
}
