import 'package:bookme/core/errors/failure.dart';
import 'package:bookme/core/utitls/repository.dart';
import 'package:bookme/features/bookme/data/datasources/bookme_remote_datasource.dart';
import 'package:bookme/features/bookme/data/models/request/booking/booking_request.dart';
import 'package:bookme/features/bookme/data/models/request/chat/chat_request.dart';
import 'package:bookme/features/bookme/data/models/request/favorite/add_favorite_request.dart';
import 'package:bookme/features/bookme/data/models/request/message/message_request.dart';
import 'package:bookme/features/bookme/data/models/request/service/service_request.dart';
import 'package:bookme/features/bookme/data/models/response/booking/booking_model.dart';
import 'package:bookme/features/bookme/data/models/response/category/category_model.dart';
import 'package:bookme/features/bookme/data/models/response/chat/chat_model.dart';
import 'package:bookme/features/bookme/data/models/response/chat/initiate_chat_model.dart';
import 'package:bookme/features/bookme/data/models/response/favorite/favorite_model.dart';
import 'package:bookme/features/bookme/data/models/response/listpage/listpage.dart';
import 'package:bookme/features/bookme/data/models/response/message/message_content_model.dart';
import 'package:bookme/features/bookme/data/models/response/message/message_model.dart';
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
  Future<Either<Failure, ListPage<Service>>> fetchServices(
      {required int size,
      required int page,
      String? query,
      String? serviceId}) {
    return makeRequest(bookmeRemoteDatasource.fetchServices(
        page: page, size: size, query: query));
  }

  @override
  Future<Either<Failure, ListPage<Service>>> fetchServicesByCategoryId(
      {required int size,
      required int page,
      String? query,
      required String categoryId}) {
    return makeRequest(bookmeRemoteDatasource.fetchServicesByCategory(
        page: page, size: size, categoryId: categoryId));
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
  Future<Either<Failure, ListPage<Service>>> fetchPromotedServices(
      {required int size, required int page, String? query}) {
    return makeRequest(bookmeRemoteDatasource.fetchPromotedServices(
        page: page, size: size, query: query));
  }

  @override
  Future<Either<Failure, AgentRating>> fetchAgentReviews(
      {required String agentId, String? userId}) {
    return makeRequest(bookmeRemoteDatasource.fetchAgentReviews(
        agentId: agentId, userId: userId));
  }

  @override
  Future<Either<Failure, List<Booking>>> fetchBookings(
      {String? agentId, required String? userId}) {
    return makeRequest(
        bookmeRemoteDatasource.fetchBookings(agentId: agentId, userId: userId));
  }

  @override
  Future<Either<Failure, Service>> fetchServiceByUser() {
    return makeRequest(bookmeRemoteDatasource.fetchUserService());
  }

  @override
  Future<Either<Failure, Service>> updateService(
      {required String serviceId, required ServiceRequest serviceRequest}) {
    return makeRequest(bookmeRemoteDatasource.updateService(
        serviceId: serviceId, serviceRequest: serviceRequest));
  }

  @override
  Future<Either<Failure, Booking>> updateBooking(
      {required String bookingId, required BookingRequest bookingRequest}) {
    return makeRequest(bookmeRemoteDatasource.updateBooking(
        bookingId: bookingId, bookingRequest: bookingRequest));
  }

  @override
  Future<Either<Failure, List<Favorite>>> fetchFavorites(
      {required String userId}) {
    return makeRequest(bookmeRemoteDatasource.fetchFavorites(userId: userId));
  }

  @override
  Future<Either<Failure, Favorite>> addFavorite(
      {required AddFavoriteRequest addFavoriteRequest}) {
    return makeRequest(bookmeRemoteDatasource.addFavorite(
        addFavoriteRequest: addFavoriteRequest));
  }

  @override
  Future<Either<Failure, Favorite>> deleteFavorite(
      {required String favoriteId}) {
    return makeRequest(
        bookmeRemoteDatasource.deleteFavorite(favoriteId: favoriteId));
  }

  @override
  Future<Either<Failure, ListPage<Chat>>> fetchUserChats() {
    return makeRequest(bookmeRemoteDatasource.fetchUserChats());
  }

  @override
  Future<Either<Failure, InitiateChat>> initiateChat(
      {required ChatRequest chatRequest}) {
    return makeRequest(
        bookmeRemoteDatasource.initiateChat(chatRequest: chatRequest));
  }

  @override
  Future<Either<Failure, ListPage<Message>>> fetchMessages(
      {required String chatId}) {
    return makeRequest(bookmeRemoteDatasource.fetchMessages(chatId: chatId));
  }

  @override
  Future<Either<Failure, Message>> sendMessage(
      {required String chatId,
      required String recipient,
      required MessageContent message}) {
    return makeRequest(
      bookmeRemoteDatasource.sendMessage(
        chatId: chatId,
        messageRequest: MessageRequest(
          recipient: recipient,
          message: message,
        ),
      ),
    );
  }

  @override
  Future<Either<Failure, Service>> addService(
      {required ServiceRequest serviceRequest}) {
    return makeRequest(
        bookmeRemoteDatasource.addService(serviceRequest: serviceRequest));
  }
}
