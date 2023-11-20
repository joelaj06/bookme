import 'package:bookme/core/errors/failure.dart';
import 'package:bookme/core/usecase/usecase.dart';
import 'package:bookme/features/authentication/data/models/request/user/user_request.dart';
import 'package:bookme/features/authentication/data/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

import '../../models/response/user/user_model.dart';

class UserSignUp implements UseCase<User,UserRequest>{
  UserSignUp({required this.authRepository});

  final AuthRepository authRepository;
  @override
  Future<Either<Failure, User>> call(UserRequest request) {
   return authRepository.addUser(userRequest: request);
  }

}