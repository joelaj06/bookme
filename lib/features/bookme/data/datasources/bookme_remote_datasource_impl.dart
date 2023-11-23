import 'package:bookme/core/utitls/app_http_client.dart';
import 'package:bookme/features/authentication/data/models/response/user/user_model.dart';
import 'package:bookme/features/bookme/data/datasources/bookme_endpoints.dart';
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
import 'package:bookme/features/bookme/data/models/response/message/message_model.dart';
import 'package:bookme/features/bookme/data/models/response/review/agent_rating_model.dart';
import 'package:bookme/features/bookme/data/models/response/review/review_model.dart';
import 'package:bookme/features/bookme/data/models/response/service/service_model.dart';

class BookmeRemoteDatasourceImpl implements BookmeRemoteDatasource {
  BookmeRemoteDatasourceImpl({required AppHTTPClient client})
      : _client = client;

  final AppHTTPClient _client;

  @override
  Future<ListPage<Service>> fetchServices(
      {required int page,
      required int size,
      String? query,
      String? serviceId}) async {
    final Map<String, dynamic> json;
    if (query == null || query.isEmpty) {
      json = await _client.get(BookmeEndpoints.services(page, size, serviceId));
    } else {
      json = await _client
          .get(BookmeEndpoints.servicesWithQuery(page, size, query));
    }
    final List<dynamic> items = json['items'] as List<dynamic>;
    final List<Service> services = List<Service>.from(
      items.map<Service>(
        (dynamic json) => Service.fromJson(json as Map<String, dynamic>),
      ),
    );
    return ListPage<Service>(
      grandTotalCount: int.parse(json['total_count'] as String),
      itemList: services,
    );
  }

  @override
  Future<ListPage<Service>> fetchServicesByCategory(
      {required int page,
      required int size,
      String? query,
      required String categoryId}) async {
    final Map<String, dynamic> json = await _client
        .get(BookmeEndpoints.servicesByCategory(page, size, categoryId));
    final List<dynamic> items = json['items'] as List<dynamic>;
    final List<Service> services = List<Service>.from(
      items.map<Service>(
        (dynamic json) => Service.fromJson(json as Map<String, dynamic>),
      ),
    );
    return ListPage<Service>(
      grandTotalCount: int.parse(json['total_count'] as String),
      itemList: services,
    );
  }

  @override
  Future<List<Category>> fetchCategories() async {
    final Map<String, dynamic> json =
        await _client.get(BookmeEndpoints.categories);
    final List<dynamic> items = json['items'] as List<dynamic>;
    final List<Category> categories = List<Category>.from(
      items.map<Category>(
        (dynamic json) => Category.fromJson(json as Map<String, dynamic>),
      ),
    );
    return categories;
  }

  @override
  Future<List<Review>> fetchPopularServices() async {
    final Map<String, dynamic> json =
        await _client.get(BookmeEndpoints.popularServices);
    final List<dynamic> items = json['items'] as List<dynamic>;
    final List<Review> popularServices = List<Review>.from(
      items.map<Review>(
        (dynamic json) => Review.fromJson(json as Map<String, dynamic>),
      ),
    );
    return popularServices;
  }

  @override
  Future<ListPage<Service>> fetchPromotedServices(
      {required int page, required int size, String? query}) async {
    final Map<String, dynamic> json;
    if (query == null || query.isEmpty) {
      json = await _client.get(BookmeEndpoints.promotedServices(page, size));
    } else {
      json = await _client
          .get(BookmeEndpoints.promotedServicesWithQuery(page, size, query));
    }
    final List<dynamic> items = json['items'] as List<dynamic>;
    final List<Service> services = List<Service>.from(
      items.map<Service>(
        (dynamic json) => Service.fromJson(json as Map<String, dynamic>),
      ),
    );
    return ListPage<Service>(
      grandTotalCount: int.parse(json['total_count'] as String),
      itemList: services,
    );
  }

  @override
  Future<AgentRating> fetchAgentReviews(
      {required String agentId, String? userId}) async {
    final Map<String, dynamic> json =
        await _client.get(BookmeEndpoints.reviews(agentId, userId));
    return AgentRating.fromJson(json);
  }

  @override
  Future<List<Booking>> fetchBookings(
      {String? agentId, required String? userId}) async {
    final Map<String, dynamic> json =
        await _client.get(BookmeEndpoints.bookings(agentId, userId));
    final List<dynamic> items = json['items'] as List<dynamic>;
    final List<Booking> bookings = List<Booking>.from(
      items.map<Booking>(
        (dynamic json) => Booking.fromJson(json as Map<String, dynamic>),
      ),
    );
    return bookings;
  }

