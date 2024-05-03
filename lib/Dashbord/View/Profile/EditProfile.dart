import 'dart:io';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:usermechanic/AppConstant/APIConstant.dart';
import 'package:usermechanic/Dashbord/Controller/dashbordcontroller.dart';
import 'package:usermechanic/Widget/CoustomButton.dart';
import 'package:usermechanic/Widget/EditTextWidget.dart';
import 'package:usermechanic/Widget/styles.dart';
import 'package:usermechanic/auth/logincontroller.dart';
import 'package:usermechanic/mathod/AppConstant.dart';
class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}
class _EditProfileState extends State<EditProfile> {
  final formKey = GlobalKey<FormState>();
  HomePageController controller =Get.find();
  final LoginController _controller=Get.put(LoginController());
  String gender = "male";
  RxInt male = 0.obs;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.setEtDataController();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.white
        ),
        backgroundColor: Color(0xff049486),
        title:Text("Edit Profile",style:bodyboldStyle.copyWith(color: Colors.white),),
        actions: [
          // TextButton(onPressed: (){
          // if (formKey.currentState!.validate()) {
          //     _controller.UpdateNetworkApi();
          //   }
          // }, child: Text("Save",style: bodyboldStyle.copyWith(color: Colors.black),))
        ],
      ),
      body: SingleChildScrollView(
        child: FadeInUp(
          delay: Duration(microseconds: 450),
          child: Column(
            children: [
          Column(
            children: [
              SizedBox(height: 10.h,),
              Container(
                height: 100.h,
                width: 100.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage("assets/images/profile2.png"),fit: BoxFit.cover
                  ),
                  border: Border.all(color: Color(0xff049486)),
                ),
                child: Stack(
                  children: [
                    Obx(() =>_controller.rxPath.value.isEmpty
                        ?
                    Container(
                      decoration:  BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Color(0xff049486)),
                        image:  DecorationImage(
                            image: NetworkImage(BASE_URL+GetStorage().read(AppConstant.profileImg).toString()),fit: BoxFit.fill
                        ),
                      ),
                      child: Container(

                      ),
                    ): Container(
                      decoration:  BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Color(0xff049486)),
                        image:  DecorationImage(
                        image: FileImage(File(_controller.rxPath.value)),fit: BoxFit.fill
                        ),
                      ),
                    ),
                    ),
                    Positioned(
                      bottom: 5.h,
                      right: 0.w,
                      child: InkWell(onTap: (){
                        showOptionDailog(context);
                      },child: Container(
                          height:30.h,
                          width: 30.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(width: 2.w,color: Color(0xff049486)),
                            color: Colors.white,
                          ),
                          child:Icon(Icons.image,size:18.sp,color: Color(0xff049486),)
                      ),),),

                  ],
                ),
              ),
              Padding(
                  padding:  EdgeInsets.only(left:38.w,right: 38.w),
                  child: Form(
                      key: formKey,
                      child: Column(
                          children: [
                            SizedBox(height: 25.h,),
                            EditTextWidget(
                              controller: _controller.etName,
                              validator: (value){
                                if(value.toString().isEmpty)
                                {
                                  return "Please Enter Name";
                                }
                                return null;
                              }, labelText: "Name",

                            ),
                            SizedBox(height: 5.sp,),
                            EditTextWidget(
                              controller: _controller.etEmail,
                              validator: (value){
                                if(value.toString().isEmpty)
                                {
                                  return "Please Enter Email";
                                }
                                if(!GetUtils.isEmail(value))
                                {
                                  return "Please Enter Valid Email";
                                }
                                return null;
                              },
                              type: TextInputType.emailAddress,
                              labelText: 'Email',
                              isRead: true,
                            ),
                            SizedBox(height: 5.sp,),
                            EditTextWidget(
                              controller: _controller.etMobile,
                              validator: (value){
                                if(value.toString().isEmpty)
                                {
                                  return "Please Enter Mobile";
                                }
                                return null;
                              },
                              type: TextInputType.number,
                              labelText: 'Mobile',
                              isRead: false,
                              length: 10,

                            ),
                            SizedBox(height: 5.sp,),
                            EditTextWidget(
                              controller: _controller.etZipCode,
                              validator: (value){
                                if(value.toString().isEmpty)
                                {
                                  return "Please Enter Zip Code";
                                }
                                return null;
                              },
                              type: TextInputType.number,
                              labelText: 'Zip Code',
                              length: 6,

                            ),
                            SizedBox(height: 27.h,),
                            Button2(onPress: () {
                              if (formKey.currentState!.validate()) {
                                _controller.UpdateNetworkApi();
                              }
                            }, text: 'Update',),
                            SizedBox(height: 20.h,)
                            // InkWell(onTap: (){
                            //   if (formKey.currentState!.validate()) {
                            //       _controller.UpdateNetworkApi();
                            //     }
                            // },
                            //   child: Row(
                            //     mainAxisAlignment: MainAxisAlignment.center,
                            //     children: [
                            //      Container(
                            //        height: 45.h,
                            //        width: Get.width/1.5,
                            //        decoration: BoxDecoration(
                            //          color: Color(0xff5dbcc2),
                            //          border: Border.all(),
                            //          borderRadius: BorderRadius.circular(30.r)
                            //        ),
                            //        child: Center(child: Text("Update",style: bodyboldStyle.copyWith(color: Colors.white,fontSize: 17.sp),)),
                            //
                            //      )
                            //     ],
                            //   ),
                            // ),
                          ]))
              )
            ],
          ),
      ]
    ),
        )
    )
    );
  }
  showOptionDailog(BuildContext context) {
    return showDialog(context: context, builder: (context) =>
        SimpleDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(4.0))),
          backgroundColor:Colors.white
              .withOpacity(0.9),
          children: [
            SimpleDialogOption(
              onPressed: () {
                _controller.chooseImage(false);
                Get.back();
              },
              child: Row(
                children: [
                  Icon(Icons.image,color: Color(0xff049486),),
                  Text("   Gallery", style:smallTextStyle)
                ],
              ),
            ),
            SimpleDialogOption(
              onPressed: () {
                _controller.chooseImage(true);
              Get.back();
              },
              child: Row(
                children: [
                  Icon(Icons.camera_alt,color: Color(0xff049486),),
                  Text("   Camera", style:smallTextStyle)
                ],
              ),
            ),
            SimpleDialogOption(
              onPressed: () => Get.back(),
              child: Row(
                children: [
                  Icon(Icons.clear,color: Colors.red,),
                  Text("  Cancel", style: smallTextStyle)
                ],
              ),
            ),
          ],
        ));
  }

}
