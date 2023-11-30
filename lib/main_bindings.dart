import 'package:bookme/core/utitls/app_http_client.dart';
import 'package:bookme/features/bookme/data/datasources/bookme_remote_datasource_impl.dart';
import 'package:bookme/features/bookme/data/repository/bookme_repository.dart';
import 'package:bookme/features/bookme/data/repository/bookme_repository_impl.dart';
import 'package:get/get.dart';

import 'core/utitls/shared_preferences_wrapper.dart';
import 'features/authentication/data/datasource/auth_local_data_source.dart';
import 'features/authentication/data/datasource/auth_remote_data_source.dart';
import 'features/authentication/data/datasource/auth_remote_data_source_impl.dart';
import 'features/authentication/data/repositories/auth_repository.dart';
import 'features/authentication/data/repositories/auth_repository_impl.dart';

class MainBindings extends Bindings {
  @override
  void dependencies() {
    Get.put<SharedPreferencesWrapper>(
      SharedPreferencesWrapper(),
    );

    Get.put<AuthLocalDataSource>(
      AuthLocalDataSourceImpl(Get.find()),
    );


    Get.put<AppHTTPClient>(
      AppHTTPClient(Get.find()),
    );

    Get.put<AuthRemoteDataSource>(
      AuthRemoteDataSourceImpl(client: Get.find()),
    );

    Get.put<AuthRepository>(
      AuthRepositoryImpl(
        authRemoteDataSource: Get.find(),
        authLocalDataSource: Get.find(),
      ),
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
