// // ignore_for_file: unnecessary_null_comparison, file_names
// import 'dart:async';
// import 'package:animate_do/animate_do.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:intl/intl.dart';
// import 'package:otp_text_field/otp_text_field.dart';
// import 'package:otp_text_field/style.dart';
// import 'package:usermechanic/Widget/styles.dart';
// import 'package:usermechanic/auth/logincontroller.dart';
// import 'package:usermechanic/loginScreen/LoginPage.dart';
//
// import '../utils/all_image.dart';
// import '../utils/dimentions.dart';
//
// class OtypVerifyPage extends StatefulWidget {
//   final String id;
//   final String otp;
//   OtypVerifyPage({Key? key, required this.id, required this.otp}) : super(key: key);
//
//   @override
//   State<OtypVerifyPage> createState() => _OtypVerifyPageState();
// }
//
// class _OtypVerifyPageState extends State<OtypVerifyPage> {
//   LoginController _controller=Get.put(LoginController());
//   DateTime? currentBackPressTime;
//
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     _controller.resetTimer();
//   }
//   @override
//   Widget build(BuildContext context){
//     RxString etotp="".obs;
//     return WillPopScope(
//       onWillPop: onWillPop,
//       child: Scaffold(
//         backgroundColor: const Color(0xffffffff),
//         body: SafeArea(
//           child: SingleChildScrollView(
//             child: GetBuilder<LoginController>(
//               builder: (controller) {
//                 return Container(
//                   margin: const EdgeInsets.only(left: 15, right: 15, top: 16),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: <Widget>[
//                       Row(
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: [
//                           SizedBox(width: 10.w,height: 10.h,),
//                           IconButton(onPressed: (){
//                             Get.to(()=>LoginPage());
//                           }, icon: Icon(Icons.clear)),
//                           SizedBox(width: 30.w,),
//                           Text( 'Verify Phone',
//                               style: smallTextStyle.copyWith(fontSize:18.sp ,color: Colors.black)
//                           ),
//                         ],
//                       ),
//                       SizedBox(height: 10.0.h),
//                       SizedBox(
//                         height: 220.0.h,
//                         width: 300.0.w,
//                         child: Image.asset(
//                           AllImage.otp.toString(),
//                           height: 200.0.h,
//                           width: 200.0.w,
//                           fit: BoxFit.cover,
//                         ),),
//                       SizedBox(height: 10.0.h),
//                       Center(child: Text(
//                         "Code is send to ",
//                         style: bodyboldStyle.copyWith(fontSize: Dimensions.fontSizeLarge, color: Colors.black),
//                       ),),
//                       SizedBox(height: 10.0.h),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.only(top: 20.0, right: 5.0),
//                             child: Text(
//                               "Code",
//                               style: bodyboldStyle.copyWith(
//                                   fontSize: 18.sp, color: Colors.black),
//                               textAlign: TextAlign.center,
//                             ),
//                           ),
//                           SizedBox(width: 5.0.w),
//                           Container(
//                             width: 150.w,
//                             height: 40.h,
//                             child: OTPTextField(
//                               length: 4,
//                               width: MediaQuery.of(context).size.width,
//                               fieldWidth: 30.w,
//                               style: TextStyle(
//                                   fontSize: 17.sp,fontWeight: FontWeight.bold
//                               ),
//                               textFieldAlignment: MainAxisAlignment.spaceAround,
//                               fieldStyle: FieldStyle.underline,
//                               onCompleted: (pin) {
//                                 etotp.value=pin;
//                                 _controller.verifyNetworkkApi(widget.id, pin);
//                               },
//
//                             ),
//                           ),
//                         ],
//                       ),
//                       SizedBox(height: 30.0.h,),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Text(
//                             "Didn't receive code? ",
//                             style: smallTextStyle.copyWith(fontSize: Dimensions.fontSizeLarge, color: Colors.grey.shade500),
//                           ),
//                           Text(
//                             "Request again",
//                             style: bodyboldStyle.copyWith(fontSize: Dimensions.fontSizeLarge, color: Colors.black),
//                           ),
//                         ],
//                       ),
//                       SizedBox(height: 5.0.h),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Obx(() => Text(
//                                   DateFormat('mm').format(
//                                       DateTime(0, 0, 0, 0, _controller.seconds.value)),
//                                   style: smallTextStyle.copyWith(
//                                       fontSize: Dimensions.fontSizeDefault2,
//                                       decoration: TextDecoration.underline,
//                                       color: Colors.green),
//                                 ),
//                               ),
//                               SizedBox(width: 8.0.w),
//                               Obx(()=>
//                                  InkWell(
//                                   onTap: () {
//                                     if (_controller.seconds.value == 00) {
//                                       _controller.loginNetworkApi();
//                                       _controller.resetTimer();
//                                     }
//                                   },
//                                   child: Text(
//                                     "Resend Code?",
//                                     style: titleStyle.copyWith(
//                                         fontSize: 16.0.sp,
//                                         decoration: TextDecoration.underline,
//                                         color: _controller.seconds.value != 00
//                                             ? Color(0xff049486)
//                                             : Color(0xff049486)),
//                                   )),
//                               ),
//
//                             ],
//                           ),
//                       SizedBox(height: 40.0.h),
//                       Align(
//                         alignment: Alignment.center,
//                         child: InkWell(onTap: (){
//                           _controller.verifyNetworkkApi(widget.id, etotp.value);
//                         },
//                           child: Container(
//                             height: 40.0.h,
//                             width: 250.0.w,
//                             alignment: Alignment.center,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(5.0),
//                               color: Color(0xff049486),
//                             ),
//                             child: Text('Verify and Create Account',style: bodyboldStyle.copyWith(fontSize: Dimensions.fontSizeDefault2, color: Colors.white),),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 );
//               }
//             ),
//           ),
//       )),
//     );
//   }
//   Future<bool> onWillPop(){
//     DateTime now = DateTime.now();
//     if (currentBackPressTime == null || now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
//       currentBackPressTime = now;
//       ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Center(child: Text("Press again to exit",style: bodyboldStyle.copyWith(color: Colors.white),)),
//             backgroundColor:Theme.of(context).appBarTheme.backgroundColor,
//             elevation: 10, //shadow
//             behavior: SnackBarBehavior.floating,
//             margin: EdgeInsets.only(left: 60.w,right: 60.w),
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(50.r),
//             ),
//           )
//       );
//       return Future.value(false);
//     }
//     return Future.value(true);
//   }
// }


// ignore_for_file: unrelated_type_equality_checks, unnecessary_null_comparison, must_be_immutable, file_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:usermechanic/Widget/TextStyle.dart';
import 'package:usermechanic/Widget/btn.dart';
import 'package:usermechanic/Widget/coustomAnimation.dart';
import 'package:usermechanic/Widget/styles.dart';
import 'package:usermechanic/auth/logincontroller.dart';
import 'package:usermechanic/utils/dimentions.dart';

class OtpVerifyScreen extends StatefulWidget {
  final String id;
  final String otp;
  const OtpVerifyScreen({Key? key, required this.id, required this.otp})
      : super(key: key);

  @override
  State<OtpVerifyScreen> createState() => _OtpVerifyScreen();
}

class _OtpVerifyScreen extends State<OtpVerifyScreen> {
  final LoginController _controller = Get.put(LoginController());

  @override
  void initState() {
    _controller.resetTimer();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    RxString verifyOtp = "".obs;
    return  Scaffold(
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              SizedBox(height: 40.0.h),
              Padding(
                  padding: EdgeInsets.only(left: 8.0.w),
                  child: Row(
                    children: [
                      IconButton(onPressed: (){
                        Get.back();
                      }, icon:  Icon(Icons.clear,size: 18.r,)),
                      Text("Verify ",style: titleStyle,)
                    ],
                  )
              ),
              SizedBox(
                height: 240.h,
                width: Get.width,
                child: Image.asset(
                          "assets/images/otp.png",
                          fit: BoxFit.cover,
                        ),

              ),
              Text(
                "Enter the verification code we just sent\nyou on your",
                style: smallTextStyle,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 50.0.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0, right: 5.0),
                    child: Text(
                      "Code",
                      style: titleStyle.copyWith(
                          fontSize: 18.0.sp, color: Colors.black),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    width: 150.0.w,
                    height: 40.0.h,
                    child: Form(
                      // key: _formKey,
                      child: OTPTextField(
                        length: 4,
                        controller: _controller.otpController,
                        width: MediaQuery.of(context).size.width,
                        fieldWidth: 30.0.w,
                        style: TextStyle(
                          fontSize: 17.r,
                          fontWeight: FontWeight.bold,
                        ),
                        inputFormatter: [
                          FilteringTextInputFormatter.digitsOnly,
                          // Allow only digits
                        ],
                        textFieldAlignment: MainAxisAlignment.spaceAround,
                        fieldStyle: FieldStyle.underline,
                        onChanged: (value) {
                          verifyOtp.value = value;
                        },
                        onCompleted: (pin) {
                          verifyOtp.value = pin;
                          _controller.verifyNetworkkApi(widget.id, pin);
                        },
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.only(top: 50, right: 15, bottom: 40),
                width: Get.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Obx(
                          () => Text(
                        DateFormat('mm').format(
                            DateTime(0, 0, 0, 0, _controller.seconds.value)),
                        style: robotoMedium.copyWith(
                            fontSize: Dimensions.fontSizeDefault2,
                            decoration: TextDecoration.underline,
                            color: const Color(0xff051ba6)),
                      ),
                    ),
                    SizedBox(width: 8.0.w),
                    InkWell(
                      onTap: () {
                        if (_controller.seconds.value == 00) {
                          _controller.resetTimer();
                          _controller.loginNetworkApi();
                        }
                      },
                      child: Obx(() => Text(
                        "Resend Code?",
                        style: titleStyle.copyWith(
                            fontSize: 16.0.sp,
                            decoration: TextDecoration.underline,
                            color: _controller.seconds.value != 00
                                ? Colors.grey.shade300
                                : Colors.blue),
                      )),
                    )
                  ],
                ),
              ),
              CustomButton(
                onPress: () async{
                  if(verifyOtp.value.isEmpty){
                    CustomAnimation().showCustomToast("Please fill four digit number");
                  }else{
                    bool status = await _controller.verifyNetworkkApi(widget.id, verifyOtp.value);
                    if(status == true){
                      _controller.getAddressFromLatLong();
                      // _controller.currentAddressNetworkApi();
                    }
                  }
                },
                title: "Verify Code",
              )
            ],
          ),
        ),
      );
  }

  @override
  void dispose() {
    _controller.startTimer;
    super.dispose();
  }
}
