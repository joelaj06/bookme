import 'package:bookme/core/errors/failure.dart';
import 'package:bookme/features/bookme/data/models/request/booking/booking_request.dart';
import 'package:bookme/features/bookme/data/models/request/chat/chat_request.dart';
import 'package:bookme/features/bookme/data/models/request/favorite/add_favorite_request.dart';
import 'package:bookme/features/bookme/data/models/request/service/service_request.dart';
import 'package:bookme/features/bookme/data/models/response/booking/booking_model.dart';
import 'package:bookme/features/bookme/data/models/response/category/category_model.dart';
import 'package:bookme/features/bookme/data/models/response/chat/initiate_chat_model.dart';
import 'package:bookme/features/bookme/data/models/response/favorite/favorite_model.dart';
import 'package:bookme/features/bookme/data/models/response/listpage/listpage.dart';
import 'package:bookme/features/bookme/data/models/response/message/message_content_model.dart';
import 'package:bookme/features/bookme/data/models/response/message/message_model.dart';
import 'package:bookme/features/bookme/data/models/response/review/agent_rating_model.dart';
import 'package:bookme/features/bookme/data/models/response/service/service_model.dart';
import 'package:dartz/dartz.dart';

import '../models/response/chat/chat_model.dart';
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
      {required int size, required int page, String? query});

  Future<Either<Failure, AgentRating>> fetchAgentReviews(
      {required String agentId, String? userId});

  Future<Either<Failure, List<Booking>>> fetchBookings(
      {String? agentId, required String? userId});

  Future<Either<Failure, Service>> fetchServiceByUser();

  Future<Either<Failure, Service>> updateService(
      {required String serviceId, required ServiceRequest serviceRequest});

  Future<Either<Failure, Booking>> updateBooking(
      {required String bookingId, required BookingRequest bookingRequest});

  Future<Either<Failure, List<Favorite>>> fetchFavorites(
      {required String userId});

  Future<Either<Failure, Favorite>> addFavorite(
      {required AddFavoriteRequest addFavoriteRequest});

  Future<Either<Failure, Favorite>> deleteFavorite(
      {required String favoriteId});

  Future<Either<Failure, ListPage<Chat>>> fetchUserChats();

  Future<Either<Failure, InitiateChat>> initiateChat(
      {required ChatRequest chatRequest});

  Future<Either<Failure, ListPage<Message>>> fetchMessages(
      {required String chatId});

  Future<Either<Failure, Message>> sendMessage({
    required String chatId,
    required String recipient,
    required MessageContent message,
  });

  Future<Either<Failure, Service>> addService(
      {required ServiceRequest serviceRequest});
}
