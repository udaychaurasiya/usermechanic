// ignore_for_file: file_names

import 'package:animate_do/animate_do.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:usermechanic/loginScreen/LoginPage.dart';

class SpalshScreen extends StatelessWidget {
  const SpalshScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Stack(children: [
        FadeInUp(
          delay: Duration(microseconds: 450),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                 "assets/images/splash_img.png",
                  height: 300.r,
                  width: Get.width,
                  fit: BoxFit.fill,
                ),
                SizedBox(height: 10.0.h,),
                DefaultTextStyle(
                  style:  TextStyle(
                    fontSize: 20.r,
                  ),
                  child: AnimatedTextKit(
                    animatedTexts: [
                      WavyAnimatedText(
                        'RepairDo',
                        textStyle:  TextStyle(
                          fontSize: 30.sp,
                          color:  Color(0xff049486),
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                    onTap: (){},
                    isRepeatingAnimation: true,
                    totalRepeatCount: 100,
                    stopPauseOnTap: true,
                    repeatForever: true,

                  ),
                )
              ],
            ),
          ),
        ),
      ]),
      backgroundColor: Colors.white,
      nextScreen:  LoginPage(),
      splashIconSize: 450.h,
    );
  }
}
