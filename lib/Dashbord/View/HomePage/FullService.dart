// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:html/parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:readmore/readmore.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:usermechanic/Dashbord/Controller/dashbordcontroller.dart';
import 'package:usermechanic/Widget/CoustomButton.dart';
import 'package:usermechanic/Widget/EditTextWidget.dart';
import 'package:usermechanic/Widget/TextStyle.dart';
import 'package:usermechanic/Widget/styles.dart';
import 'package:usermechanic/auth/logincontroller.dart';
import 'package:usermechanic/mathod/AppConstant.dart';
import 'package:usermechanic/utils/custom_snackbar.dart';

import '../../Model/CategryModel.dart';
class FullService extends StatefulWidget {

  const FullService( {Key? key}) : super(key: key);

  @override
  State<FullService> createState() => _FullServiceState();
}

class _FullServiceState extends State<FullService> {
  HomePageController controller=Get.put(HomePageController());
  final LoginController loginController=Get.put(LoginController());
  GoogleMapController? mapController;
  LatLng? selectedLocation;
  Datum2  data=Datum2();
  final formKey3 = GlobalKey<FormState>();
  final picker = ImagePicker();
  File? uploadPhoto;
  File? uploadPhoto2;

  Future uploadPhoto1(context, ImageSource source) async {
    final pickedFile = await picker.getImage(source: source);
    if (pickedFile != null) {
      setState(() {
        uploadPhoto = File(pickedFile.path);
        print(uploadPhoto!.path);
      });
    }
  }

