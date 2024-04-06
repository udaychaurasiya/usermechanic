import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:usermechanic/AppConstant/APIConstant.dart';
import 'package:usermechanic/Dashbord/Controller/dashbordcontroller.dart';
import 'package:usermechanic/Widget/CoustomButton.dart';
import 'package:usermechanic/Widget/EditTextWidget.dart';
import 'package:usermechanic/Widget/TextStyle.dart';
import 'package:usermechanic/Widget/styles.dart';
import 'package:usermechanic/utils/custom_snackbar.dart';
import '../Model/ShopDetailsModel.dart';
class BookingShop extends StatefulWidget {
  final String id;
  const BookingShop( this.id,{Key? key}) : super(key: key);

  @override
  State<BookingShop> createState() => _BookingShopState();
}

class _BookingShopState extends State<BookingShop> {
  HomePageController controller=Get.put(HomePageController());
  Ankit data=Ankit();
  final formKey3 = GlobalKey<FormState>();
  final picker = ImagePicker();
  File? uploadPhoto;
  File? uploadPhoto2;
  Future uploadPhoto1(context, ImageSource source) async {
    final pickedFile = await picker.getImage(source: source);
    if (pickedFile != null) {
      setState(() {
        uploadPhoto = new File(pickedFile.path);
        print(uploadPhoto!.path);
      });
    }
  }
  Future uploadPhoto3(context, ImageSource source) async {
    final pickedFile = await picker.getImage(source: source);
    if (pickedFile != null) {
      setState(() {
        uploadPhoto2 = new File(pickedFile.path);
        print(uploadPhoto2!.path);
      });
    }
  }
  var _selectedItem;
  var _selectedItem2;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.setData();
    data=controller.ShopDetails;
    // controller.getBookingNetworkApi();
    controller.getServiceBrandType();
    controller.getShopDetailsNetworkApi(widget.id);
    _selectedItem!=null;
  }
  Widget build(BuildContext context) {
    print("dkjfgu  ${data}");
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Color(0xff049486),
        leadingWidth: 20.w,
        title: Text("Booking Service"),
      ),
      body: SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:  EdgeInsets.only(left:28.w,right: 28.w,top: 20.h),
                  child: Text(data.shopName.toString(),style: TextStyle(color: Color(0xff105648),fontWeight: FontWeight.bold,fontSize: 20.sp),),
                ),
                Padding(
                    padding:  EdgeInsets.only(left:28.w,right: 28.w,top: 20.h),
                    child: Form(
                      key: formKey3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 10.h,),
                          Obx(()=>controller.categryModel2.value.data!=null? Container(
                            child: DropdownButtonFormField<dynamic>(
                              decoration: InputDecoration(
                                labelText: "Select Categry Type",
                                contentPadding:EdgeInsets.symmetric(horizontal: 15, vertical: 20.r),
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
                              value:_selectedItem2,
                              onChanged: (value) {
                                setState(() {
                                  _selectedItem2 = value;
                                });
                                controller.Categary_Id.value=_selectedItem2;
                                print("fygdjgjdfghhjdfg"+controller.idProveType2.value);
                              },
                              validator: (value) {
                                if (controller.Categary_Id.value == 0) {
                                  return "Please select Brand Type";
                                }
                                return null;
                              },
                              items: controller.categryModel2.value.data.map((dynamic item) {
                                return DropdownMenuItem<dynamic>(
                                  value: item.id.toString(),
                                  child: Text(item.title.toString()),
                                );

                              }).toList(),
                            ),
                          ):Container()
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
                          Obx(()=>controller.brandModel.value.data!=null? Container(
                            child: DropdownButtonFormField<dynamic>(
                              decoration: InputDecoration(
                                labelText: "Select Brand Type",
                                contentPadding:EdgeInsets.symmetric(horizontal: 15, vertical: 20.r),
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
                              value:_selectedItem,
                              onChanged: (value) {
                                setState(() {
                                  _selectedItem = value;
                                });
                                controller.idProveType2.value=_selectedItem;
                                print("fygdjgjdfghhjdfg"+controller.idProveType2.value);
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
                            ),
                          ):Container()
                          ),
                          SizedBox(height: 20.h,),

                          Obx(() => DropdownButtonFormField(
                            isExpanded: true,
                            alignment: Alignment.center,
                            value: controller.idslotType.value,
                            decoration: InputDecoration(
                              // hintText: 'Select an option',
                              // label: const Text('Select an option'),
                              contentPadding:EdgeInsets.symmetric(horizontal: 15, vertical: 20.r),
                              labelText: "Select Slot Type",
                              labelStyle: robotoRegular.copyWith(
                                  color: Color(0xff049486)),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(width:.5,color: Color(0xffc2bfbf)),
                              ),
                              focusedBorder: OutlineInputBorder(
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
                            items: [
                              DropdownMenuItem(
                                value: 0,
                                child: Text(
                                  'Select Slot Type',
                                  style: robotoRegular.copyWith(
                                      color: Color(0xffc2bfbf)),
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
                                child: Text(
                                  '3',
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
                          // Obx(() => DropdownButtonFormField(
                          //   isExpanded: true,
                          //   alignment: Alignment.center,
                          //   value: controller.idslotType.value,
                          //   decoration: InputDecoration(
                          //     // hintText: 'Select an option',
                          //     // label: const Text('Select an option'),
                          //     contentPadding:EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                          //     labelText: "Select Service Type",
                          //     labelStyle: robotoRegular.copyWith(
                          //         color: Color(0xff049486)),
                          //     enabledBorder: OutlineInputBorder(
                          //       borderSide: BorderSide(width:.5,color: Color(0xffc2bfbf)),
                          //     ),
                          //     focusedBorder: OutlineInputBorder(
                          //       borderSide: BorderSide(width:.5,color: Color(0xffc2bfbf)),
                          //     ),
                          //     errorBorder:OutlineInputBorder(
                          //       borderSide: BorderSide(width:.5,color: Color(0xffc2bfbf)),
                          //     ),
                          //     border:OutlineInputBorder(
                          //       borderSide: BorderSide(width:.5,color: Color(0xffc2bfbf)),
                          //     ),
                          //     focusedErrorBorder:OutlineInputBorder(
                          //       borderSide: BorderSide(width:.5,color: Color(0xffc2bfbf)),
                          //     ),
                          //   ),
                          //   items: [
                          //     DropdownMenuItem(
                          //       value: 0,
                          //       child: Text(
                          //         'Select Brand Type',
                          //         style: robotoRegular.copyWith(
                          //             color: Color(0xffc2bfbf)),
                          //       ),
                          //     ),
                          //     DropdownMenuItem(
                          //       value: 1,
                          //       child: Text(
                          //         '1',
                          //         style: smallTextStyle.copyWith(
                          //             color: Colors.black),
                          //       ),
                          //     ),
                          //     DropdownMenuItem(
                          //       value: 2,
                          //       child: Text(
                          //         '2',
                          //         style: smallTextStyle.copyWith(
                          //             color: Colors.black),
                          //       ),
                          //     ),
                          //     DropdownMenuItem(
                          //       value: 3,
                          //       child: Text(
                          //         '3',
                          //         style: smallTextStyle.copyWith(
                          //             color: Colors.black),
                          //       ),
                          //     ),
                          //     DropdownMenuItem(
                          //       value: 4,
                          //       child: Text(
                          //         '3',
                          //         style: smallTextStyle.copyWith(
                          //             color: Colors.black),
                          //       ),
                          //     ),
                          //   ],
                          //   onChanged: (value) {
                          //     controller.idslotType.value = value as int;
                          //     // print(controller.idProveType.value);
                          //   },
                          //   validator: (value) {
                          //     if (controller.idslotType.value == 0) {
                          //       return "Please select your card";
                          //     }
                          //     return null;
                          //   },
                          // ),
                          // ),
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
                                contentPadding:EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                                enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width:.5,color: Color(0xffc2bfbf)),
                                ),
                                border:OutlineInputBorder(
                                  borderSide: BorderSide(width:.5,color: Color(0xffc2bfbf)),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width:.5,color: Color(0xffc2bfbf)),
                                ),
                                errorBorder:OutlineInputBorder(
                                  borderSide: BorderSide(width:.5,color: Color(0xffc2bfbf)),
                                ),
                                focusedErrorBorder:OutlineInputBorder(
                                  borderSide: BorderSide(width:.5,color: Color(0xffc2bfbf)),
                                ),
                                labelText: "Service Date",
                                labelStyle: robotoRegular.copyWith(
                                  color: Color(0xff049486),),
                                isDense: true,
                                counter: Offstage(),
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
                                            // <-- SEE HERE
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
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime(2050)
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
                          // EditTextWidget(
                          //   controller: controller.etDate,
                          //   validator: (value){
                          //     if(value.toString().isEmpty)
                          //     {
                          //       return "Please Enter Date";
                          //     }
                          //     return null;
                          //   },
                          //   type: TextInputType.number,
                          //   labelText: 'Date',
                          //   length: 10,
                          //
                          // ),
                          SizedBox(height: 20.h,),
                          Text("Uplode Document :-",style: TextStyle(
                              color: Color(0xfff50202),fontWeight: FontWeight.bold
                          ),),
                          SizedBox(height: 8.h,),
                          Container(
                            child: Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Vin No. Pic:-",style: TextStyle(
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
                                              ?
                                          Container(
                                            decoration:  BoxDecoration(
                                                borderRadius: BorderRadius.circular(10.r),
                                                image:  DecorationImage(
                                                    image: NetworkImage(BASE_URL+controller.image),fit: BoxFit.fill)
                                            ),
                                            child: Container(

                                            ),
                                          ): Container(
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
                                            child: InkWell(onTap: (){
                                              showOptionDailog(context);
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
                                SizedBox(width: 10.w,),
                                Column(
                                  crossAxisAlignment:CrossAxisAlignment.start,
                                  children: [
                                    Text("Id Prove:-",style: TextStyle(
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
                                              ?
                                          Container(
                                            decoration:  BoxDecoration(
                                                borderRadius: BorderRadius.circular(10.r),
                                                image:  DecorationImage(
                                                    image: NetworkImage(BASE_URL+controller.image2),fit: BoxFit.fill)
                                            ),
                                            child: Container(
                                            ),
                                          ): Container(
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
                          ),
                        ],
                      ),

                    )),
                SizedBox(height: 25.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Button2(onPress: (){
                      if (formKey3.currentState!.validate()) {
                        controller.ShopBookingServiceApi();
                        // controller.DateRemove();
                      }
                    }, text: "Book Now"),

                  ],
                ),
              ]
          )
      ),
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
                controller.IDProve(false);
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
                controller.IDProve(true);
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
  showOptionDailog2(BuildContext context) {
    return showDialog(context: context, builder: (context) =>
        SimpleDialog(
          shape: RoundedRectangleBorder(
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
                  Icon(Icons.image,color: Color(0xff049486),),
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
