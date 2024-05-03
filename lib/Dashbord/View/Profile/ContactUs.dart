// ignore_for_file: deprecated_member_use

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:usermechanic/Dashbord/Controller/dashbordcontroller.dart';
import 'package:usermechanic/Widget/styles.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({Key? key}) : super(key: key);

  @override
  State<ContactUs> createState() => _ContactUsState();
}
  class _ContactUsState extends State<ContactUs> {
   HomePageController controller=Get.put(HomePageController());
   _instagramURLApp() async {
     const url ="https://www.instagram.com/er.uday_chaurasiya143/";
     if (await canLaunch(url)) {
       await launch(url, forceSafariVC: true, forceWebView: false);
     } else {
       throw 'Could not launch $url';
     }
   }
   _websiteLink() async {
     final url =controller.contactUs.value.data!.websiteLink.toString();
     if (await canLaunch(url)) {
       await launch(url, forceSafariVC: true, forceWebView: false);
     } else {
       throw 'Could not launch $url';
     }
   }
   _launchCaller() async {
     final url = "tel:"+controller.contactUs.value.data!.mobile.toString();
     if (await canLaunch(url)) {
       await launch(url);
     } else {
       throw 'Could not launch $url';
     }
   }
   _luncherMail() async {
     final url = "mailto:"+controller.contactUs.value.data!.email.toString();
     if (await canLaunch(url)) {
       await launch(url);
     } else {
       throw 'Could not launch $url';
     }
   }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.getContactUsNetworkApi();
  }
  Widget build(BuildContext context) {

    return Scaffold(
      body: SingleChildScrollView(
        child: Obx(()=>controller.contactUs.value.data!=
            null?
         Column(
            children: [
              Container(
                color: Color(0xff049486),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 30.h,),
                      Row(
                        children: [
                          IconButton(onPressed: (){
                            Get.back();
                          }, icon: Image.asset("assets/images/back.png",color: Colors.white,height: 25.h,width: 25.w,)),
                          SizedBox(width: 10.w,),
                          Center(child: Text("Contact Us",style: bodybold3Style.copyWith(fontSize: 25.sp,color:Colors.white),)),
                        ],
                      ),
                     Padding(
                       padding:  EdgeInsets.all(18.w),
                       child: Column(
                         children: [
                           Column(
                             crossAxisAlignment: CrossAxisAlignment.center,
                             mainAxisAlignment: MainAxisAlignment.center,
                             children: [
                               Container(
                                 height: 120.r,
                                 width: 120.r,
                                 child: Image.asset("assets/images/log.png"),
                               ),
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
                                         color:  const Color(0xff051ba6),
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
                           ListTileTheme(
                           contentPadding: const EdgeInsets.all(0),
                           dense: true,
                             child: ListTile(
                               onTap: _launchCaller,
                               leading: Icon(Icons.phone_forwarded_outlined,color: Colors.white,size: 20.r,),
                               title: Text(controller.contactUs.value.data!.mobile.toString(),style:smallTextStyle.copyWith(color: Colors.white),),
                             ),
                           ),
                           ListTileTheme(
                             contentPadding: const EdgeInsets.all(0),
                             dense: true,
                             child: ListTile(
                               onTap:  _luncherMail,
                               leading: Icon(Icons.email_outlined,color: Colors.white,size: 20.r,),
                               title: Text(controller.contactUs.value.data!.email.toString(),style:smallTextStyle.copyWith(color: Colors.white),),
                             ),
                           ),
                           ListTileTheme(
                             contentPadding: const EdgeInsets.all(0),
                             dense: true,
                             child: ListTile(
                               leading: Icon(Icons.location_on,color: Colors.white,size: 20.r,),
                               title: Text(controller.contactUs.value.data!.address.toString(),style:smallTextStyle.copyWith(color: Colors.white),),
                             ),
                           ),
                           SizedBox(height: 50.h,),
                           Row(
                             crossAxisAlignment: CrossAxisAlignment.center,
                             mainAxisAlignment: MainAxisAlignment.center,
                             children: [
                               Container(
                                   height:50.r,
                                   width: 50.r,
                                   child: IconButton(onPressed: _instagramURLApp, icon: Image.asset("assets/images/T.png",height: 50.r,width: 50.r,fit:BoxFit.fill,))),
                               Container(
                                   height:50.r,
                                   width: 50.r,
                                   child: IconButton(onPressed: _instagramURLApp, icon: Image.asset("assets/images/I.png",height: 50.r,width: 50.r,fit:BoxFit.fill))),
                               Container(
                                   height:50.r,
                                   width: 50.r,
                                   child: IconButton(onPressed: _instagramURLApp, icon: Image.asset("assets/images/F.png",height: 50.r,width: 50.r,fit:BoxFit.fill))),
                             ],
                           ),
                           SizedBox(height: 30.h,),
                           Row(
                             crossAxisAlignment: CrossAxisAlignment.center,
                             mainAxisAlignment: MainAxisAlignment.center,
                             children: [
                               Text("WebSite:-",style:smallTextStyle.copyWith(color: Colors.black,fontSize: 17.sp,),textAlign: TextAlign.center,),
                               InkWell(onTap:_websiteLink,child: Text(controller.contactUs.value.data!.websiteLink.toString(),style: TextStyle(color: Colors.white,fontSize:17.sp,decoration: TextDecoration.underline),))
                             ],
                           )
                           // ListTileTheme(
                           //   contentPadding: const EdgeInsets.all(0),
                           //   dense: true,
                           //   child: ListTile(
                           //       leading: Text("WebSite:-",style:smallTextStyle.copyWith(color: Colors.black,fontSize: 17.sp),),
                           //       title:InkWell(onTap:_websiteLink,child: Text(controller.contactUs.value.data!.websiteLink.toString(),style: TextStyle(color: Colors.white,fontSize:17.sp,decoration: TextDecoration.underline),))
                           //
                           //   ),
                           // ),
                         ],
                       ),
                     )
                    ],
                  )),

                  SizedBox(height: 2.h,),
                  Container(
                    color: Color(0xff049486),
                    height: 5.h,
                  ),
              SizedBox(height: 40.h,)

            ],
          ):Container()
        ),
      )
    );
  }
}
