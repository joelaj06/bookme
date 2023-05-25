import 'package:bookme/core/presentation/routes/app_routes.dart';
import 'package:bookme/core/presentation/theme/app_light_theme.dart';
import 'package:bookme/core/presentation/theme/app_theme.dart';
import 'package:bookme/features/bookme/presentation/home/getx/home_bindings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../routes/pages.dart';
class BookMeApp extends StatelessWidget {
  const BookMeApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BookMe',
      theme: AppTheme(AppLightTheme()).data,
      getPages: Pages.pages,
      initialBinding: HomeBindings(),
      initialRoute: AppRoutes.base
    );
  }
}
