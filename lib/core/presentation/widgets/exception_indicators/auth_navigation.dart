import 'package:bookme/core/presentation/widgets/exception_indicators/unauthorized_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../routes/app_routes.dart';
class AuthNavigation extends StatelessWidget {
  const AuthNavigation({
    required this.future,
    required this.child,
    super.key});

  final Future<bool>? future;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
        future: future,
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.data == true) {
            return child;
          }
          return UnauthorizedIndicator(
            onPressed: () {
              Get.toNamed<dynamic>(AppRoutes.login);
            },
          );
        });
  }
}
