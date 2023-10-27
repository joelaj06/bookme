import 'package:bookme/core/errors/failure.dart';
import 'package:bookme/core/usecase/usecase.dart';
import 'package:bookme/features/bookme/data/repository/bookme_repository.dart';
import 'package:dartz/dartz.dart';

class DeleteFavorite implements UseCase<void, String>{
  DeleteFavorite({required this.bookmeRepository});

  final BookmeRepository bookmeRepository;
  @override
  Future<Either<Failure, void>> call(String favoriteId) {
    return bookmeRepository.deleteFavorite(favoriteId: favoriteId);
  }

}