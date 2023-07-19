import 'package:bookme/core/errors/failure.dart';
import 'package:bookme/core/usecase/usecase.dart';
import 'package:bookme/features/bookme/data/models/response/category/category_model.dart';
import 'package:bookme/features/bookme/data/repository/bookme_repository.dart';
import 'package:dartz/dartz.dart';

class FetchCategories implements UseCase<List<Category>, NoParams>{
  FetchCategories({required this.bookmeRepository});

  final BookmeRepository bookmeRepository;

  @override
  Future<Either<Failure, List<Category>>> call(NoParams params) {
    return bookmeRepository.fetchCategories();
  }
}