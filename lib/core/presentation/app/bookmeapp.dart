import 'package:bookme/core/presentation/routes/app_routes.dart';
import 'package:bookme/core/presentation/theme/app_light_theme.dart';
import 'package:bookme/core/presentation/theme/app_theme.dart';
import 'package:bookme/core/utitls/shared_prefs_keys.dart';
import 'package:bookme/main_bindings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../features/authentication/data/datasource/auth_local_data_source.dart';
import '../../utitls/shared_preferences_wrapper.dart';
import '../routes/pages.dart';

class BookMeApp extends StatelessWidget {
  BookMeApp({required this.token, Key? key}) : super(key: key);

  String? token;

  @override
  Widget build(BuildContext context) {
    Get.put<SharedPreferencesWrapper>(
      SharedPreferencesWrapper(),
    );

    Get.put<AuthLocalDataSource>(
      AuthLocalDataSourceImpl(Get.find()),
    );

    final SharedPreferencesWrapper sharedPreferencesWrapper = Get.find();
    void storeDeviceToken() async {
      if (token != null) {
        await sharedPreferencesWrapper.setString(
            SharedPrefsKeys.fcmToken, token!);
      }
    }

    return Builder(builder: (BuildContext context) {
      storeDeviceToken();
      return ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (BuildContext context, Widget? child) => GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'BookMe',
            theme: AppTheme(AppLightTheme()).data,
            getPages: Pages.pages,
            initialBinding: MainBindings(),
            initialRoute: AppRoutes.base),
      );
    });
  }
}
