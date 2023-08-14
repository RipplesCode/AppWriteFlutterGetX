import 'package:flutter/material.dart';
import 'package:get/get.dart';


class CustomSnackBar {
  static void showErrorSnackBar({
    required BuildContext? context,
    required String title,
    required String message,
  }) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red,
      titleText: Text(
        title,
        style: Theme.of(Get.context!).textTheme.titleLarge!.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white),
      ),
      messageText: Text(
        message,
        style: Theme.of(Get.context!).textTheme.titleLarge!.copyWith(
            fontSize: 14,
            fontWeight: FontWeight.normal,
            color:Colors.white),
      ),
      colorText: Colors.white,
      borderRadius: 8,
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(8),
      icon: const Icon(
        Icons.error_outline,
        size: 40,
        color: Colors.white,
      ),
      shouldIconPulse: true,
      duration: const Duration(seconds: 4),
    );
  }

  static void showInfoSnackBar({
    required BuildContext? context,
    required String title,
    required String message,
  }) {
     Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.blue,
      titleText: Text(
        title,
        style: Theme.of(Get.context!).textTheme.titleLarge!.copyWith(
            fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
      ),
      messageText: Text(
        message,
        style: Theme.of(Get.context!).textTheme.titleLarge!.copyWith(
            fontSize: 14, fontWeight: FontWeight.normal, color: Colors.white),
      ),
      colorText: Colors.white,
      borderRadius: 8,
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(8),
      icon: const Icon(
        Icons.error_outline,
        size: 40,
        color: Colors.white,
      ),
      shouldIconPulse: true,
      duration: const Duration(seconds: 4),
    );
    
  }

  static void showSuccessSnackBar({
    required BuildContext? context,
    required String title,
    required String message,
  }) {
   Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      titleText: Text(
        title,
        style: Theme.of(Get.context!).textTheme.titleLarge!.copyWith(
            fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
      ),
      messageText: Text(
        message,
        style: Theme.of(Get.context!).textTheme.titleLarge!.copyWith(
            fontSize: 14, fontWeight: FontWeight.normal, color: Colors.white),
      ),
      colorText: Colors.white,
      borderRadius: 8,
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(8),
      icon: const Icon(
        Icons.error_outline,
        size: 40,
        color: Colors.white,
      ),
      shouldIconPulse: true,
      duration: const Duration(seconds: 4),
    );
  }
}
