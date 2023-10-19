

import 'package:bookme/features/authentication/data/models/request/user/user_request.dart';

import '../models/request/login/login_request.dart';
import '../models/response/login/login_response.dart';
import '../models/response/user/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<LoginResponse> login(LoginRequest request);
  Future<User> fetchUser(String userId);
  Future<User> updateUser({ required String userId,required UserRequest userRequest});
}
