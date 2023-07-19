
import 'package:bookme/core/errors/failure.dart';
import 'package:bookme/core/usecase/usecase.dart';
import 'package:bookme/features/bookme/data/models/response/listpage/listpage.dart';
import 'package:bookme/features/bookme/data/repository/bookme_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../data/models/response/service/service_model.dart';


class FetchServicesByCategory
    implements UseCase<ListPage<Service>, PageParams> {
  FetchServicesByCategory({required this.bookmeRepository});

  final BookmeRepository bookmeRepository;

  @override
  Future<Either<Failure, ListPage<Service>>> call(PageParams params) {
    return bookmeRepository.fetchServicesByCategoryId(
        size: params.size, page: params.page, categoryId: params.categoryId!);
  }
}
