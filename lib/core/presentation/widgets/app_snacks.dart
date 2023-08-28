
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class AppSnacks {
  AppSnacks._();


  static void showSuccess(String title, String message,){
    snackbar(title: title, message: message, color: Colors.green);
  }
 static void showError(String title, String message,){
    snackbar(title: title, message: message, color: Colors.red);
  }
  static void showInfo(String title, String message,){
     snackbar(title: title, message: message, color: Colors.blue);
  }

  static SnackbarController snackbar({required String title,
  required String message,required Color color}){
    return Get.snackbar(title, message,
      backgroundColor: color,
      duration:  const Duration(milliseconds: 2000),
      colorText: Colors.white,);
  }

}




