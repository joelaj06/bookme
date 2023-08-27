import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class LoginController extends GetxController{

  //text editing controllers
  Rx<TextEditingController> passwordTextEditingController =
      TextEditingController().obs;
  RxBool showPassword = false.obs;
  RxBool isLoading = false.obs;
  RxString email = ''.obs;
  RxString password = ''.obs;



  @override
  void dispose() {
    passwordTextEditingController.value.dispose();
    super.dispose();
  }


  void togglePassword(){
    showPassword(!showPassword.value);
  }

  void onEmailInputChanged(String value) {
    email(value);
  }

  void onPasswordInputChanged(String value) {
    password(value);
  }

  String? validateEmail(String? email) {
    String? errorMessage;
    if (email!.isEmpty) {
      errorMessage = 'Please enter email address';
    }
    return errorMessage;
  }

  String? validatePassword(String? password) {
    String? errorMessage;
    if (password!.isEmpty) {
      errorMessage = 'Please enter password';
    }
    return errorMessage;
  }

  RxBool get formIsValid =>
      (validateEmail(email.value) == null &&
          validatePassword(password.value) == null).obs;

}