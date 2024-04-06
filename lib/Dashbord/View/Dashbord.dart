import 'dart:ui';

import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:usermechanic/AppConstant/APIConstant.dart';
import 'package:usermechanic/Dashbord/Controller/dashbordcontroller.dart';
import 'package:usermechanic/Dashbord/View/Booking.dart';
import 'package:usermechanic/Dashbord/View/Help.dart';
import 'package:usermechanic/Dashbord/View/HomePage/HomePage.dart';
import 'package:usermechanic/Dashbord/View/Notification.dart';
import 'package:usermechanic/Dashbord/View/Profile/Profile.dart';
import 'package:usermechanic/Widget/coustom_Dailog.dart';
import 'package:usermechanic/Widget/styles.dart';
import 'package:usermechanic/auth/logincontroller.dart';
import 'package:usermechanic/mathod/AppConstant.dart';

import '../../Widget/TextStyle.dart';
import '../../utils/dimentions.dart';
class Dashbord extends StatefulWidget {
  const Dashbord({Key? key}) : super(key: key);

  @override
  State<Dashbord> createState() => _DashbordState();
}

class _DashbordState extends State<Dashbord> {
  HomePageController controller=Get.put(HomePageController());
  final LoginController loginController=Get.put(LoginController());
  int _currentIndex=0;
  DateTime? currentBackPressTime;
  List admin=[
    HomePage(),
    Booking(),
    Help(),
    Profile(),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loginController.getAddressFromLatLong();
    controller.postcurrentaddressNetworkApi();
    print(controller.address.value);
  }
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop:onWillPop,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.r),
          child: _currentIndex == 3? SizedBox():AppBar(
            toolbarHeight: 50.r,
            elevation: 0,
            backgroundColor: Color(0xff049486),
            title: Container(
              height: 50.h,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  InkWell(onTap: (){
                    setState(() {
                      _currentIndex=3;
                    });
                  },
                    child: Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white,width: 2.r)
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100.r),
                        child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          imageUrl:BASE_URL+GetStorage().read(AppConstant.profileImg).toString(),
                          height:40.r,
                          width: 40.r,
                          placeholder: (context, url) =>
                              Center(child: const CircularProgressIndicator()),
                          errorWidget: (context, url, error) =>
                          const Icon(Icons.person,color: Colors.white,),
                        ),
                      ),
                    ),
                  ),SizedBox(width:5.r,),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Icon(Icons.location_on_outlined,color: Colors.green,size: 25.sp,),
                      Container(
                        width: 180.r,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                                Text(GetStorage().read(AppConstant.userName).toString()??"",style:bodyboldStyle.copyWith(color:Colors.white
                                 ,height: 1.h,fontSize:15.r),overflow: TextOverflow.ellipsis,maxLines: 2,),
                            // Obx(()=> Container(
                            //   width: 200.r,
                            //   child: Column(
                            //     crossAxisAlignment: CrossAxisAlignment.start,
                            //     children: [
                            //       controller.address.value.toString()!=null?
                            //       Text(controller.address.value.toString(),style: smallTextStyle.copyWith(fontSize:10.sp,color:Colors.white),):Text("Loading......"),
                            //     ],
                            //   ),
                            // )),
                            Obx(() => Container(
                              width: 200.r,
                              child: Column(
                                children: [
                                  Text(
                                    loginController.current_address.value.toString().isNotEmpty?loginController.current_address.value.toString():"Wait loading...",
                                    style: robotoRegular.copyWith(
                                        fontSize: Dimensions.fontSizeExtraSmall, color: Colors.white),
                                  ),
                                ],
                              ),
                            )
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
           automaticallyImplyLeading: false,
            actions: [
              IconButton(onPressed: (){
                Get.to(()=>AllNotifications());
              }, icon: Icon(Icons.notification_add,color: Color(0xffffffff),size: 28.r,)),
              SizedBox(width: 10.w,),
              IconButton(onPressed: (){
               AlertLogout();
              }, icon:Icon(Icons.power_settings_new_outlined,size: 28.r,color: Colors.red,)),
              SizedBox(width: 10.w,),
            ],
          )  ,

        ),
        bottomNavigationBar: BottomNavyBar(
          selectedIndex: _currentIndex,
          showElevation: true,
          iconSize: 18.r,
          containerHeight: 40.r,
          itemCornerRadius: 24.r,
          animationDuration: Duration(microseconds: 100),
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          curve: Curves.easeIn,
          onItemSelected: (index) => setState(() => _currentIndex = index),
          items: <BottomNavyBarItem>[
            BottomNavyBarItem(
              icon: Icon(Icons.home,),
              title: Text('Home'),
              activeColor: Color(0xff049486),
              textAlign: TextAlign.center,
            ),
            BottomNavyBarItem(
              icon: Icon(Icons.book_online),
              title: Text('Booking'),
              activeColor: Color(0xff049486),
              textAlign: TextAlign.center,
            ),
            BottomNavyBarItem(
              icon: Icon(Icons.help),
              title: Text(
                'Help',
              ),
              activeColor: Color(0xff049486),
              textAlign: TextAlign.center,
            ),
            BottomNavyBarItem(
              icon: Icon(Icons.person),
              title: Text('Profile'),
              activeColor: Color(0xff049486),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        body: admin[_currentIndex],
      ),
    );
  }

  Future<bool> onWillPop()async{
    if (_currentIndex != 0) {

      Navigator.of(context).popUntil((route) => route.isFirst);
      setState(() {
        _currentIndex = 0;
        DateTime now = DateTime.now();
        if (currentBackPressTime == null || now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
          currentBackPressTime = now;
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Center(child: Text("Press again to exit",style: bodyboldStyle.copyWith(color: Colors.white),)),
                backgroundColor:Theme.of(context).appBarTheme.backgroundColor,
                elevation: 10, //shadow
                behavior: SnackBarBehavior.floating,
                margin: EdgeInsets.only(left: 60.w,right: 60.w),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.r),
                ),
              )
          );
        }
      });
      return false;
    } else {
      return true;
    }
    // DateTime now = DateTime.now();
    // if (currentBackPressTime == null || now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
    //   currentBackPressTime = now;
    //   ScaffoldMessenger.of(context).showSnackBar(
    //       SnackBar(
    //         content: Center(child: Text("Press again to exit",style: bodyboldStyle.copyWith(color: Colors.white),)),
    //         backgroundColor:Theme.of(context).appBarTheme.backgroundColor,
    //         elevation: 10, //shadow
    //         behavior: SnackBarBehavior.floating,
    //         margin: EdgeInsets.only(left: 60.w,right: 60.w),
    //         shape: RoundedRectangleBorder(
    //           borderRadius: BorderRadius.circular(50.r),
    //         ),
    //       )
    //   );
    //   return Future.value(false);
    // }
    // return Future.value(true);
  }

  void AlertLogout() {
      print("object");
      showAnimatedDialog1(
          context,
          Center(
              child: Container(
                width: 320.0.w,
                height: 250.0.h,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.r)
                ),
                padding:EdgeInsets.all(
                    20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Are You Sure !",style: bodyText1Style.copyWith(fontSize: 22.sp ,color: Colors.black,decoration: TextDecoration.none),),
                    SizedBox(height: 20.h,),
                    Text("if you want to logout please press Yes otherwise No",textAlign:TextAlign.center,style: smallTextStyle.copyWith( color: Colors.black,decoration: TextDecoration.none,fontSize: 18.sp)
                    ),
                    SizedBox(height: 50.h,),
                    Column(
                      children: [
                        Row(
                          children: [
                            // InkWell(
                            //   onTap: (){
                            //
                            //   },
                            //   child: Container(
                            //     height: 40.h,
                            //     width: 120.w,
                            //     decoration: BoxDecoration(
                            //       color: Colors.green,
                            //       border: Border.all(color: Colors.red,width: .5.w),
                            //       borderRadius: BorderRadius.circular(30.r),
                            //     ),
                            //     child: Center(child: Text("Cancel",style: bodybold2Style.copyWith(color: Colors.white,decoration: TextDecoration.none),)),
                            //   ),
                            // ),
                            MaterialButton(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
                                elevation: 5.0,
                                minWidth: 120.w,
                                height: 40.h,
                                color: Color(0xFF25A48B),
                                child:  Text('Cancel',
                                    style: new TextStyle(fontSize: 16.0, color: Colors.white)),
                                onPressed: () {
                                  Get.back();
                                }),
                            Spacer(),
                            MaterialButton(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
                                elevation: 5.0,
                                minWidth: 120.w,
                                height: 40.h,
                                color: Color(0xFFC90032),
                                child:  Text('Ok',
                                    style: new TextStyle(fontSize: 16.0, color: Colors.white)),
                                onPressed: () {
                                 controller.logout();
                                }),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              )

          ),
          dismissible: true);
    }

  }

showAlertDialog() {
  Container(
            width: 320.0.w,
            height: 250.0.h,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.r)
            ),
            padding:  EdgeInsets.all(
                20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Are You Sure !",style: bodyText1Style.copyWith(fontSize: 22.sp ,color: Colors.white,decoration: TextDecoration.none),),
                SizedBox(height: 20.h,),
                Text("if you want to logout please press Yes otherwise No",textAlign:TextAlign.center,style: smallTextStyle.copyWith( color: Colors.white,decoration: TextDecoration.none,fontSize: 18.sp)
                ),
                SizedBox(height: 50.h,),
                Row(
                  children: [
                    Container(
                      height: 40.h,
                      width: 120.w,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        border: Border.all(color: Colors.red,width: .5.w),
                        borderRadius: BorderRadius.circular(30.r),
                      ),
                      child: Center(child: Text("Cancel",style: bodybold2Style.copyWith(color: Colors.white,decoration: TextDecoration.none),)),
                    ),
                    Spacer(),
                    Container(
                      height: 40.h,
                      width: 120.w,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        border: Border.all(color: Colors.green,width: .5.w),
                        borderRadius: BorderRadius.circular(30.r),
                      ),
                      child: Center(child: Text("Ok",style: bodybold2Style.copyWith(color: Colors.white,decoration: TextDecoration.none),)),
                    ),
                  ],
                )
              ],
            ),
          );

}
