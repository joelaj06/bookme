

import '../models/request/login/login_request.dart';
import '../models/response/login/login_response.dart';

abstract class AuthRemoteDataSource {
  Future<LoginResponse> login(LoginRequest request);
}
