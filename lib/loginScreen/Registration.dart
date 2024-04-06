import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:usermechanic/Dashbord/Controller/dashbordcontroller.dart';
import 'package:usermechanic/Widget/EditTextWidget.dart';
import 'package:usermechanic/Widget/styles.dart';
import 'package:usermechanic/auth/logincontroller.dart';
import 'package:usermechanic/utils/CircularButton.dart';
class Registration extends StatefulWidget {
  const Registration({Key? key}) : super(key: key);

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final _formKey = GlobalKey<FormState>();
  late String deviceId;
  LoginController controller=Get.put(LoginController());
  HomePageController _controller=Get.put(HomePageController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.getAddressFromLatLong();
  }
  @override
  Widget build(BuildContext context) {
    controller.setData();
    return Scaffold(
    body: SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 20.h,),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(onPressed: (){
                Navigator.pop(context);
              }, icon: Icon(Icons.close, size: 28.sp,color: Colors.black,)),
              Padding(
                padding: const EdgeInsets.only(left: 58.0),
                child: Container(
                    height: 200.h,
                    width: Get.width/1.5,
                    child: Image(image: AssetImage("assets/images/login.gif"))),
              ),
            ],
          ),
         Padding(
           padding: const EdgeInsets.only(left: 18.0,right: 18),
           child: Row(
             mainAxisAlignment: MainAxisAlignment.end,
             children: [

             ],
           ),
         ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 18.0),
                child: Text( 'Create a account !',
                    style: smallTextStyle.copyWith(fontSize:18.sp ,color: Colors.black)
                ),
              ),
              Padding(
                  padding:  EdgeInsets.only(left:28.w,right: 28.w),
                  child: Form(
                    key: _formKey,
                      child: Column(
                          children: [
                            SizedBox(height: 25.h,),
                            EditTextWidget(
                              controller: controller.etName,
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
                              controller: controller.etEmail,
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

                            ),
                            SizedBox(height: 5.sp,),
                            EditTextWidget(
                              controller:controller.etMobile,
                              validator: (value){
                                if(value.toString().isEmpty)
                                {
                                  return "Please Enter Mobile";
                                }
                                return null;
                              },
                              type: TextInputType.number,
                              labelText: 'Mobile',
                              length: 10,
                              isRead: true,
                            ),
                            SizedBox(height: 5.sp,),
                            EditTextWidget(
                              controller:controller.etZipCode,
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
                            SizedBox(height: 5.sp,),
                            SizedBox(height: 5.h,),
                             Row(
                               mainAxisAlignment: MainAxisAlignment.end,
                               children: [
                                 CircularButton(
                                    onPress: () {
                                      if (_formKey.currentState!.validate()) {
                                        controller.signUpNetworkApi();
                                      }
                                    },
                                  ),
                               ],
                             ),
                          ]))
              )
            ],
          )
        ],
      ),
    )
    );
  }
}
