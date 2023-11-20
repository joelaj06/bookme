
import 'package:bookme/features/authentication/data/models/request/user/user_request.dart';
import 'package:bookme/features/authentication/data/models/response/generic/message_response.dart';
import 'package:bookme/features/authentication/data/models/response/user/user_model.dart';

import '../../../../core/utitls/app_http_client.dart';
import '../models/request/login/login_request.dart';
import '../models/response/login/login_response.dart';
import 'auth_endpoints.dart';
import 'auth_remote_data_source.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  const AuthRemoteDataSourceImpl({required AppHTTPClient client})
      : _client = client;
  final AppHTTPClient _client;
  @override
  Future<LoginResponse> login(LoginRequest request) async {
    final Map<String, dynamic> json = await _client.post(
      AuthEndpoints.signin,
      body: request.toJson(),
    );
    return LoginResponse.fromJson(json);
  }

  @override
  Future<User> fetchUser(String userId) async{
    final Map<String, dynamic> json = await _client.get(AuthEndpoints.user(userId));
    return User.fromJson(json);
  }

  @override
  Future<User> updateUser({required String userId, required UserRequest userRequest}) async {
    final Map<String, dynamic> json = await _client.put(AuthEndpoints.user(userId),
        body: userRequest.toJson());
    return User.fromJson(json);
  }

  @override
  Future<MessageResponse> logout() async{
   final Map<String, dynamic> json =  await _client.delete(AuthEndpoints.signOut);
   return MessageResponse.fromJson(json);
  }

  @override
  Future<User> addUser({required UserRequest userRequest}) async{
    final Map<String,dynamic> json = await _client.post(AuthEndpoints.signup, body: userRequest.toJson());
    return User.fromJson(json);
  }

}
