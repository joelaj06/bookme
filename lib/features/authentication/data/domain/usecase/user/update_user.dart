import 'package:bookme/core/errors/failure.dart';
import 'package:bookme/core/usecase/usecase.dart';
import 'package:bookme/features/authentication/data/models/request/user/user_request.dart';
import 'package:bookme/features/authentication/data/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../models/response/user/user_model.dart';

class UpdateUser implements UseCase<User, UserRequest>{
  UpdateUser(this.authRepository);

  final AuthRepository authRepository;

  @override
  Future<Either<Failure, User>> call(UserRequest request) {
    return authRepository.updateUser(id: request.id!,
      isAgent: request.isAgent,
      skills: request.skills,
      company: request.company,
      jobTitle: request.jobTitle,
      jobDescription: request.jobDescription,
      image: request.image,
      phone: request.phone,
      address: request.address,
      email: request.email,
      lastName: request.lastName,
      firstName: request.firstName,
    );
  }
}