import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserProfileController extends GetxController{

  //reactive variables
  RxInt pageIndex = 0.obs;


  PageController pageController = PageController(initialPage: 0);

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