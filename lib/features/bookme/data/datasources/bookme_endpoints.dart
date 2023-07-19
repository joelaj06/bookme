class BookmeEndpoints{
  static String services(int page, int size, String? id) =>
      'services/${id ?? ''}?page=$page&size=$size';

  static String servicesByCategory(int page, int size, String categoryId,) =>
      'services?page=$page&size=$size&category_id=$categoryId';

  static const String categories = 'categories';
}