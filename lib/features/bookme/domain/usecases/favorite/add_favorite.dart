import 'package:bookme/core/errors/failure.dart';
import 'package:bookme/core/usecase/usecase.dart';
import 'package:bookme/features/bookme/data/models/request/favorite/add_favorite_request.dart';
import 'package:bookme/features/bookme/data/models/response/favorite/favorite_model.dart';
import 'package:bookme/features/bookme/data/repository/bookme_repository.dart';
import 'package:dartz/dartz.dart';

class AddFavorite implements UseCase<Favorite, AddFavoriteRequest>{
  AddFavorite({required this.bookmeRepository});

  final BookmeRepository bookmeRepository;
  @override
  Future<Either<Failure, Favorite>> call(AddFavoriteRequest request) {
    return bookmeRepository.addFavorite(addFavoriteRequest: request);
  }

}