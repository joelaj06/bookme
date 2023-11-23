import 'package:bookme/core/errors/failure.dart';
import 'package:bookme/core/usecase/usecase.dart';
import 'package:bookme/features/authentication/data/models/response/user/user_model.dart';
import 'package:bookme/features/bookme/data/models/response/listpage/listpage.dart';
import 'package:bookme/features/bookme/data/repository/bookme_repository.dart';
import 'package:dartz/dartz.dart';

class FetchAgents implements UseCase<ListPage<User>, PageParams> {
  FetchAgents({required this.bookmeRepository});

  final BookmeRepository bookmeRepository;

  @override
  Future<Either<Failure, ListPage<User>>> call(PageParams params) {
    return bookmeRepository.fetchAgents(
        page: params.page, size: params.size, query: params.query);
  }
}
