import 'package:bookme/core/utitls/app_http_client.dart';
import 'package:bookme/features/bookme/data/datasources/bookme_remote_datasource_impl.dart';
import 'package:bookme/features/bookme/data/repository/bookme_repository.dart';
import 'package:bookme/features/bookme/data/repository/bookme_repository_impl.dart';
import 'package:get/get.dart';

import 'core/utitls/shared_preferences_wrapper.dart';

class MainBindings extends Bindings {
  @override
  void dependencies() {
    Get.put<SharedPreferencesWrapper>(
      SharedPreferencesWrapper(),
    );

    Get.put<AppHTTPClient>(
      AppHTTPClient(),
    );

    Get.put<BookmeRepository>(
      BookmeRepositoryImpl(
        bookmeRemoteDatasource: BookmeRemoteDatasourceImpl(
          client: Get.find(),
        ),
      ),
    );
  }
}
