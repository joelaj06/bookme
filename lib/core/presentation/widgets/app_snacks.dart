import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppSnacks {
  AppSnacks._();

  static void showSuccess(String title, String message, {Duration? duration}) {
    snackbar(
        title: title,
        message: message,
        color: Colors.green,
        duration: duration);
  }

  static void showError(String title, String message, {Duration? duration}) {
    snackbar(
        title: title, message: message, color: Colors.red, duration: duration);
  }

  static void showInfo(String title, String message, {Duration? duration}) {
    snackbar(
        title: title, message: message, color: Colors.blue, duration: duration);
  }

  static SnackbarController snackbar(
      {required String title,
      required String message,
      required Color color,
      Duration? duration}) {
    return Get.snackbar(
      title,
      message,
      backgroundColor: color,
      duration: duration ?? const Duration(milliseconds: 2000),
      colorText: Colors.white,
    );
  }
}
