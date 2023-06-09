import 'package:bookme/core/errors/failure.dart';
import 'package:bookme/features/bookme/data/models/response/listpage/listpage.dart';
import 'package:bookme/features/bookme/data/models/response/service/service_model.dart';
import 'package:dartz/dartz.dart';

abstract class BookmeRepository{
  Future<Either<Failure,ListPage<Service>>> fetchServices(
  {required int size, required int page, String? query,String? serviceId}
      );
}