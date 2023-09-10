import 'package:dartz/dartz.dart';



import '../../../../core/errors/failure.dart';
import '../../../../core/utitls/repository.dart';
import '../datasource/auth_local_data_source.dart';
import '../datasource/auth_remote_data_source.dart';
import '../models/request/login/login_request.dart';
import '../models/response/login/login_response.dart';
import '../models/response/user/user_model.dart';
import 'auth_repository.dart';

class AuthRepositoryImpl extends Repository implements AuthRepository {
  AuthRepositoryImpl({
    required this.authRemoteDataSource,
    required this.authLocalDataSource,
  });

  final AuthRemoteDataSource authRemoteDataSource;
  final AuthLocalDataSource authLocalDataSource;

  @override
  Future<Either<Failure, User>> login(LoginRequest request) async {
    final Either<Failure, LoginResponse> response =
        await makeRequest(authRemoteDataSource.login(request));
    return response.fold((Failure failure) => left(failure),
        (LoginResponse response) async {
      await authLocalDataSource.persistAuthResponse(response);
      print(response.user.firstName);
      return right(response.user);
    });
  }

  @override
  Future<Either<Failure, User>> loadUser() async {
    final Either<Failure, LoginResponse> response =
        await makeLocalRequest(authLocalDataSource.getAuthResponse);
    return response.fold((Failure failure) => left(failure),
        (LoginResponse response) async {
      await authLocalDataSource.persistAuthResponse(response);
      return right(response.user);
    });
  }


}
