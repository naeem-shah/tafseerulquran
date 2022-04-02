import 'package:flutter/material.dart';
import 'package:get/get.dart';

void messageLogger(String message) {
  if (Get.isSnackbarOpen) {
    Get.closeCurrentSnackbar();
  }
  Get.rawSnackbar(
    message: message,
    snackStyle: SnackStyle.FLOATING,
    snackPosition: SnackPosition.TOP,
    animationDuration: const Duration(
      milliseconds: 400,
    ),
    margin: const EdgeInsets.only(
      left: 12,
      right: 12,
      bottom: 12,
    ),
    borderRadius: 12,
    backgroundColor: Colors.green,
  );
}
