import 'dart:convert';
import 'dart:typed_data';

import 'package:bookme/core/presentation/routes/app_routes.dart';
import 'package:bookme/core/presentation/widgets/app_snacks.dart';
import 'package:bookme/core/usecase/usecase.dart';
import 'package:bookme/core/utitls/base_64.dart';
import 'package:bookme/features/authentication/data/datasource/auth_local_data_source.dart';
import 'package:bookme/features/authentication/data/domain/usecase/user/fetch_user.dart';
import 'package:bookme/features/authentication/data/domain/usecase/user/update_user.dart';
import 'package:bookme/features/authentication/data/models/request/user/user_request.dart';
import 'package:bookme/features/authentication/data/models/response/generic/message_response.dart';
import 'package:bookme/features/authentication/data/models/response/user/user_model.dart';
import 'package:bookme/features/bookme/data/models/response/category/category_model.dart';
import 'package:bookme/features/bookme/data/models/response/discount/discount_model.dart';
import 'package:bookme/features/bookme/domain/usecases/service/fetch_service_by_user.dart';
import 'package:bookme/features/bookme/domain/usecases/service/update_service.dart';
import 'package:bookme/features/bookme/presentation/home/getx/home_controller.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../../core/errors/failure.dart';
import '../../../../authentication/data/domain/usecase/logout.dart';
import '../../../../authentication/data/models/response/login/login_response.dart';
import '../../../data/models/request/service/service_request.dart';
import '../../../data/models/response/service/service_model.dart';

class UserProfileController extends GetxController {
  UserProfileController({
    required this.fetchUser,
    required this.updateUser,
    required this.fetchServiceByUser,
    required this.updateService,
    required this.logout,
  });

  final FetchUser fetchUser;
  final UpdateUser updateUser;
  final FetchServiceByUser fetchServiceByUser;
  final UpdateService updateService;
  final Logout logout;

  //reactive variables
  RxInt pageIndex = 0.obs;
  RxString firstName = ''.obs;
  RxString lastName = ''.obs;
  RxString email = ''.obs;
  RxString address = ''.obs;
  RxString jobTitle = ''.obs;
  RxString jobDescription = ''.obs;
  RxString company = ''.obs;
  RxString phone = ''.obs;
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
  Rx<User> user = User.empty().obs;
  RxBool isLoading = false.obs;
  Rx<Service> service = Service.empty().obs;
  RxString serviceTitle = ''.obs;
  RxString serviceDescription = ''.obs;
  RxDouble discountValue = 0.0.obs;
  RxList<String> selectedCategories = <String>[].obs;
  RxList<Category> categories = <Category>[].obs;

  final HomeController homeController = Get.find();
  PageController pageController = PageController(initialPage: 0);
  ImagePicker picker = ImagePicker();
  final AuthLocalDataSource _authLocalDataSource = Get.find();

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  Future<bool> isAgent() async{
    final LoginResponse? response = await _authLocalDataSource.getAuthResponse();
    if(response!=null && response.user.isAgent){
      return true;
    }
    return false;
  }

  void userLogout() async {
    isLoading(true);
    final Either<Failure, MessageResponse> failureOrResponse =
        await logout(NoParams());
    failureOrResponse.fold(
      (Failure failure) {
        isLoading(false);
        AppSnacks.showError('Profile', failure.message);
      },
      (MessageResponse response) {
        isLoading(false);
        AppSnacks.showSuccess('Profile', 'User Logged Out Successfully');
        Get.toNamed<dynamic>(AppRoutes.base);
      },
    );
  }

  void updateTheService() async {
    if (base64Images.isEmpty || selectedCategories.isEmpty) {
      AppSnacks.showInfo('Profile', 'Please select at least one image');
      return;
    }

    isLoading(true);
    final Discount discount = Discount(
      type: discountType.value == '%' ? 'percentage' : 'amount',
      value: discountValue.value,
    );
    final ServiceRequest serviceRequest = ServiceRequest(
      id: service.value.id,
      categories: selectedCategories,
      description:
          serviceDescription.value.isEmpty ? null : serviceDescription.value,
      title: serviceTitle.value.isEmpty ? null : serviceTitle.value,
      isSpecialOffer: applyDiscount.value,
      price: leastPrice.value == (0.0) ? null : leastPrice.value,
      images: base64Images,
      discount: discount,
    );
    final Either<Failure, Service> failureOrService =
        await updateService(serviceRequest);

    failureOrService.fold(
      (Failure failure) {
        isLoading(false);
        //todo handle failure
      },
      (Service service) {
        isLoading(false);
        Get.back<dynamic>();
      },
    );
  }

