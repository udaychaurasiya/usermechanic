import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:usermechanic/Widget/styles.dart';
class Button2 extends StatelessWidget {
  final VoidCallback onPress;
  final String text;
  const Button2({Key? key, required this.onPress, required this.text, }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        height: 45.h,
        width:150.w,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black,width: 1.w),
            borderRadius: BorderRadius.circular(30.r),
            color: Color(0xff038d7d)
        ),
        child:Center(child:Text(text,style: smallTextStyle.copyWith(fontSize: 16.sp,color: Colors.white),)),),
    );
  }
}
