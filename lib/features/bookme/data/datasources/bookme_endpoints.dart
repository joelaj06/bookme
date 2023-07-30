class BookmeEndpoints{
  static String services(int page, int size, String? id) =>
      'services/${id ?? ''}?page=$page&size=$size';

  static String servicesByCategory(int page, int size, String categoryId,) =>
      'services?page=$page&size=$size&category_id=$categoryId';

  static const String categories = 'categories';

  static const String popularServices = 'services/popular_services';

  static String servicePromotions(int page, int size) =>
      'services/promotions?page=$page&size=$size';
}