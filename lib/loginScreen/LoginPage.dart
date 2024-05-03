// ignore_for_file: unnecessary_null_comparison

import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:usermechanic/AppConstant/APIConstant.dart';
import 'package:usermechanic/Widget/styles.dart';
import 'package:usermechanic/auth/FirebaseService.dart';
import 'package:usermechanic/auth/logincontroller.dart';
import 'package:usermechanic/controller/notificationService.dart';
import 'package:usermechanic/utils/CircularButton.dart';
import 'package:usermechanic/utils/all_image.dart';
import 'package:usermechanic/utils/custom_snackbar.dart';
import 'package:usermechanic/utils/dimentions.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}
NotificationServices notificationServices = NotificationServices();
class _LoginPageState extends State<LoginPage> {
  final LoginController controller = Get.put(LoginController());
  final _formKey = GlobalKey<FormState>();

  String? deviceId;
  @override
  void initState() {
    super.initState();
    controller.getAddressFromLatLong();
    notificationServices.requestNotificationPermission();
    notificationServices.isTokenRefresh();
    notificationServices.getDeviceToken().then((value){
      if (kDebugMode)
      {
        controller.FCM_TOKEN.value=value;
        print( "FCM Token ==========>>>>>>>>>>>> \n${controller.FCM_TOKEN.value}");
      }

    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:[
            SizedBox(height: 10.0.h),
            Row(
              children: [
                SizedBox(
                  height: 220.0.h,
                  width: 300.0.w,
                  child: Image.asset(
                    AllImage.number.toString(),
                    height: 200.0.h,
                    width: 200.0.w,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.0.h),
            Center(child: Text(
              "Create a account",
              style: smallTextStyle.copyWith(fontSize:18.sp,fontWeight: FontWeight.bold, color: Colors.black.withAlpha(200)),
            )),
            SizedBox(height: 5.0.h),
            Center(child: Text(
              "you'll receive 4 digit code to verify next",
              style: smallTextStyle.copyWith(fontSize: Dimensions.fontSizeLarge, color: Colors.black),
            )),
            SizedBox(
              height: 50.0.h
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Spacer(
                  flex: 1,
                ),
                Expanded(
                    flex: 1,
                    child: TextFormField(
                      readOnly: true,
                      initialValue: "+91",
                      style:smallTextStyle.copyWith(fontSize: 20.sp),
                      decoration: const InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        isDense: true,
                      ),

                    ),

                ),
                 SizedBox(
                  width: 8.r,
                ),
                Expanded(
                    flex: 5,
                    child: Form(
                      key: _formKey,
                      child: TextFormField(
                        controller: controller.etMobile,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          counter: Offstage(),
                          hintText: "0000000000",
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 4, vertical: 8),
                        ),
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly, // Allow only digits
                        ],
                        validator: (value) {
                          if (value.toString().isEmpty) {
                            return "Please enter mobile no.";
                          }
                          if (value!.length < 10) {
                            showCustomSnackBar('Please enter 10 digit number', isError: true);
                            return 'Please enter 10 digit number';
                          }
                          return null;
                        },
                        maxLength: 10,
                        style: smallTextStyle.copyWith(fontSize:20.sp),
                      ),
                    )),
                SizedBox(
                  width: 20.w,
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding:  EdgeInsets.only(top: 20.r),
                    child: CircularButton(
                      onPress: () {
                        if (_formKey.currentState!.validate()) {
                          controller.loginNetworkApi();
                         // Get.to(()=>OtpVerifyScreen(id: id, otp: otp))
                        }

                        print("${SignIn}kdjkjbhf");

                      },
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 30.h,),
            Center(child: Text("Or Sign In With",style: smallTextStyle,)),
            SizedBox(height: 20.h,),
               InkWell(
                 child: Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 40.h,
                      width: 40.w,
                      child: InkWell(
                        onTap: ()async
                        {
                          UserCredential userCredential= await  FirebaseServices().signInWithGooglewithFirebase();
                          if(userCredential!=null)
                          {
                            controller.signUpwithSocialLoginNetworkApi(userCredential,deviceId??"");
                          }
                        },
                    child: Image.asset("assets/images/google.png"),
                      ),
                    ),
                    InkWell(
                      onTap: ()async
                      {
                        UserCredential userCredential= await  FirebaseServices().signInWithGooglewithFirebase();
                        if(userCredential!=null)
                        {
                          controller.signUpwithSocialLoginNetworkApi(userCredential,deviceId??"");
                        }

                      },
                        child: Text(" SignIn",style: bodybold3Style.copyWith(fontSize: 24.sp,color: Colors.black,fontWeight: FontWeight.bold),))
                  ],
            ),
               ),
            SizedBox(height: 40.h,),
            Center(child: Text("By signing in or creating an account, you agree  with our",style: smallTextStyle.copyWith(fontSize: 11.sp),)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
              InkWell(onTap:(){
                _termAndCondition(context);
              },child: Text("Term and condition",style: bodyboldStyle.copyWith(fontSize: 11.sp,color: Colors.blue,decoration: TextDecoration.underline),)),
              Text(" and ",style: smallTextStyle.copyWith(fontSize: 11.sp)),
              InkWell(onTap:(){
                _showPrivacySheet(context);
              },child: Text("Privacy Policy",style: bodyboldStyle.copyWith(fontSize: 11.sp,color: Colors.blue,decoration: TextDecoration.underline)))
            ],)
          ],
        ),
      ),
    );
  }

  void _showPrivacySheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      barrierColor: Colors.black.withOpacity(0.1),
      isScrollControlled: true,
      backgroundColor: Colors.white70,
      builder: (context) {
       controller.getCscNetworkApi();
        return ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
            child: Obx(()=>controller.privacymodel.value.data!=null?
              Container(
                width: double.infinity,
                height: Get.height - 150,
                child: Scaffold(
                  backgroundColor: Colors.transparent,
                  body: Container(
                      padding: EdgeInsets.all(10),
                      // height: h * 0.45,

                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 15,
                          ),
                          Center(
                            child: Container(
                              width: 40,
                              height: 7,
                              decoration: BoxDecoration(
                                  border:
                                  Border.all(width: 0.5, color: Colors.black38),
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  Text(controller.privacymodel.value.data!.title.toString(),style: smallTextStyle.copyWith(fontSize: 20.sp),),
                                  controller.privacymodel.value.data!.image!.isEmpty? Container(
                                    height: 200.h,
                                    width: Get.width,
                                    child: Image.network(BASE_URL+controller.privacymodel.value.data!.image.toString()),
                                  ):Container(),
                                  Html( data: controller.privacymodel.value.data!.description.toString(),style: {
                                    "body":Style(
                                        fontSize: FontSize(12.0),textAlign: TextAlign.justify
                                    ),
                                  },)
                                ],
                              ),
                            ),
                          )
                        ],
                      )
                  ),

                ),
              ):Container()
            ),
          ),
        );
      },
    );
  }

  void _termAndCondition(BuildContext context) {
    showModalBottomSheet(
      context: context,
      barrierColor: Colors.black.withOpacity(0.1),
      isScrollControlled: true,
      backgroundColor: Colors.white70,
      builder: (context) {
        controller.getTermAndCondition();
        return ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
            child: Obx(()=>controller.termcondition.value.data!=null?
            Container(
              width: double.infinity,
              height: Get.height - 150,
              child: Scaffold(
                backgroundColor: Colors.transparent,
                body: Container(
                    padding: EdgeInsets.all(10),
                    // height: h * 0.45,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 15,
                        ),
                        Center(
                          child: Container(
                            width: 40,
                            height: 7,
                            decoration: BoxDecoration(
                                border:
                                Border.all(width: 0.5, color: Colors.black38),
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                Text(controller.termcondition.value.data!.title.toString(),style: smallTextStyle.copyWith(fontSize: 20.sp),),
                                controller.termcondition.value.data!.image!.isNotEmpty? Container(
                                  height: 200.h,
                                  width: Get.width,
                                  child: Image.network(BASE_URL+controller.termcondition.value.data!.image.toString()),
                                ):Container(),
                                Html( data: controller.termcondition.value.data!.description.toString(),style: {
                                  "body":Style(
                                      fontSize: FontSize(12.0),textAlign: TextAlign.justify
                                  ),
                                },)
                              ],
                            ),
                          ),
                        )
                      ],
                    )
                ),

              ),
            ):Container()
            ),
          ),
        );
      },
    );
  }
}
