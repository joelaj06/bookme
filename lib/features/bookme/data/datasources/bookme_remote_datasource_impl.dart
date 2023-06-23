import 'package:bookme/core/utitls/app_http_client.dart';
import 'package:bookme/features/bookme/data/datasources/bookme_endpoints.dart';
import 'package:bookme/features/bookme/data/datasources/bookme_remote_datasource.dart';
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
    final List<Service> categories = List<Service>.from(
      items.map<Service>(
            (dynamic json) => Service.fromJson(json as Map<String, dynamic>),
      ),
    );
    return ListPage<Service>(
      grandTotalCount: int.parse(json['total_count'] as String),
      itemList: categories,
    );
  }

}