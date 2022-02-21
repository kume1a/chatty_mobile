import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../core/constants.dart';
import '../schema/authentication/authentication_payload_schema.dart';
import '../schema/body/sign_in_body.dart';
import '../schema/body/sign_up_body.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: Constants.apiUrl)
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @POST('/authentication/signin')
  Future<AuthenticationPayloadSchema> signIn(@Body() SignInBody body);

  @POST('/authentication/signup')
  Future<AuthenticationPayloadSchema> signUp(@Body() SignUpBody body);
}
