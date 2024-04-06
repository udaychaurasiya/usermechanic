// ignore_for_file: library_private_types_in_public_api

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:usermechanic/Splash/splash_screen.dart';
import 'package:usermechanic/Widget/styles.dart';
import 'package:usermechanic/utils/all_image.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const MyHomePage(title: 'Introduction Screen Plugin'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FadeInDownBig(
        delay: Duration(microseconds: 225),
        child: IntroductionScreen(
          bodyPadding: EdgeInsets.only(top: 50.0.h),
          pages: [
            PageViewModel(
              image: Image.asset(
               "assets/images/onb1.jpg",fit: BoxFit.cover, height: 250.0.h, width: 250.0.w
              ),
              titleWidget: Text(
                "The location of the vehicle",
                style: bodyboldStyle.copyWith(fontSize: 25.sp, fontWeight: FontWeight.bold),
              ),
              bodyWidget: Center(
                child: Text(
                  "Mention any relevant information regarding the location's accessibility. Briefly mention any positive attributes or reputation associated with the location.",
                  textAlign: TextAlign.center,
                  style: smallTextStyle.copyWith(color: Colors.black, fontSize: 16.sp),
                ),
              ),
            ),
            PageViewModel(
              image: Image.asset(AllImage.onboarding_payment,
                  fit: BoxFit.cover, height: 250.0.h, width: 250.0.w),
              titleWidget: FadeInUp(
                delay: Duration(microseconds: 450),
                child: Text(
                  "Payment online method now",
                  style: bodyboldStyle.copyWith(fontSize: 25.sp, fontWeight: FontWeight.bold),
                ),
              ),
              bodyWidget: Text(
                "Customers can pay for car repairs by using their credit card. The payment is made electronically and can be settled later with the credit card company.",
                textAlign: TextAlign.center,
                style: smallTextStyle.copyWith(color: Colors.black, fontSize: 16.sp),
              ),
            ),
            PageViewModel(
              image: Image.asset("assets/images/onb2.jpg",fit: BoxFit.cover, height: 250.0.h, width: 250.0.w),
              titleWidget: Text(
                "Bike Repair Solutions",
                style: bodyboldStyle.copyWith(fontSize: 25.sp, fontWeight: FontWeight.bold),
              ),
              bodyWidget: Center(
                child: Text(
                  "Our experts are proficient in diagnosing and fixing electrical issues, battery problems, and more. We ensure your vehicle's electrical systems are functioning flawlessly.",
                  textAlign: TextAlign.center,
                  style: smallTextStyle.copyWith(color: Colors.black, fontSize: 16.sp),
                ),
              ),
            ),
          ],
          onDone: () {
           Get.to(()=>SpalshScreen());
          },
          showSkipButton: true,
          showNextButton: true,
          nextFlex: 1,
          dotsFlex: 2,
          // skipFlex: 1,
          animationDuration: 1000,
          curve: Curves.fastOutSlowIn,
          dotsDecorator: DotsDecorator(
              spacing:  EdgeInsets.all(5.w),
              activeColor: const Color(0xff049486),
              // activeSize: Size.square(10),
              // size: Size.square(5),
              activeSize:  Size(20.w, 10.h),
              size:  Size.square(10.r),
              activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25))),
          skip: Container(
            height: 60.h,
            width: 60.w,
            decoration: BoxDecoration(
                color: const Color(0xff049486),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.shade300,
                      blurRadius: 10.r,
                      offset: const Offset(4, 4))
                ]),
            child:  Center(
              child: Text(
                "Skip",
                style: bodybold2Style.copyWith(color: Colors.white),
              ),
            ),
          ),
          next: Container(
            height: 60.h,
            width: 60.w,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xff049486), width: 2.w)),
            child:  Center(
              child: Icon(
                Icons.navigate_next,
                size: 30.sp,
                color: Color(0xff049486),
              ),
            ),
          ),
          done: Container(
            height: 60.h,
            width: 60.w,
            decoration: BoxDecoration(
                color: const Color(0xff049486),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.shade300,
                      blurRadius: 40.r,
                      offset: const Offset(4, 4))
                ]),
            child:  Center(
              child: Text(
                "Done",
                style: bodybold2Style.copyWith(color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
