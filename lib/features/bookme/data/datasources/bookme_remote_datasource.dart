import 'package:bookme/features/bookme/data/models/request/booking/booking_request.dart';
import 'package:bookme/features/bookme/data/models/request/favorite/add_favorite_request.dart';
import 'package:bookme/features/bookme/data/models/response/category/category_model.dart';
import 'package:bookme/features/bookme/data/models/response/favorite/favorite_model.dart';
import 'package:bookme/features/bookme/data/models/response/listpage/listpage.dart';
import 'package:bookme/features/bookme/data/models/response/review/agent_rating_model.dart';
import 'package:bookme/features/bookme/data/models/response/review/review_model.dart';
import 'package:bookme/features/bookme/data/models/response/service/service_model.dart';

import '../models/request/service/service_request.dart';
import '../models/response/booking/booking_model.dart';

abstract class BookmeRemoteDatasource {
  Future<ListPage<Service>> fetchServices(
      {required int page, required int size, String? query, String? serviceId});

  Future<ListPage<Service>> fetchServicesByCategory(
      {required int page,
      required int size,
      String? query,
      required String categoryId});

  Future<List<Category>> fetchCategories();

  Future<List<Review>> fetchPopularServices();

  Future<ListPage<Service>> fetchPromotedServices({
    required int page,
    required int size,
    String? query,
  });

  Future<AgentRating> fetchAgentReviews(
      {required String agentId, String? userId});

  Future<List<Booking>> fetchBookings(
      {String? agentId, required String? userId});

  Future<Service> fetchUserService();

  Future<Service> updateService(
      {required String serviceId, required ServiceRequest serviceRequest});

  Future<Booking> updateBooking(
      {required String bookingId, required BookingRequest bookingRequest});

  Future<List<Favorite>> fetchFavorites({required String userId});

  Future<Favorite> addFavorite({required AddFavoriteRequest addFavoriteRequest});

  Future<Favorite> deleteFavorite({required String favoriteId});
}
