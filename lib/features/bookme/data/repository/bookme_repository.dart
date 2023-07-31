import 'package:bookme/core/errors/failure.dart';
import 'package:bookme/features/bookme/data/models/response/category/category_model.dart';
import 'package:bookme/features/bookme/data/models/response/listpage/listpage.dart';
import 'package:bookme/features/bookme/data/models/response/service/service_model.dart';
import 'package:dartz/dartz.dart';

import '../models/response/review/review_model.dart';

abstract class BookmeRepository {
  Future<Either<Failure, ListPage<Service>>> fetchServices(
      {required int size, required int page, String? query, String? serviceId});

  Future<Either<Failure, ListPage<Service>>> fetchServicesByCategoryId(
      {required int size,
      required int page,
      String? query,
      required String categoryId});

  Future<Either<Failure, List<Category>>> fetchCategories();

  Future<Either<Failure, List<Review>>> fetchPopularServices();

  Future<Either<Failure, ListPage<Service>>> fetchPromotedServices(
      {required int size, required int page});
}
