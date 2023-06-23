class BookmeEndpoints{
  static String services(int page, int size, String? id) =>
      'services/${id ?? ''}?page=$page&size=$size';
}