import 'package:bookme/features/bookme/data/models/response/category/category_model.dart';
import 'package:bookme/features/bookme/data/models/response/listpage/listpage.dart';
import 'package:bookme/features/bookme/data/models/response/review/review_model.dart';
import 'package:bookme/features/bookme/data/models/response/service/service_model.dart';

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
}
