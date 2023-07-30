import 'package:bookme/core/errors/failure.dart';
import 'package:bookme/core/usecase/usecase.dart';
import 'package:bookme/features/bookme/data/models/response/review/review_model.dart';
import 'package:bookme/features/bookme/data/repository/bookme_repository.dart';
import 'package:dartz/dartz.dart';

class FetchPopularServices implements UseCase<List<Review>,NoParams>{
  FetchPopularServices({required this.bookmeRepository});

  final BookmeRepository bookmeRepository;
  @override
  Future<Either<Failure, List<Review>>> call(NoParams params) {
    return bookmeRepository.fetchPopularServices();
  }

}