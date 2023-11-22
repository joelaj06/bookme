import 'package:bookme/core/errors/failure.dart';

import 'package:bookme/features/authentication/data/domain/usecase/signup.dart';
import 'package:bookme/features/authentication/data/models/request/user/user_request.dart';
import 'package:bookme/features/authentication/data/models/response/user/user_model.dart';
import 'package:bookme/features/bookme/data/models/request/service/service_request.dart';
import 'package:bookme/features/bookme/domain/usecases/service/add_service.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../../core/presentation/widgets/app_dialog.dart';
import '../../../../../core/presentation/widgets/app_snacks.dart';
import '../../../../../core/utitls/base_64.dart';
import '../../../../bookme/data/models/response/category/category_model.dart';
import '../../../../bookme/data/models/response/service/service_model.dart';
import '../../../../bookme/presentation/home/getx/home_controller.dart';

class SignUpController extends GetxController {
  SignUpController({required this.userSignUp, required this.addService});

  final UserSignUp userSignUp;
  final AddService addService;

  //reactive variables
  RxBool isAgent = false.obs;
  final RxInt pageIndex = 0.obs;
  RxString userProfileImage = ''.obs;
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
  RxString serviceTitle = ''.obs;
  RxString serviceDescription = ''.obs;
  RxString password = ''.obs;
  RxString passwordConfirmation = ''.obs;
  RxBool showPassword = false.obs;
  RxBool isLoading = false.obs;
  Rx<User> user = User.empty().obs;
  RxList<String> base64Images = <String>[].obs;
  Rx<XFile?> selectedImageFile = XFile('').obs;
  RxList<String> selectedCategories = <String>[].obs;
  RxList<Category> categories = <Category>[].obs;
  RxDouble leastPrice = (0.0).obs;
  RxString serviceCoverImage = ''.obs;
  RxString location = ''.obs;

  ImagePicker picker = ImagePicker();
  final HomeController homeController = Get.find();
  final PageController pageController = PageController(initialPage: 0);

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

  void addAService() async {
    isLoading(true);
    final ServiceRequest serviceRequest = ServiceRequest(
        id: null,
        categories: selectedCategories,
        description: serviceDescription.value,
        title: serviceTitle.value,
        price: leastPrice.value,
        location: location.value,
        user: user.value.id,
        images: base64Images,
        coverImage: serviceCoverImage.value);
    final Either<Failure, Service> failureOrService =
        await addService(serviceRequest);
    failureOrService.fold(
      (Failure failure) {
        isLoading(false);
        AppSnacks.showError(
          'Error',
          failure.message,
        );
      },
      (Service service) {
        isLoading(false);
        Get.back<dynamic>(result:service);
      },
    );
  }

  void signUp() async {
    isLoading(true);
    final UserRequest userRequest = UserRequest(
        isAgent: isAgent.value,
        image: userProfileImage.value,
        lastName: lastName.value,
        firstName: firstName.value,
        skills: skills,
        email: email.value,
        address: address.value,
        phone: phone.value,
        jobDescription: jobDescription.value,
        jobTitle: jobTitle.value,
        company: company.value,
        password: password.value,
        confirmPassword: passwordConfirmation.value);
    final Either<Failure, User> failureOrUser = await userSignUp(userRequest);
    failureOrUser.fold(
      (Failure failure) {
        isLoading(false);
        AppSnacks.showError('Failure', failure.message);
      },
      (User userRes) {
        isLoading(false);
        user(userRes);
        if (isAgent.value) {
          navigatePages(2);
        } else {
          Get.back<dynamic>(result: userRes);
        }
      },
    );
  }

  Future<bool> checkPermission() async {
    final Map<Permission, PermissionStatus> statuses = await <Permission>[
      Permission.storage,
      Permission.camera,
    ].request();
    if (statuses[Permission.storage]!.isGranted &&
        statuses[Permission.camera]!.isGranted) {
      return true;
    } else {
      AppSnacks.showInfo('Image Upload', 'Permission not granted');
      return false;
    }
  }


