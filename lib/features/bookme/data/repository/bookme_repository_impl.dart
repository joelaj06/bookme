import 'package:bookme/core/errors/failure.dart';
import 'package:bookme/core/utitls/repository.dart';
import 'package:bookme/features/bookme/data/datasources/bookme_remote_datasource.dart';
import 'package:bookme/features/bookme/data/models/response/category/category_model.dart';
import 'package:bookme/features/bookme/data/models/response/listpage/listpage.dart';
import 'package:bookme/features/bookme/data/models/response/service/service_model.dart';
import 'package:bookme/features/bookme/data/repository/bookme_repository.dart';
import 'package:dartz/dartz.dart';

class BookmeRepositoryImpl extends Repository implements BookmeRepository {
  BookmeRepositoryImpl({required this.bookmeRemoteDatasource});


  final BookmeRemoteDatasource bookmeRemoteDatasource;
  @override
  Future<Either<Failure, ListPage<Service>>> fetchServices({required int size, required int page, String? query, String? serviceId}) {
    return makeRequest(bookmeRemoteDatasource.fetchServices(page: page, size: size));
  }

  @override
  Future<Either<Failure, ListPage<Service>>> fetchServicesByCategoryId({required int size, required int page, String? query, required String categoryId}) {
    return makeRequest(bookmeRemoteDatasource.fetchServicesByCategory(page: page, size: size, categoryId: categoryId));
  }

  @override
  Future<Either<Failure, List<Category>>> fetchCategories() {
    return makeRequest(bookmeRemoteDatasource.fetchCategories());
  }

}