  void updateDiscount(Discount? discount, bool discountApplied) {
    if (discount == null) {
      return;
    }
    applyDiscount(discountApplied);
    discountValue(discount.value);
    if (discount.type == 'amount') {
      discountType('Gh¢');
    } else {
      discountType('%');
    }
  }

  Future<void> getUserService() async {
    isLoading(true);
    final Either<Failure, Service> failureOrService =
        await fetchServiceByUser(NoParams());
    failureOrService.fold(
      (Failure failure) {
        isLoading(false);
        //todo handle failure
      },
      (Service userService) {
        isLoading(false);
        service(userService);
        final List<String> catIds =
            userService.categories!.map((Category cat) => cat.id).toList();
        selectedCategories(catIds);
        updateDiscount(
            userService.discount, userService.isSpecialOffer ?? false);
        // update images
        if (userService.images != null && userService.images!.isNotEmpty) {
          base64Images(userService.images);
        }
      },
    );
  }

  void updateTheUser() async {
    final UserRequest userRequest = UserRequest(
      id: user.value.id,
      firstName: firstName.value.isEmpty ? null : firstName.value,
      lastName: lastName.value.isEmpty ? null : lastName.value,
      email: email.value.isEmpty ? null : email.value,
      phone: phone.value.isEmpty ? null : phone.value,
      address: address.value.isEmpty ? null : address.value,
      jobTitle: jobTitle.value.isEmpty ? null : jobTitle.value,
      jobDescription:
          jobDescription.value.isEmpty ? null : jobDescription.value,
      company: company.value.isEmpty ? null : company.value,
      skills: skills,
    );

    final Either<Failure, User> failureOrUser = await updateUser(userRequest);
    failureOrUser.fold(
      (Failure failure) {
        //TODO Handle Failure
      },
      (User userRes) {
        Get.back<dynamic>(result: userRes);
      },
    );
  }

  Future<void> getUser() async {
    final LoginResponse? response = _authLocalDataSource.authResponse ??
        await _authLocalDataSource.getAuthResponse();
    final Either<Failure, User> failureOrUser =
        await fetchUser(response?.user.id ?? '');
    failureOrUser.fold(
      (Failure failure) {
        isLoading(false);
      },
      (User userRes) {
        isLoading(false);
        user(userRes);
        skills.clear();
        // Check if userRes.skills is not null before adding
        if (userRes.skills != null) {
          skills.addAll(user.value.skills!);
        }
      },
    );
  }

  Future<bool> get isAuthenticated async =>
      _authLocalDataSource.isAuthenticated();

  void navigateToTasksScreen() {
    Get.toNamed<dynamic>(AppRoutes.tasks);
  }

  void navigateToFavoritesScreen() {
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
      // Convert Base64 string to Uint8List
      final Uint8List buffer = base64Decode(base64StringImage.split(',')[1]);
      print(buffer);
    }
  }

  void navigateToUpdateProfileScreen() async {
    final dynamic result = await Get.toNamed<dynamic>(AppRoutes.updateUser);
    if (result != null) {
      await getUser();
    }
  }

  void onServiceTitleInputChanged(String value) {
    serviceTitle(value);
  }

  void onServiceDescriptionInputChanged(String value) {
    serviceDescription(value);
  }

  void onDiscountValueInputChanged(String? value) {
    discountValue(double.tryParse(value ?? '0.0'));
  }

  void onLeastPriceInputChanged(String? value) {
    leastPrice(double.tryParse(value ?? '0.0'));
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

  void onPhoneInputChanged(String value) {
    phone(value);
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
    jobDescription(value);
  }

  void onCompanyInputChanged(String value) {
    company(value);
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
