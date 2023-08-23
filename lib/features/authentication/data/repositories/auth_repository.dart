import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../models/request/login/login_request.dart';
import '../models/response/user/user_model.dart';



abstract class AuthRepository {
  Future<Either<Failure, User>> login(LoginRequest request);
  Future<Either<Failure, User>> loadUser();
}
