import 'package:bookme/features/authentication/data/models/request/user/user_request.dart';
import 'package:bookme/features/authentication/data/models/response/generic/message_response.dart';
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

  @override
  Future<Either<Failure, User>> fetchUser(String userId) {
    return makeRequest(authRemoteDataSource.fetchUser(userId));
  }

  @override
  Future<Either<Failure, User>> updateUser({
    required String id,
    String? firstName,
    String? lastName,
    String? email,
    String? address,
    String? phone,
    String? image,
    String? jobTitle,
    String? jobDescription,
    String? company,
    List<String>? skills,
    bool? isAgent,
  }) {
    return makeRequest(
      authRemoteDataSource.updateUser(
        userId: id,
        userRequest: UserRequest(
          firstName: firstName,
          lastName: lastName,
          email: email,
          address: address,
          phone: phone,
          image: image,
          jobDescription: jobDescription,
          jobTitle: jobTitle,
          company: company,
          skills: skills,
          isAgent: isAgent,
        ),
      ),
    );
  }

  @override
  Future<Either<Failure, MessageResponse>> logout() async {
    final Either<Failure, MessageResponse> response =
        await makeRequest(authRemoteDataSource.logout());
    return response.fold(
      (Failure failure) => left(failure),
      (MessageResponse response) async {
        await authLocalDataSource.deleteAuthResponse();
        return right(response);
      },
    );
  }

  @override
  Future<Either<Failure, User>> addUser({required UserRequest userRequest}) {
    return makeRequest(authRemoteDataSource.addUser(userRequest: userRequest));
  }
}
