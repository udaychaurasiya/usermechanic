// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../utils/dimentions.dart';

class CustomAnimation extends GetxController{

  void showCustomSnackBar(String message,
      {bool isError = true, bool getXSnackBar = false}) {
    if (message != null && message.isNotEmpty) {
      if (getXSnackBar) {
        Get.showSnackbar(GetSnackBar(
          backgroundColor: isError ? Colors.red : Colors.green,
          message: message,
          maxWidth: Dimensions.WEB_MAX_WIDTH,
          duration: const Duration(seconds: 2),
          snackStyle: SnackStyle.FLOATING,
          snackPosition: SnackPosition.TOP, // Position at the top
          margin:  EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
          borderRadius: Dimensions.RADIUS_SMALL,
          isDismissible: true,
          dismissDirection: DismissDirection.horizontal,
        ));
      } else {
        Get.showSnackbar(GetSnackBar(
          backgroundColor: isError ? Colors.red : /*Color(0xff051ba6)*/ Colors.green,
          message: message,
          maxWidth: Dimensions.WEB_MAX_WIDTH,
          duration: const Duration(seconds: 2),
          snackStyle: SnackStyle.FLOATING,
          snackPosition: SnackPosition.TOP, // Position at the top
          margin: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
          borderRadius: Dimensions.RADIUS_SMALL,
          isDismissible: true,
          dismissDirection: DismissDirection.horizontal,
        ));
        /* ScaffoldMessenger.of(Get.context!).showSnackBar(
          SnackBar(
            dismissDirection: DismissDirection.horizontal,
            margin: EdgeInsets.only(
              right: Dimensions.PADDING_SIZE_SMALL,
              // top: 70,
              left: Dimensions.PADDING_SIZE_SMALL,
              bottom: Get.height - 65.h,
            ),
            duration: const Duration(seconds: 2),
            backgroundColor: isError ? Colors.red : Colors.green,
            behavior: SnackBarBehavior.floating, // Position as floating
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
            ),
            content: Text(
              message,
              style: robotoMedium.copyWith(color: Colors.white),
            ),
          ),
        );*/
      }
    }
  }

  showCustomToast(String message, {bool isError = true}) {
    if (message != null && message.isNotEmpty) {
      Fluttertoast.showToast(
          msg: message,
          backgroundColor: isError ? Colors.red.shade400 : Colors.black,
          textColor: Colors.white);

    }
  }

}
