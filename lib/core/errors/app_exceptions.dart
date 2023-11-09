import 'package:get/get.dart';
import '../../features/authentication/data/datasource/auth_local_data_source.dart';
import '../presentation/routes/app_routes.dart';

class AppException implements Exception {
  AppException(this.message, this.prefix, this.url);

  String message;
  String prefix;
  String url;
}

class BadRequestException extends AppException {
  BadRequestException(String message, String url)
      : super(message, 'Bad Request', url);
}

class CacheException extends AppException {
  CacheException(String message, String url)
      : super(message, 'Couldn\'t find cached data.', url);
}

class FetchDataException extends AppException {
  FetchDataException(String message, String url)
      : super(message, 'Unable to process', url);
}

class ServerException extends AppException {
  ServerException(String message, String url)
      : super(message, 'Internal Server Error', url);
}

class ApiNotRespondingException extends AppException {
  ApiNotRespondingException(String message, String url)
      : super(message, 'Api Not Responding', url);
}

class UnauthorizedException extends AppException {
  UnauthorizedException(String message, String url)
      : super(message, 'Unauthorized Request', url){
    if(Get.currentRoute != AppRoutes.login){
       postUnAuthorized();
    }
  }

  void postUnAuthorized() async {
    final AuthLocalDataSource authLocalDataSource =
        Get.find<AuthLocalDataSource>();
    await authLocalDataSource.deleteAuthResponse();
    // AppSnacks().showError('Sign in', 'You need to sign in to continue');
    navigateToLogin();
  }

  void navigateToLogin() => Get.offAllNamed<void>(AppRoutes.login);
}
