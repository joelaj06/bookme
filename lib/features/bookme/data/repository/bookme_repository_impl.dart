import 'package:bookme/core/errors/failure.dart';
import 'package:bookme/core/utitls/repository.dart';
import 'package:bookme/features/bookme/data/datasources/bookme_remote_datasource.dart';
import 'package:bookme/features/bookme/data/models/request/service_request.dart';
import 'package:bookme/features/bookme/data/models/response/booking/booking_model.dart';
import 'package:bookme/features/bookme/data/models/response/category/category_model.dart';
import 'package:bookme/features/bookme/data/models/response/listpage/listpage.dart';
import 'package:bookme/features/bookme/data/models/response/review/agent_rating_model.dart';
import 'package:bookme/features/bookme/data/models/response/review/review_model.dart';
import 'package:bookme/features/bookme/data/models/response/service/service_model.dart';
import 'package:bookme/features/bookme/data/repository/bookme_repository.dart';
import 'package:dartz/dartz.dart';
//todo sort imports
class BookmeRepositoryImpl extends Repository implements BookmeRepository {
  BookmeRepositoryImpl({required this.bookmeRemoteDatasource});


  final BookmeRemoteDatasource bookmeRemoteDatasource;
  @override
  Future<Either<Failure, ListPage<Service>>> fetchServices({required int size, required int page, String? query, String? serviceId}) {
    return makeRequest(bookmeRemoteDatasource.fetchServices(page: page, size: size, query: query));
  }

  @override
  Future<Either<Failure, ListPage<Service>>> fetchServicesByCategoryId({required int size, required int page, String? query, required String categoryId}) {
    return makeRequest(bookmeRemoteDatasource.fetchServicesByCategory(page: page, size: size, categoryId: categoryId));
  }

  @override
  Future<Either<Failure, List<Category>>> fetchCategories() {
    return makeRequest(bookmeRemoteDatasource.fetchCategories());
  }

  @override
  Future<Either<Failure, List<Review>>> fetchPopularServices() {
    return makeRequest(bookmeRemoteDatasource.fetchPopularServices());
  }

  @override
  Future<Either<Failure, ListPage<Service>>> fetchPromotedServices({required int size, required int page, String? query}) {
    return makeRequest(bookmeRemoteDatasource.fetchPromotedServices(page: page, size: size,query:query));
  }

  @override
  Future<Either<Failure, AgentRating>> fetchAgentReviews({required String agentId, String? userId}) {
    return makeRequest(bookmeRemoteDatasource.fetchAgentReviews(agentId: agentId, userId: userId));
  }

  @override
  Future<Either<Failure, List<Booking>>> fetchBookings({String? agentId, required String? userId}) {
    return makeRequest(bookmeRemoteDatasource.fetchBookings(agentId: agentId, userId: userId));

  }

  @override
  Future<Either<Failure, Service>> fetchServiceByUser() {
    return makeRequest(bookmeRemoteDatasource.fetchUserService());
  }

  @override
  Future<Either<Failure, Service>> updateService({required String serviceId, required ServiceRequest serviceRequest}) {
    return makeRequest(bookmeRemoteDatasource.updateService(serviceId: serviceId, serviceRequest: serviceRequest));
  }



}