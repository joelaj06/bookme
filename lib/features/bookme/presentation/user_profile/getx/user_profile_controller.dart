import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserProfileController extends GetxController {

  //reactive variables
  RxInt pageIndex = 0.obs;
  RxString firstName = ''.obs;
  RxString lastName = ''.obs;
  RxString email = ''.obs;
  RxString address = ''.obs;
  RxString jobTitle = ''.obs;
  RxString jobDescription = ''.obs;
  RxString company = ''.obs;
  RxString skill = ''.obs;
  RxList<String> skills = <String>[].obs;
  Rx<TextEditingController> skillTextEditingController =
      TextEditingController().obs;


  PageController pageController = PageController(initialPage: 0);


  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }


  void onChipDeleted(int index){
    skills.removeAt(index);
  }

  void onFirstNameInputChanged(String value) {
    firstName(value);
  }

  void onSkillInputChanged() {
    skills.add(skillTextEditingController.value.text);
    skillTextEditingController.value.text = '';
    skill('');
  }

  void onLastNameInputChanged(String value) {
    lastName(value);
  }

  void onEmailInputChanged(String value) {
    email(value);
  }

  void onAddressInputChanged(String value) {
    address(value);
  }

  void onJobTitleInputChanged(String value) {
    jobTitle(value);
  }

  void onJobDescriptionInputChanged(String value) {
    firstName(value);
  }

  void onCompanyInputChanged(String value) {
    firstName(value);
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