// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:usermechanic/Widget/styles.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPress;
  final String title;
  const CustomButton({Key? key, required this.onPress, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: onPress,
      style: ElevatedButton.styleFrom(
          backgroundColor: Colors.teal,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0.r)),
          padding:  EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 12.0.h)
      ),
      child: Text(title.toUpperCase(), style: smallText1Style.copyWith(
        color:  Colors.white,
        fontWeight: FontWeight.w600,
        fontSize: 14.sp,
      ),textAlign: TextAlign.center,),
    );
  }
}
