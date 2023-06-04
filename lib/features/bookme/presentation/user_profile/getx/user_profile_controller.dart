import 'package:bookme/core/presentation/routes/app_routes.dart';
import 'package:bookme/core/utitls/base_64.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

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
  RxBool applyDiscount = false.obs;
  RxString discountType = '%'.obs;
  RxList<String> discountValues = <String>['%', 'Gh¢'].obs;
  RxDouble leastPrice = (0.0).obs;
  RxList<String> base64Images = <String>[].obs;
  Rx<XFile?> selectedImageFile = XFile('').obs;

  PageController pageController = PageController(initialPage: 0);
  ImagePicker picker = ImagePicker();

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }



  void navigateToTasksScreen(){
    Get.toNamed<dynamic>(AppRoutes.tasks);
  }
 void navigateToFavoritesScreen(){
    Get.toNamed<dynamic>(AppRoutes.favorites);
  }

  void addImage() async {
    final Map<Permission, PermissionStatus> statuses = await <Permission>[
      Permission.storage,
      Permission.camera,
    ].request();
    if (statuses[Permission.storage]!.isGranted &&
        statuses[Permission.camera]!.isGranted) {
      showImagePicker();
    } else {
      debugPrint('no permission provided');
    }
  }

  void removeImage(int index) {
    base64Images.removeAt(index);
  }

  void showImagePicker() async {
    final XFile? imageFile =
        await picker.pickImage(source: ImageSource.gallery);
    if (imageFile != null) {
      final String base64StringImage =
          Base64Convertor().imageToBase64(imageFile.path);
      base64Images.insert(0, base64StringImage);
    }
  }

  void onApplyDiscountInputChanged(bool? value) {
    applyDiscount(value);
  }

  void onChipDeleted(int index) {
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