  @override
  Future<Service> fetchUserService({required String? agentId}) async {
    final Map<String, dynamic> json;
    if (agentId == null || agentId.isEmpty) {
      json = await _client.get(BookmeEndpoints.userService);
    } else {
      json = await _client.get(BookmeEndpoints.userServiceById(agentId));
    }
    return Service.fromJson(json);
  }

  @override
  Future<Service> updateService(
      {required String serviceId,
      required ServiceRequest serviceRequest}) async {
    final Map<String, dynamic> json = await _client.put(
        BookmeEndpoints.serviceById(serviceId),
        body: serviceRequest.toJson());
    return Service.fromJson(json);
  }

  @override
  Future<Booking> updateBooking(
      {required String bookingId,
      required BookingRequest bookingRequest}) async {
    final Map<String, dynamic> json = await _client.put(
        BookmeEndpoints.bookingWithId(bookingId),
        body: bookingRequest.toJson());
    return Booking.fromJson(json);
  }

  @override
  Future<List<Favorite>> fetchFavorites({required String userId}) async {
    final Map<String, dynamic> json =
        await _client.get(BookmeEndpoints.userFavorites(userId));
    final List<dynamic> items = json['items'] as List<dynamic>;
    final List<Favorite> favorites = List<Favorite>.from(
      items.map<Favorite>(
        (dynamic json) => Favorite.fromJson(json as Map<String, dynamic>),
      ),
    );
    return favorites;
  }

  @override
  Future<Favorite> addFavorite(
      {required AddFavoriteRequest addFavoriteRequest}) async {
    final Map<String, dynamic> json = await _client
        .post(BookmeEndpoints.favorites, body: addFavoriteRequest.toJson());
    return Favorite.fromJson(json);
  }

  @override
  Future<Favorite> deleteFavorite({required String favoriteId}) async {
    final Map<String, dynamic> json =
        await _client.delete(BookmeEndpoints.favorite(favoriteId));
    return Favorite.fromJson(json);
  }

  @override
  Future<ListPage<Chat>> fetchUserChats() async {
    final Map<String, dynamic> json = await _client.get(BookmeEndpoints.chats);
    final List<dynamic> items = json['items'] as List<dynamic>;
    final List<Chat> chats = List<Chat>.from(
      items.map<Chat>(
        (dynamic json) => Chat.fromJson(json as Map<String, dynamic>),
      ),
    );
    return ListPage<Chat>(
      grandTotalCount: int.parse(json['total_count'] as String),
      itemList: chats,
    );
  }

  @override
  Future<InitiateChat> initiateChat({required ChatRequest chatRequest}) async {
    final Map<String, dynamic> json = await _client.post(
      BookmeEndpoints.initiateChat,
      body: chatRequest.toJson(),
    );
    return InitiateChat.fromJson(json);
  }

  @override
  Future<ListPage<Message>> fetchMessages({required String chatId}) async {
    final Map<String, dynamic> json =
        await _client.get(BookmeEndpoints.messages(chatId));
    final List<dynamic> items = json['items'] as List<dynamic>;
    final List<Message> messages = List<Message>.from(
      items.map<Message>(
        (dynamic json) => Message.fromJson(json as Map<String, dynamic>),
      ),
    );
    return ListPage<Message>(
      grandTotalCount: int.parse(json['total_count'] as String),
      itemList: messages,
    );
  }

  @override
  Future<Message> sendMessage(
      {required String chatId, required MessageRequest messageRequest}) async {
    final Map<String, dynamic> json = await _client
        .post(BookmeEndpoints.message(chatId), body: messageRequest.toJson());
    return Message.fromJson(json);
  }

  @override
  Future<Service> addService({required ServiceRequest serviceRequest}) async {
    final Map<String, dynamic> json = await _client
        .post(BookmeEndpoints.service, body: serviceRequest.toJson());
    return Service.fromJson(json);
  }

  @override
  Future<Booking> addBooking({required BookingRequest bookingRequest}) async {
    final Map<String, dynamic> json = await _client
        .post(BookmeEndpoints.booking, body: bookingRequest.toJson());
    return Booking.fromJson(json);
  }

  @override
  Future<ListPage<User>> fetchAgents(
      {required int page, required int size, required String? query}) async {
    final Map<String, dynamic> json;
    if (query == null || query.isEmpty) {
      json = await _client.get(BookmeEndpoints.agents(page, size));
    } else {
      json =
          await _client.get(BookmeEndpoints.agentsWithQuery(query, page, size));
    }
    final List<dynamic> items = json['items'] as List<dynamic>;
    final List<User> users = List<User>.from(
      items.map<User>(
        (dynamic json) => User.fromJson(json as Map<String, dynamic>),
      ),
    );
    return ListPage<User>(
      grandTotalCount: int.parse(json['total_count'] as String),
      itemList: users,
    );
  }
}
