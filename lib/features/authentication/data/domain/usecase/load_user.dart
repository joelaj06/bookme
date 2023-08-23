//import 'dart:ffi';

import 'package:dartz/dartz.dart';

import '/core/usecase/usecase.dart';
import '../../../../../core/errors/failure.dart';
import '../../models/response/user/user_model.dart';
import '../../repositories/auth_repository.dart';


class LoadUser implements UseCase<User,void> {
  LoadUser({required this.authRepository});
  final AuthRepository authRepository;

  @override
  Future<Either<Failure, User>> call(void a) {
    return authRepository.loadUser();
  }
}
