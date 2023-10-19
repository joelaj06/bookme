import 'package:bookme/core/errors/failure.dart';
import 'package:bookme/core/usecase/usecase.dart';
import 'package:bookme/features/authentication/data/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../models/response/user/user_model.dart';

class FetchUser implements UseCase<User, String>{
  FetchUser(this.authRepository);

  final AuthRepository authRepository;
  @override
  Future<Either<Failure, User>> call(String userId) {
    return authRepository.fetchUser(userId);
  }

}