  Future uploadPhoto3(context, ImageSource source) async {
    final pickedFile = await picker.getImage(source: source);
    if (pickedFile != null) {
      setState(() {
        uploadPhoto2 = File(pickedFile.path);
        print(uploadPhoto2!.path);
      });
    }
  }
  var _selectedItem;
  var _selectedItem1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.setData();
    data=controller.Categry;
    controller.getCategryNetworkApi();
    controller.postcurrentaddressNetworkApi();
    // controller.getBookingNetworkApi();
    controller.getServiceBrandType();
    _selectedItem!=null;
  }

  @override
  Widget build(BuildContext context) {
    controller.etAddress.text = loginController.current_address.value.toString();
    print(controller.etAddress.text+"sidhfuvg");
    DateTime currentDate = DateTime.now();
    DateTime oneMonthLater = currentDate.add(Duration(days: 30));
    final document = parse(data.description);
      final String parsedString = parse(document.body?.text).documentElement!.text;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: const Color(0xff049486),
        leadingWidth: 20.w,
        title: const Text("Booking Service"),
      ),
      body: SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:  EdgeInsets.only(left:28.w,right: 28.w,top: 20.h),
                  child: Text("${data.title}",style: TextStyle(color: const Color(0xff105648),fontWeight: FontWeight.bold,fontSize: 20.sp),),
                ),
                Padding(
                  padding:  EdgeInsets.only(left:28.w,right: 28.w,top: 20.h),
                  child:Html(data:data.description.toString())
                  /*Container(
                    height: 100.h,
                    child: Scrollbar(
                      thickness: 15,
                      radius:Radius.circular(10.r),
                      // thumbVisibility: true,
                      // trackVisibility: true,
                      isAlwaysShown: true,
                      // showTrackOnHover: true,
                      child: SingleChildScrollView(
                        child: Html(data: data.description,),
                      ),
                    ),
                  ),*/
                ),
                SizedBox(height: 20.h,),
                Padding(
                    padding:  EdgeInsets.only(left:28.w,right: 28.w),
                    child: Form(
                      key: formKey3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Obx(() => IgnorePointer(
                            ignoring: true,
                            child: DropdownButtonFormField(
                              isExpanded: true,
                              alignment: Alignment.center,
                              value:controller.idServiceType.value,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 20.r),
                                labelText: "Select Service Type",
                                labelStyle: robotoRegular.copyWith(
                                    color:  Color(0xff049486)),
                                enabledBorder:  OutlineInputBorder(
                                  borderSide: BorderSide(width:.5,color: Color(0xffc2bfbf)),
                                ),
                                focusedBorder:  OutlineInputBorder(
                                  borderSide: BorderSide(width:.5,color: Color(0xffc2bfbf)),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(width:.5,color: Color(0xffc2bfbf)),
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(width:.5,color: Color(0xffc2bfbf)),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(width:.5,color: Color(0xffc2bfbf)),
                                ),
                              ),
                              items: [
                                DropdownMenuItem(
                                  value: 0,
                                  child: Text(
                                    "${data.title} ",
                                    style: smallTextStyle.copyWith(
                                        color: Colors.black),
                                  ),
                                ),
                                DropdownMenuItem(
                                  value: 1,
                                  child: Text(
                                    "${data.title} ",
                                    style: smallTextStyle.copyWith(
                                        color: Colors.black),
                                  ),
                                ),
                              ],
                              onChanged: (value) {
                                controller.idServiceType.value = int.parse(value.toString());
                              },
                            ),
                          ),
                          ),
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
                          SizedBox(height: 8.h,),
                          EditTextWidget(
                            controller: controller.etMobile,
                            validator: (value){
                              if (value.toString().isEmpty) {
                                return "Please enter mobile no.";
                              }
                              if (value!.length < 10) {
                                showCustomSnackBar('Please enter 10 digit number', isError: true);
                                return 'Please enter 10 digit number';
                              }
                              return null;
                            },
                            type: TextInputType.number,
                            labelText: 'Mobile',
                            length: 10,

                          ),
                          SizedBox(height: 8.h,),
                          EditTextWidget(
                            controller: controller.etBikeCC,
                            validator: (value){
                              if(value.toString().isEmpty)
                              {
                                return "Please Enter Bike CC";
                              }
                              return null;
                            },
                            type: TextInputType.number,
                            labelText: 'Bike CC',
                            length: 3,

                          ),
                          SizedBox(height: 10.h,),
                          /*Obx(() =>
                          DropdownButtonFormField(
                            isExpanded: true,
                            alignment: Alignment.center,
                             value: controller.idProveType.value,
                            decoration: InputDecoration(
                               labelText: "Select Slot Type",
                              contentPadding:EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                              labelStyle: robotoRegular.copyWith(
                                   color: Color(0xff049486)),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(width:.5,color: Color(0xffc2bfbf)),
                              ),
                              focusedBorder:OutlineInputBorder(
                                borderSide: BorderSide(width:.5,color: Color(0xffc2bfbf)),
                              ),
                              errorBorder:OutlineInputBorder(
                                borderSide: BorderSide(width:.5,color: Color(0xffc2bfbf)),
                              ),
                              border:OutlineInputBorder(
                                borderSide: BorderSide(width:.5,color: Color(0xffc2bfbf)),
                              ),
                              focusedErrorBorder:OutlineInputBorder(
                                borderSide: BorderSide(width:.5,color: Color(0xffc2bfbf)),
                              ),
                            ),
                            items:
                            [
                              DropdownMenuItem(
                                value: 0,
                                child: Text(
                                  'Select Service Type',
                                  style: robotoRegular.copyWith(
                                      color: Color(0xffc2bfbf)),
                                ),
                              ),
                              DropdownMenuItem(
                                value: 1,
                                child: Text(
                                  'Full Service',
                                  style: smallTextStyle.copyWith(
                                      color: Colors.black),
                                ),
                              ),
                              DropdownMenuItem(
                                value: 2,
                                child: Text(
                                  'Half Service',
                                  style: smallTextStyle.copyWith(
                                      color: Colors.black),
                                ),
                              ),
                              DropdownMenuItem(
                                value: 3,
                                child: Text(
                                  'Wash',
                                  style: smallTextStyle.copyWith(
                                      color: Colors.black),
                                ),
                              ),

                            ],
                            onChanged: (value) {
                             controller.idProveType.value=value!;
                             // print(controller.idProveType.value);
                            },
                            validator: (value) {
                              if (controller.idProveType.value == 0) {
                                return "Please select your card";
                              }
                              return null;
                            },
                          )
                          ),*/
                          Obx(()=>controller.brandModel.value.data.isNotEmpty ?
                          DropdownButtonFormField<dynamic>(
                            decoration: InputDecoration(
                              labelText: "Select Brand Type",
                              contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 20.r),
                              labelStyle: robotoRegular.copyWith(
                                  color:  Color(0xff049486)),
                              enabledBorder:  OutlineInputBorder(
                                borderSide: BorderSide(width:.5,color: Color(0xffc2bfbf)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(width:.5,color: Color(0xffc2bfbf)),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(width:.5,color: Color(0xffc2bfbf)),
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(width:.5,color: Color(0xffc2bfbf)),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(width:.5,color: Color(0xffc2bfbf)),
                              ),
                            ),
                            value:_selectedItem,
                            onChanged: (value) {
                              setState(() {
                                _selectedItem = value;
                              });
                              controller.idProveType2.value=_selectedItem;
                              print("fygdjgjdfghhjdfg${controller.idProveType2.value}");
                            },
                            validator: (value) {
                              if (controller.idProveType2.value == 0) {
                                return "Please select Brand Type";
                              }
                              return null;
                            },
                            items: controller.brandModel.value.data.map((dynamic item) {
                              return DropdownMenuItem<dynamic>(
                                value: item.id.toString(),
                                child: Text(item.title.toString()),
                              );

                            }).toList(),
                          ):Container()
                          ),
                          SizedBox(height: 20.h,),
                          Obx(() => DropdownButtonFormField(
                            isExpanded: true,
                            alignment: Alignment.center,
                            value: controller.idslotType.value,
                            decoration: InputDecoration(
                              // hintText: 'Select an option',
                              // label:  Text('Select an option'),
                              contentPadding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.r),
                              labelText: "Select Slot Type",
                              labelStyle: robotoRegular.copyWith(
                                  color:  Color(0xff049486)),
                              enabledBorder:  OutlineInputBorder(
                                borderSide: BorderSide(width:.5,color: Color(0xffc2bfbf)),
                              ),
                              focusedBorder:  OutlineInputBorder(
                                borderSide: BorderSide(width:.5,color: Color(0xffc2bfbf)),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(width:.5,color: Color(0xffc2bfbf)),
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(width:.5,color: Color(0xffc2bfbf)),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(width:.5,color: Color(0xffc2bfbf)),
                              ),
                            ),
                            items: [
                              DropdownMenuItem(
                                value: 0,
                                child: Text(
                                  'Select Slot Type',
                                  style: robotoRegular.copyWith(
                                      color:  Color(0xffc2bfbf)),
                                ),
                              ),
                              DropdownMenuItem(
                                value: 1,
                                child: Text(
                                  '1',
                                  style: smallTextStyle.copyWith(
                                      color: Colors.black),
                                ),
                              ),
                              DropdownMenuItem(
                                value: 2,
                                child: Text(
                                  '2',
                                  style: smallTextStyle.copyWith(
                                      color: Colors.black),
                                ),
                              ),
                              DropdownMenuItem(
                                value: 3,
                                child: Text(
                                  '3',
                                  style: smallTextStyle.copyWith(
                                      color: Colors.black),
                                ),
                              ),
                              DropdownMenuItem(
                                value: 4,
                                child: Text('3',
                                  style: smallTextStyle.copyWith(
                                      color: Colors.black),
                                ),
                              ),
                            ],
                            onChanged: (value) {
                              controller.idslotType.value = value as int;
                              // print(controller.idProveType.value);
                            },
                            validator: (value) {
                              if (controller.idslotType.value == 0) {
                                return "Please select your Slot";
                              }
                              return null;
                            },
                          ),
                          ),
                          SizedBox(height: 18.h,),
                          TextFormField(
                              controller: controller.etDate,
                              validator: (value){
                                if(value.toString().isEmpty)
                                {
                                  return "Please Enter Date";
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                prefixIconConstraints:
                                 BoxConstraints(
                                  minWidth: 20,
                                ),
                                contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15.r),
                                enabledBorder:  OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width:.5,color: Color(0xffc2bfbf)),
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(width:.5,color: Color(0xffc2bfbf)),
                                ),
                                focusedBorder:  OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width:.5,color: Color(0xffc2bfbf)),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(width:.5,color: Color(0xffc2bfbf)),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(width:.5,color: Color(0xffc2bfbf)),
                                ),
                                labelText: "Service Date",
                                labelStyle: robotoRegular.copyWith(
                                  color:  Color(0xff049486),),
                                isDense: true,
                                counter:  Offstage(),
                              ),
                              readOnly: true,
                              onTap: () async {
                                final Datet =
                                await showDatePicker(
                                    context: context,
                                    builder:
                                        (context, child) {
                                          return Theme(
                                           data:
                                           Theme.of(context)
                                            .copyWith(
                                          colorScheme:
                                           ColorScheme
                                              .light(
                                            primary:
                                            Colors.white,
                                            onPrimary: Colors
                                                .redAccent,
                                            // <-- SEE HERE
                                            onSurface: Colors
                                                .black, // <-- SEE HERE
                                          ),
                                          textButtonTheme:
                                          TextButtonThemeData(
                                            style: TextButton
                                                .styleFrom(
                                              primary: Colors
                                                  .red, // button text color
                                            ),
                                          ),
                                        ),
                                        child: child!,
                                      );
                                    },
                                    initialDate:DateTime.now(),
                                    firstDate:DateTime.now(),
                                    lastDate: DateTime.now().add(Duration(days: 30)),
                                );
                                if (Datet != null) {
                                  String formattedDate =
                                  DateFormat('yyyy/MM/dd')
                                      .format(Datet);
                                  controller.etDate.text = formattedDate;
                                }

                              },
                              keyboardType: TextInputType.text,
                              style: smallTextStyle),
                          SizedBox(height: 18.h,),
                          EditTextWidget(
                            controller: controller.etAddress,
                            // validator: (value){
                            //   if(value.toString().isEmpty)
                            //   {
                            //     return "Please Enter Bike CC";
                            //   }
                            //   return null;
                            // },
                            type: TextInputType.text,
                            labelText: 'Booking Address',

                          ),
                          SizedBox(height: 20.h,),
                          const Text("Uplode Document :-",style: TextStyle(
                              color: Color(0xfff50202),fontWeight: FontWeight.bold
                          ),),
                          SizedBox(height: 8.h,),
                          Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("Vin No. Pic:-",style: TextStyle(
                                      color: Color(0xff049486),fontWeight: FontWeight.bold
                                  ),),
                                  SizedBox(height: 5.h,),
                                  Container(
                                    height: 100.h,
                                    width: 145.w,
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey),
                                        borderRadius: BorderRadius.circular(10.r)
                                    ),
                                    child: Stack(
                                      children: [
                                        Obx(() =>controller.rxPath.value.isEmpty
                                            ? Container(
                                                decoration:  BoxDecoration(
                                                  border: Border.all(),
                                                  borderRadius: BorderRadius.circular(10.r),
                                                ),
                                              )
                                            : Container(
                                              decoration:  BoxDecoration(
                                                border: Border.all(),
                                                borderRadius: BorderRadius.circular(10.r),
                                                image:  DecorationImage(
                                                    image: FileImage(File(controller.rxPath.value)),fit: BoxFit.fill
                                                ),
                                              ),
                                            ),
                                        ),
                                        Positioned(
                                          bottom: 2.h,
                                          right: 2.w,
                                          child: InkWell(onTap: ()=> showOptionDailog(context),
                                            child: Container(
                                              height: 33.h,
                                              width: 33.w,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                border: Border.all(width: 3.w,color: Colors.black),
                                                color: Colors.white,
                                              ),
                                              child:Icon(Icons.image,size:18.sp,color: Colors.black,)
                                          ),),),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(width: 10.w,),
                              Column(
                                crossAxisAlignment:CrossAxisAlignment.start,
                                children: [
                                  const Text("Id Prove:-",style: TextStyle(
                                      color: Color(0xff049486),fontWeight: FontWeight.bold
                                  ),),
                                  SizedBox(height: 5.h,),
                                  Container(
                                    height: 100.h,
                                    width: 145.w,
                                    decoration: BoxDecoration(
                                        border: Border.all(color:Colors.grey),
                                        borderRadius: BorderRadius.circular(10.r)
                                    ),
                                    child: Stack(
                                      children: [
                                        Obx(() =>controller.VinNo.value.isEmpty
                                            ? Container(
                                                decoration:  BoxDecoration(
                                                border: Border.all(),
                                                borderRadius: BorderRadius.circular(10.r),
                                              ),
                                            )
                                            : Container(
                                              decoration:  BoxDecoration(
                                              border: Border.all(),
                                              borderRadius: BorderRadius.circular(10.r),
                                              image:  DecorationImage(
                                                  image: FileImage(File(controller.VinNo.value)),fit: BoxFit.fill
                                              ),
                                            ),
                                        ),
                                        ),
                                        Positioned(
                                          bottom: 2.h,
                                          right: 2.w,
                                          child: InkWell(onTap: (){
                                            showOptionDailog2(context);
                                          },child: Container(
                                              height:33.h,
                                              width: 33.w,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                border: Border.all(width: 3.w,color: Colors.black),
                                                color: Colors.white,
                                              ),
                                              child:Icon(Icons.image,size:18.sp,color: Colors.black,)
                                          ),),),

                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),

                    )),
                SizedBox(height: 25.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Button2(onPress: ()async{
                      if (formKey3.currentState!.validate()) {
                        bool status = await controller.bookingNetworkApi(data.id.toString());
                        if(status == true){
                          controller.etName.clear();
                          controller.etMobile.clear();
                          controller.etDate.clear();
                          controller.etBikeCC.clear();
                          GetStorage().remove(AppConstant.vin_no_pic);
                          GetStorage().remove(AppConstant.IdProve);
                          controller.VinNo.value = "";
                          controller.rxPath.value = "";
                          controller.idslotType.value = 0;
                        }
                      }
                    }, text: "Book Now"),

                  ],
                ),
                SizedBox(height: 10.0.h),
              ]
          )
      ),
    );
  }

  showOptionDailog(BuildContext context) {
    return showDialog(context: context, builder: (context) =>
        SimpleDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(4.0))),
          backgroundColor:Colors.white
              .withOpacity(0.9),
          children: [
            SimpleDialogOption(
              onPressed: () {
                controller.IDProve(false);
                Get.back();
              },
              child: Row(
                children: [
                  const Icon(Icons.image,color: Color(0xff049486),),
                  Text("   Gallery", style:smallTextStyle)
                ],
              ),
            ),
            SimpleDialogOption(
              onPressed: () {
                controller.IDProve(true);
                Get.back();
              },
              child: Row(
                children: [
                  const Icon(Icons.camera_alt,color: Color(0xff049486),),
                  Text("   Camera", style:smallTextStyle)
                ],
              ),
            ),
            SimpleDialogOption(
              onPressed: () => Get.back(),
              child: Row(
                children: [
                  const Icon(Icons.clear,color: Colors.red,),
                  Text("  Cancel", style: smallTextStyle)
                ],
              ),
            ),
          ],
        ));
  }

  showOptionDailog2(BuildContext context) {
    return showDialog(context: context, builder: (context) =>
        SimpleDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(4.0))),
          backgroundColor:Colors.white
              .withOpacity(0.9),
          children: [
            SimpleDialogOption(
              onPressed: () {
                controller.VINNOPIC(false);
                Get.back();
              },
              child: Row(
                children: [
                  const Icon(Icons.image,color: Color(0xff049486),),
                  Text("   Gallery", style:smallTextStyle)
                ],
              ),
            ),
            SimpleDialogOption(
              onPressed: () {
                controller.VINNOPIC(true);
                Get.back();
              },
              child: Row(
                children: [
                  const Icon(Icons.camera_alt,color: Color(0xff049486),),
                  Text("   Camera", style:smallTextStyle)
                ],
              ),
            ),
            SimpleDialogOption(
              onPressed: () => Get.back(),
              child: Row(
                children: [
                  const Icon(Icons.clear,color: Colors.red,),
                  Text("  Cancel", style: smallTextStyle)
                ],
              ),
            ),
          ],
        ));
  }

}
