import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../../core/presentation/routes/app_routes.dart';

class TasksController extends GetxController{



  RxInt pageIndex = 0.obs;
  PageController pageController = PageController(initialPage: 0);



  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

  void navigateToBookingDetailsScreen(int index) {
    Get.toNamed<dynamic>(
      AppRoutes.bookingDetails,
      arguments: index,
    );
  }

  void navigatePages(int index) {
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );
  }

  void onPageChanged(int index) {
    pageIndex(index);
  }
}