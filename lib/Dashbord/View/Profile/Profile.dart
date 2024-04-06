import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:usermechanic/AppConstant/APIConstant.dart';
import 'package:usermechanic/Dashbord/Controller/dashbordcontroller.dart';
import 'package:usermechanic/Dashbord/View/Dashbord.dart';
import 'package:usermechanic/Dashbord/View/Profile/ContactUs.dart';
import 'package:usermechanic/Dashbord/View/Profile/EditProfile.dart';
import 'package:usermechanic/Dashbord/View/Profile/ProfileHelp.dart';
import 'package:usermechanic/Dashbord/View/Profile/Transaction.dart';
import 'package:usermechanic/Dashbord/View/Profile/location.dart';
import 'package:usermechanic/Widget/coustom_Dailog.dart';
import 'package:usermechanic/Widget/styles.dart';
import 'package:usermechanic/auth/logincontroller.dart';
import 'package:usermechanic/mathod/AppConstant.dart';
class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);
  @override
  State<Profile> createState() => _ProfileState();
}
class _ProfileState extends State<Profile> {
  final HomePageController controller=Get.find();
   LoginController _controller=Get.put(LoginController());
  GetStorage _storage=GetStorage();
  @override
  void initState() {
    super.initState();
    controller.postcurrentaddressNetworkApi();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      body:SingleChildScrollView(
        child: FadeInUp(
          delay: Duration(microseconds: 450),
          child: Column(
            children: [
              Container(
                height: 200.h,
                child: Stack(
                  children: [
                    Container(
                      height: 180.h,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Color(0xff049486),
                      ),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 35),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 20.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: Column(
                                    children: [
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: 100.r,
                      left: 10.r,
                      child: Row(
                        children: [
                          InkWell(
                            onTap:(){
                              ProfileOpen();
                            },
                            child: Container(
                              height:100.r,
                              width: 100.r,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                  border: Border.all(width: 2.w,color: Colors.black),
                                  // image: DecorationImage(
                                  //     image: NetworkImage(BASE_URL+GetStorage().read(AppConstant.profileImg).toString()),fit: BoxFit.fill                                        )
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(50.r),
                                child: CachedNetworkImage(
                                  fit: BoxFit.cover,
                                  imageUrl: BASE_URL+GetStorage().read(AppConstant.profileImg).toString(),
                                  height:100.r,
                                  width: 100.r,
                                  placeholder: (context, url) =>
                                      Center(child: const CircularProgressIndicator()),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.person,color: Colors.grey,size: 80.sp,),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(GetStorage().read(AppConstant.userName),maxLines:3,style: bodybold2Style.copyWith(fontSize: 16.sp,color: Colors.white),),
                                Container(
                                    width: 230.w,
                                    child: Text(controller.etAddress.text.toString(),style: smallTextStyle.copyWith(color: Colors.white,fontSize:12.sp),))
                              ],
                            ),
                          ), ],
                      ),
                    ),
                  ],
                ),
              ),
             SizedBox(height: 20.h,),
             Padding(
               padding:  EdgeInsets.only(left: 25.w,right: 25.w,top: 40.h),
               child: Column(
                 children: [
                   InkWell(
                     onTap: (){
                       Navigator.push(
                         context,
                         MaterialPageRoute(builder: (context) => const Dashbord()),
                       );
                     },
                     child: Row(
                       children: [
                         Icon(Icons.home,color: Color(0xff049486),size: 23.r,),
                         SizedBox(width: 20.w,),
                         Text("Home",style: smallText1Style.copyWith(
                           fontWeight: FontWeight.w500,color: Color(0xff626262),
                           fontSize: 17.sp,
                         )),
                       ],
                     ),
                   ),
                   SizedBox(height: 5.h,),
                   Divider(),
                   SizedBox(height: 5.h,),
                   InkWell(
                     onTap: (){
                     Get.to(()=>EditProfile());
                     },
                     child: Row(
                       children: [
                         Icon(Icons.person,color: Color(0xff049486),size: 23.r,),
                         SizedBox(width: 20.w,),
                         Text("Profile",style: smallText1Style.copyWith(
                           color: Color(0xff626262),
                           fontSize: 17.sp,
                         )),
                       ],
                     ),
                   ),
                   SizedBox(height: 5.h,),
                   Divider(),
                   SizedBox(height: 5.h,),
                   InkWell(
                     onTap: (){
                      Get.to(()=>ProfileHelp());
                     },
                     child: Row(
                       children: [
                         Icon(Icons.help,color: Color(0xff049486),size: 23.r,),
                         SizedBox(width: 20.w,),
                         Text("Help",style: smallText1Style.copyWith(
                           color: Color(0xff626262),
                           fontSize: 17.sp,
                         )),
                       ],
                     ),
                   ),
                   SizedBox(height: 5.h,),
                   Divider(),
                   SizedBox(height: 5.h,),
                   InkWell(
                     onTap: (){
                       Get.to(()=>ContactUs());
                     },
                     child: Row(
                       crossAxisAlignment: CrossAxisAlignment.center,
                       children: [
                         Icon(Icons.contact_phone,color: Color(0xff049486),size: 23.r,),
                         SizedBox(width: 20.w,),
                         Text("Contact Us",style: smallText1Style.copyWith(
                           color: Color(0xff626262),
                           fontSize: 17.sp,
                         )),
                       ],
                     ),
                   ),
                   Divider(),
                   SizedBox(height: 5.h,),
                   InkWell(
                     onTap: (){
                       Get.to(()=>Transaction());
                     },
                     child: Row(
                       children: [
                         Container(height: 25.h,width: 25.w, child: Image.asset("assets/images/trans.png")),
                         SizedBox(width: 20.w,),
                         Text("Transaction History",style: smallText1Style.copyWith(
                           color: Color(0xff626262),
                           fontSize: 17.sp,
                         )),
                       ],
                     ),
                   ),
                   SizedBox(height: 5.h,),
                   Divider(),
                   InkWell(
                     onTap: (){

                     },
                     child: Row(
                       children: [
                         Container(height: 25.h,width: 25.w, child: Icon(Icons.share,size: 23.r,color: Colors.teal,)),
                         SizedBox(width: 20.w,),
                         Text("Share App",style: smallText1Style.copyWith(
                           color: Color(0xff626262),
                           fontSize: 17.sp,
                         )),
                       ],
                     ),
                   ),
                   // SizedBox(height: 5.h,),
                   // InkWell(
                   //   onTap: (){
                   //     Get.to(()=>LocationScreen());
                   //   },
                   //   child: Row(
                   //     children: [
                   //       Container(height: 25.h,width: 25.w, child: Image.asset("assets/images/trans.png")),
                   //       SizedBox(width: 20.w,),
                   //       Text("lovwegdtyed",style: smallText1Style.copyWith(
                   //         color: Color(0xff626262),
                   //         fontSize: 17.sp,
                   //       )),
                   //     ],
                   //   ),
                   // ),
                   SizedBox(height: 5.h,),
                   Divider(),
                   SizedBox(height: 50.h,),
                   InkWell(
                     onTap: (){
                       AlertLogout();
                     },
                     child: Row(
                       children: [
                         Icon(Icons.logout,color: Colors.redAccent,size: 23.r,),
                         SizedBox(width: 20.w,),
                         Text("Log Out",style: smallText1Style.copyWith(
                           color: Color(0xff626262),
                           fontSize: 17.sp,
                         )),
                       ],
                     ),
                   ),
                   SizedBox(height: 5.h,),
                   Divider(color: Colors.red,),
                   SizedBox(height: 5.h,),
                 ],
               ),
             ),

            ],
          ),
        ),
      )
      // Column(
      //   crossAxisAlignment: CrossAxisAlignment.center,
      //   children: [
      //     Center(
      //       child: Container(
      //         height: 70.h,
      //         width: 100.w,
      //         decoration: BoxDecoration(
      //           color: Colors.blue,
      //           shape: BoxShape.circle,
      //           border: Border.all(width: 2.w),
      //           image: DecorationImage(
      //             image: NetworkImage(BASE_URL+GetStorage().read(AppConstant.profileImg).toString()),fit: BoxFit.fill
      //           )
      //         ),
      //       ),
      //     ),
      //     SizedBox(height: 20.h,),
      //     Card(
      //       shape: RoundedRectangleBorder(
      //         borderRadius: BorderRadius.circular(20.r)
      //       ),
      //       child: Container(
      //         padding: EdgeInsets.all(15),
      //         width: Get.width,
      //         decoration: BoxDecoration(
      //           borderRadius: BorderRadius.circular(10.r),
      //           border: Border.all(color: Color(0xff049486))
      //         ),
      //         child: Column(
      //           crossAxisAlignment: CrossAxisAlignment.center,
      //           children: [
      //             Row(
      //               children: [
      //                 Text("Name :-   ",style: smallTextStyle.copyWith(fontSize: 16.sp),),
      //                 Column(
      //                   children: [
      //                     Text(GetStorage().read(AppConstant.userName),maxLines:3,style: smallTextStyle.copyWith(fontSize: 16.sp),),
      //                   ],
      //                 )
      //               ],
      //             ),
      //             SizedBox(height: 15.h,),
      //             Row(
      //               children: [
      //                 Text("Email :-   ",style: smallTextStyle.copyWith(fontSize: 16.sp),),
      //                 Column(
      //                   children: [
      //                     Text(GetStorage().read(AppConstant.email),style: smallTextStyle.copyWith(fontSize: 16.sp),),
      //                   ],
      //                 )
      //               ],
      //             ),
      //             SizedBox(height: 15.h,),
      //             Row(
      //               children: [
      //                 Text("Mobile Number :-   ",style: smallTextStyle.copyWith(fontSize: 16.sp),),
      //                 Column(
      //                   children: [
      //                     Text(GetStorage().read(AppConstant.mobile),maxLines:3,style: smallTextStyle.copyWith(fontSize: 16.sp),),
      //                   ],
      //                 )
      //               ],
      //             ),
      //             SizedBox(height: 15.h,),
      //             Row(
      //               children: [
      //                 Text("Id Prove Number :-   ",style: smallTextStyle.copyWith(fontSize: 16.sp),),
      //                 Column(
      //                   children: [
      //                     Text(GetStorage().read(AppConstant.aadhar),maxLines:3,style: smallTextStyle.copyWith(fontSize: 16.sp),),
      //                   ],
      //                 )
      //               ],
      //             ),
      //             SizedBox(height: 15.h,),
      //             Row(
      //               children: [
      //                 Text("Address :-   ",style: smallTextStyle.copyWith(fontSize: 16.sp),),
      //                 Column(
      //                   children: [
      //                     Text(GetStorage().read(AppConstant.address),maxLines:3,style: smallTextStyle.copyWith(fontSize: 16.sp),),
      //                   ],
      //                 )
      //               ],
      //             ),
      //             SizedBox(height: 15.h,),
      //           ],
      //         ),
      //       ),
      //     ),
      //     SizedBox(
      //       height: 10.h,
      //     ),
      //     Padding(
      //       padding: const EdgeInsets.all(8.0),
      //       child: InkWell(
      //         onTap: (){
      //           Get.to(()=>EditProfile());
      //         },
      //         child: Container(
      //           padding: EdgeInsets.all(10.w),
      //           width: Get.width,
      //           decoration: BoxDecoration(
      //             border: Border.all(color: Color(0xff049486)),
      //             borderRadius: BorderRadius.circular(10.r)
      //           ),
      //           child: Row(
      //             children: [
      //               Icon(Icons.person,color: Color(0xff049486),),
      //               SizedBox(width: 20.w,),
      //               Text("Edit Profile",style: bodyboldStyle.copyWith(fontSize: 17.sp),)
      //             ],
      //           ),
      //         ),
      //       ),
      //     ),
      //     SizedBox(
      //       height: 20.h,
      //     ),
      //     Padding(
      //       padding: const EdgeInsets.all(8.0),
      //       child: InkWell(
      //         onTap: (){
      //          // controller.logout();
      //           Get.to(()=>OnboardingScreen());
      //         },
      //         child: Container(
      //           padding: EdgeInsets.all(10.w),
      //           width: Get.width,
      //           decoration: BoxDecoration(
      //             borderRadius: BorderRadius.circular(10.r),
      //             border: Border.all(color: Color(0xff049486))
      //           ),
      //           child: Row(
      //             children: [
      //               Icon(Icons.login_outlined,color: Color(0xff049486),),
      //               SizedBox(width: 20.w,),
      //               Text("Log Out",style: bodyboldStyle.copyWith(fontSize: 17.sp),)
      //             ],
      //           ),
      //         ),
      //       ),
      //     )
      //   ],
      // )
    );
  }
  // void showAlertBox()
  // {
  //
  //   print("object");
  //   Get.defaultDialog(
  //       backgroundColor:Colors.white,
  //       title: 'Are you sure !',
  //       titleStyle: bodyText1Style.copyWith(fontSize: 22.sp ,color: Colors.black,),
  //       middleText: 'if you want to logout please press Yes otherwise No',middleTextStyle: smallTextStyle.copyWith( color: Colors.black,),
  //       radius:5,
  //       textCancel: 'No',
  //       contentPadding: EdgeInsets.all(20.w),
  //       titlePadding: EdgeInsets.all(20.w),
  //       cancelTextColor: Colors.black,
  //       textConfirm: 'Yes',
  //       onCancel: (){},
  //       onConfirm: ()
  //       {
  //         print("dhug7ttd");
  //         controller.logout();
  //       }
  //   );
  // }
  void AlertLogout() {
    print("object");
    showAnimatedDialog1(
        context,
        Center(
            child: Container(
              width: 320.r,
              height: 300.r,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.r)
              ),
              padding:EdgeInsets.all(
                  20.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Are You Sure !",style: bodyText1Style.copyWith(fontSize: 22.r ,color: Colors.black,decoration: TextDecoration.none),),
                  SizedBox(height: 20.r,),
                  Text("if you want to logout please press Yes otherwise No",textAlign:TextAlign.center,style: smallTextStyle.copyWith( color: Colors.black,decoration: TextDecoration.none,fontSize: 18.r)
                  ),
                  SizedBox(height: 50.r,),
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
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.r))),
                              elevation: 5.0,
                              minWidth: 120.r,
                              height: 40.r,
                              color: Color(0xFF25A48B),
                              child:  Text('Cancel',
                                  style: new TextStyle(fontSize: 16.r, color: Colors.white)),
                              onPressed: () {
                                Get.back();
                              }),
                          Spacer(),
                          MaterialButton(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.r))),
                              elevation: 5.0,
                              minWidth: 120.r,
                              height: 40.r,
                              color: Color(0xFFC90032),
                              child:  Text('Ok',
                                  style: new TextStyle(fontSize: 16.r, color: Colors.white)),
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

  void ProfileOpen() {
    print("object");
    controller.postcurrentaddressNetworkApi();
    showAnimatedDialog1(
        context,
        Center(
            child: Container(
              width: Get.width,
              height: 420.0.h,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.r)
              ),
              // padding:EdgeInsets.all(
              //     5.w),
              child:Image.network(BASE_URL+GetStorage().read(AppConstant.profileImg).toString(),fit: BoxFit.fill,),
            )

        ),
        dismissible: true);
  }
}
