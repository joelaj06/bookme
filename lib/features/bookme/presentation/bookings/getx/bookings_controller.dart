import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class BookingsController extends GetxController {
  // reactive variables
  RxInt pageIndex = 0.obs;

  PageController pageController = PageController(initialPage: 0);

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

  void navigatePages(int index){
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