  void addServiceImages() async {
    final bool isGranted = await checkPermission();
    if (isGranted) {
      final String? base64StringImage = await showImagePicker();
      if (base64StringImage != null) {
          base64Images.add(base64StringImage);
      }
    }
  }

  void addSingleImage() async {
    final bool isGranted = await checkPermission();
    if (isGranted) {
      final String? base64StringImage = await showImagePicker();
      if (base64StringImage != null) {
        if (pageIndex.value == 1) {
          userProfileImage(base64StringImage);
        } else {
          serviceCoverImage(base64StringImage);
        }
      }
    }
  }

  void removeImage(int index) {
    base64Images.removeAt(index);
  }

  Future<String?> showImagePicker() async {
    final XFile? imageFile =
        await picker.pickImage(source: ImageSource.gallery);
    if (imageFile != null) {
      final String base64StringImage =
          Base64Convertor().imageToBase64(imageFile.path);
      return base64StringImage;
    }
    return null;
  }

  void removeProfileImage() {
    userProfileImage('');
  }

  void togglePassword() {
    showPassword(!showPassword.value);
  }

  void onPageChanged(int index) {
    pageIndex(index);
  }

  void navigatePages(int value) {
    pageController.animateToPage(value,
        duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
  }

  void onAccountTypeSelected(BuildContext context, bool value) {
    final String accType = value ? 'Agent' : 'Client';
    AppDialog().showConfirmationDialog(
      context,
      accType,
      'Are you sure you want to continue as ${value ? 'an' : 'a'} $accType?',
      onTapConfirm: () {
        Navigator.pop(context);
        isAgent(value);
        navigatePages(1);
      },
    );
  }

  void onServiceLocationInputChanged(String? value){
    location(value);
  }

  void onLeastPriceInputChanged(String? value) {
    leastPrice(double.tryParse(value ?? '0.0'));
  }

  void onServiceTitleInputChanged(String value) {
    serviceTitle(value);
  }

  void onServiceDescriptionInputChanged(String value) {
    serviceDescription(value);
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

  void onPasswordInputChanged(String value) {
    password(value);
  }

  void onPasswordConfirmationInputChanged(String value) {
    passwordConfirmation(value);
  }

  String? validatePasswordConfirmation(String? value) {
    String? errorMessage;
    if (value!.isEmpty || value != password.value) {
      errorMessage = 'Password do not match';
    }
    return errorMessage;
  }

  String? validateName(String? value) {
    String? errorMessage;
    if (value!.isEmpty) {
      errorMessage = 'Field must not be empty';
    }
    return errorMessage;
  }

  String? validateSkills() {
    String? errorMessage;
    if (skills.isEmpty) {
      errorMessage = 'Add at least one skill';
    }
    return errorMessage;
  }

  String? validateEmail(String? email) {
    String? errorMessage;
    if (email!.isEmpty || !email.contains('@')) {
      errorMessage = 'Please enter a email address';
    }
    return errorMessage;
  }

  String? validatePassword(String? password) {
    String? errorMessage;
    if (password!.isNotEmpty) {
      if (password.length < 8) {
        errorMessage = 'Password must be 8 characters or more';
      }
    } else {
      errorMessage = 'Please enter password';
    }
    return errorMessage;
  }

  RxBool get agentFormIsValid => (validateEmail(email.value) == null &&
          validateSkills() == null &&
          validatePasswordConfirmation(passwordConfirmation.value) == null &&
          validateName(company.value) == null &&
          validateName(jobDescription.value) == null &&
          validateName(jobTitle.value) == null &&
          validateName(address.value) == null &&
          validateName(firstName.value) == null &&
          validateName(phone.value) == null &&
          validateName(lastName.value) == null &&
          validatePassword(password.value) == null)
      .obs;

  RxBool get clientFormIsValid => (validateEmail(email.value) == null &&
          validatePasswordConfirmation(passwordConfirmation.value) == null &&
          validateName(address.value) == null &&
          validateName(firstName.value) == null &&
          validateName(phone.value) == null &&
          validateName(lastName.value) == null &&
          validatePassword(password.value) == null)
      .obs;
}
