import 'package:bookme/features/bookme/data/models/response/listpage/listpage.dart';
import 'package:bookme/features/bookme/data/models/response/service/service_model.dart';

abstract class BookmeRemoteDatasource {
  Future<ListPage<Service>> fetchServices(
      {required int page, required int size, String? query, String? serviceId});
}
