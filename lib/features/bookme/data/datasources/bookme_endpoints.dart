class BookmeEndpoints{
  static String services(int page, int size, String? id) =>
      'services/${id ?? ''}?page=$page&size=$size';

  static String servicesWithQuery(int page, int size, String query) =>
      'services?query=$query&page=$page&size=$size';

  static String servicesByCategory(int page, int size, String categoryId,) =>
      'services?page=$page&size=$size&category_id=$categoryId';

  static const String categories = 'categories';

  static const String popularServices = 'services/popular_services';

  static String promotedServices(int page, int size) =>
      'services/promotions?page=$page&size=$size';

  static String promotedServicesWithQuery(int page, int size,String query) =>
      'services/promotions?page=$page&size=$size&query=$query';

  static String reviews(String agentId, String? userId) =>
      userId == null ? 'reviews/?agent_id=$agentId':
      'reviews/?agent_id=$agentId&user_id=$userId';

  static String bookings(String? agentId, String? userId) =>
      userId != null ? 'bookings/?user_id=$userId' :
      'bookings/?agent_id=$agentId';

  static const String userService = 'services/user';
  static String service(String serviceId) => 'services/$serviceId';

  static String booking(String bookingId) => 'bookings/$bookingId';
  static const String favorites = 'favorites';
  static String favorite(String serviceId) => 'favorites/$serviceId';

  static String userFavorites(String userId) => 'favorites?user_id=$userId';

}