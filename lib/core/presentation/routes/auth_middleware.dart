import 'package:bookme/core/presentation/routes/app_routes.dart';
import 'package:bookme/features/authentication/data/datasource/auth_local_data_source.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AuthMiddleware extends GetMiddleware{
  final AuthLocalDataSource authLocalDataSource = Get.find();

  bool isAuthenticated = false;
  void checkAuthentication() async{
     isAuthenticated = await authLocalDataSource.isAuthenticated();

  }

  @override
  RouteSettings? redirect(String? route)  {
    checkAuthentication();
    if ( !isAuthenticated) {
      // Redirect to the login page if not authenticated
      return const RouteSettings(name: AppRoutes.login);
    }
    // Allow access to the requested page
    return null;
  }
}