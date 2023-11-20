import 'package:bookme/core/errors/failure.dart';
import 'package:bookme/core/usecase/usecase.dart';
import 'package:bookme/features/bookme/data/models/request/service/service_request.dart';
import 'package:bookme/features/bookme/data/models/response/service/service_model.dart';
import 'package:bookme/features/bookme/data/repository/bookme_repository.dart';
import 'package:dartz/dartz.dart';

class AddService implements UseCase<Service,ServiceRequest>{
  AddService({required this.bookmeRepository});

  final BookmeRepository bookmeRepository;
  @override
  Future<Either<Failure, Service>> call(ServiceRequest request) {
    return bookmeRepository.addService(serviceRequest: request);
  }

}