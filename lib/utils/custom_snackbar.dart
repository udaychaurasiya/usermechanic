// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Widget/styles.dart';
import 'dimentions.dart';

void showCustomSnackBar(String message, {bool isError = true, bool getXSnackBar = false}) {

  if(message != null && message.isNotEmpty) {
    if(getXSnackBar) {
      Get.showSnackbar(GetSnackBar(
        backgroundColor: isError ? Colors.red : Colors.green,
        message: message,
        maxWidth: Dimensions.WEB_MAX_WIDTH,
        duration: const Duration(seconds: 3),
        snackStyle: SnackStyle.FLOATING,
        margin: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
        borderRadius: Dimensions.RADIUS_SMALL,
        isDismissible: true,
        snackPosition: SnackPosition.TOP,
        dismissDirection: DismissDirection.horizontal,
      ));
    }else {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
        dismissDirection: DismissDirection.horizontal,
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(Get.context!).size.height - 75,
          right: Dimensions.PADDING_SIZE_SMALL,
          /*top: Dimensions.PADDING_SIZE_SMALL, bottom: Dimensions.PADDING_SIZE_SMALL,*/ left: Dimensions.PADDING_SIZE_SMALL,
        ),
        duration: const Duration(seconds: 3),
        // action: SnackBarAction(label: 'Close', onPressed: (){}),
        showCloseIcon: true,
        closeIconColor: Colors.white,
        backgroundColor: isError ? Colors.red : Colors.green,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL)),
        content: Text(message, style: bodyboldStyle.copyWith(color: Colors.white,)),
      ));
    }
  }
}