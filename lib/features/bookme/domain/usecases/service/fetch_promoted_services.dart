import 'package:bookme/core/errors/failure.dart';
import 'package:bookme/core/usecase/usecase.dart';
import 'package:dartz/dartz.dart';

import '../../../data/models/response/listpage/listpage.dart';
import '../../../data/models/response/service/service_model.dart';
import '../../../data/repository/bookme_repository.dart';

class FetchPromotedServices implements UseCase<ListPage<Service>,PageParams>{
  FetchPromotedServices({required this.bookmeRepository});

  final BookmeRepository bookmeRepository;
  @override
  Future<Either<Failure, ListPage<Service>>> call(PageParams params) {
    return bookmeRepository.fetchPromotedServices(size: params.size, page: params.page);
  }

}