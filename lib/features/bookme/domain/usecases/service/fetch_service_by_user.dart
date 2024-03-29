import 'package:bookme/core/errors/failure.dart';
import 'package:bookme/core/usecase/usecase.dart';
import 'package:bookme/features/bookme/data/models/response/service/service_model.dart';
import 'package:bookme/features/bookme/data/repository/bookme_repository.dart';
import 'package:dartz/dartz.dart';

class FetchServiceByUser implements UseCase<Service, PageParams>{
  FetchServiceByUser({required this.bookmeRepository});

  final BookmeRepository bookmeRepository;

  @override
  Future<Either<Failure, Service>> call(PageParams params) {
    return bookmeRepository.fetchServiceByUser(agentId: params.agentId);
  }
}