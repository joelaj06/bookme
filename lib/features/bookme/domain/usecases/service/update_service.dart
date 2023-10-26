import 'package:bookme/core/errors/failure.dart';
import 'package:bookme/core/usecase/usecase.dart';
import 'package:bookme/features/bookme/data/models/request/service/service_request.dart';
import 'package:bookme/features/bookme/data/repository/bookme_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../data/models/response/service/service_model.dart';

class UpdateService implements UseCase<Service, ServiceRequest> {
  UpdateService({required this.bookmeRepository});

  final BookmeRepository bookmeRepository;

  @override
  Future<Either<Failure, Service>> call(ServiceRequest serviceRequest) {
    return bookmeRepository.updateService(
      serviceId: serviceRequest.id!,
      serviceRequest: serviceRequest,
    );
  }
}
