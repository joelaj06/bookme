class BookmeEndpoints {
  static String services(int page, int size, String? id) =>
      'services/${id ?? ''}?page=$page&size=$size';

  static String servicesWithQuery(int page, int size, String query) =>
      'services?query=$query&page=$page&size=$size';

  static String servicesByCategory(
    int page,
    int size,
    String categoryId,
  ) =>
      'services?page=$page&size=$size&category_id=$categoryId';

  static const String categories = 'categories';

  static const String popularServices = 'services/popular_services';

  static String promotedServices(int page, int size) =>
      'services/promotions?page=$page&size=$size';

  static String promotedServicesWithQuery(int page, int size, String query) =>
      'services/promotions?page=$page&size=$size&query=$query';

  static String reviews(String agentId, String? userId) => userId == null
      ? 'reviews/?agent_id=$agentId'
      : 'reviews/?agent_id=$agentId&user_id=$userId';

  static String bookings(String? agentId, String? userId) => userId != null
      ? 'bookings/?user_id=$userId'
      : 'bookings/?agent_id=$agentId';

  static const String userService = 'services/user';

  static String userServiceById(String agentId) => 'services/user?agentId=$agentId';
  static const String service = 'services';

  static const String booking = 'bookings';

  static String serviceById(String serviceId) => 'services/$serviceId';

  static String bookingWithId(String bookingId) => 'bookings/$bookingId';
  static const String favorites = 'favorites';

  static String favorite(String serviceId) => 'favorites/$serviceId';

  static String userFavorites(String userId) => 'favorites?user_id=$userId';

  static const String chats = 'chats';
  static const String initiateChat = 'chats/initiate';
  static String message(String chatId) => 'chats/$chatId/message';

  static String messages(String chatId) =>'chats/$chatId/messages';

  static String agents(int page, int size) => 'users/agents?page=$page&size=$size';
  static  String agentsWithQuery(String query,int page, int size) => 'users/agents?page=$page&size=$size&query=$query';
}
