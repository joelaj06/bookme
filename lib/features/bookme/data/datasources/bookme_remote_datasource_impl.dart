import 'package:bookme/core/utitls/app_http_client.dart';
import 'package:bookme/features/bookme/data/datasources/bookme_endpoints.dart';
import 'package:bookme/features/bookme/data/datasources/bookme_remote_datasource.dart';
import 'package:bookme/features/bookme/data/models/response/category/category_model.dart';
import 'package:bookme/features/bookme/data/models/response/listpage/listpage.dart';
import 'package:bookme/features/bookme/data/models/response/service/service_model.dart';

class BookmeRemoteDatasourceImpl implements BookmeRemoteDatasource{
  BookmeRemoteDatasourceImpl({required AppHTTPClient client})
      : _client = client ;

  final AppHTTPClient _client;
  @override
  Future<ListPage<Service>> fetchServices({required int page, required int size, String? query,  String? serviceId}) async {
    final Map<String,dynamic> json = await _client.get(BookmeEndpoints.services(page, size, serviceId));
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
  Future<ListPage<Service>> fetchServicesByCategory({required int page, required int size, String? query, required String categoryId}) async {
    final Map<String,dynamic> json = await _client.get(BookmeEndpoints.servicesByCategory(page, size, categoryId));
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
  Future<List<Category>> fetchCategories() async{
    final Map<String,dynamic> json = await _client.get(BookmeEndpoints.categories);
    final List<dynamic> items = json['items'] as List<dynamic>;
    final List<Category> categories = List<Category>.from(
      items.map<Category>(
            (dynamic json) => Category.fromJson(json as Map<String, dynamic>),
      ),
    );
    return categories;
  }

}