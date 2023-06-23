import 'package:bookme/core/errors/failure.dart';
import 'package:bookme/core/usecase/usecase.dart';
import 'package:bookme/features/bookme/data/models/response/listpage/listpage.dart';
import 'package:bookme/features/bookme/data/models/response/service/service_model.dart';
import 'package:bookme/features/bookme/data/repository/bookme_repository.dart';
import 'package:dartz/dartz.dart';

class FetchServices implements UseCase<ListPage<Service>, PageParams>{
  FetchServices({required this.bookmeRepository});

  final BookmeRepository bookmeRepository;
  @override
  Future<Either<Failure, ListPage<Service>>> call(PageParams params) {
    print('********************************');
    return bookmeRepository.fetchServices(size: params.size, page: params.page);
  }

}