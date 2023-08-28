import 'package:dartz/dartz.dart';

import '/core/usecase/usecase.dart';
import '../../../../../core/errors/failure.dart';
import '../../models/request/login/login_request.dart';
import '../../models/response/user/user_model.dart';
import '../../repositories/auth_repository.dart';



class LoginUser implements UseCase<User, LoginRequest> {
  LoginUser({required this.authRepository});
  final AuthRepository authRepository;

  @override
  Future<Either<Failure, User>> call(LoginRequest params) {
    return authRepository.login(params);
  }
}
