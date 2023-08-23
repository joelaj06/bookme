
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

}
