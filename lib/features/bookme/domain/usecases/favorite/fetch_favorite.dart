import 'package:bookme/core/errors/failure.dart';
import 'package:bookme/core/usecase/usecase.dart';
import 'package:bookme/features/bookme/data/models/response/favorite/favorite_model.dart';
import 'package:bookme/features/bookme/data/repository/bookme_repository.dart';
import 'package:dartz/dartz.dart';

class FetchFavorites implements UseCase<List<Favorite>, String>{
  FetchFavorites({required this.bookmeRepository});

  final BookmeRepository bookmeRepository;
  @override
  Future<Either<Failure, List<Favorite>>> call(String userId) {
    return bookmeRepository.fetchFavorites(userId: userId);
  }

}