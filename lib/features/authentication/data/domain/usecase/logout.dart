import 'package:bookme/core/errors/failure.dart';
import 'package:bookme/core/usecase/usecase.dart';
import 'package:bookme/features/authentication/data/models/response/generic/message_response.dart';
import 'package:bookme/features/authentication/data/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

class Logout implements UseCase<MessageResponse,NoParams>{
  Logout({required this.authRepository});

  final AuthRepository authRepository;

  @override
  Future<Either<Failure, MessageResponse>> call(NoParams params) {
    return authRepository.logout();
  }
}