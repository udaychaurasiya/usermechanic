import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:photo_view/photo_view.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:usermechanic/AppConstant/APIConstant.dart';
import 'package:usermechanic/Dashbord/Controller/dashbordcontroller.dart';
import 'package:usermechanic/Widget/EditTextWidget.dart';
import 'package:usermechanic/Widget/PhotoViews.dart';
import 'package:usermechanic/Widget/TextStyle.dart';
import 'package:usermechanic/Widget/coustom_Dailog.dart';
import 'package:usermechanic/Widget/styles.dart';
import 'package:usermechanic/mathod/AppConstant.dart';
class BookingServiceDetails extends StatefulWidget {
  final String id;
  const BookingServiceDetails(this.id, {Key? key}) : super(key: key);

  @override
  State<BookingServiceDetails> createState() => _BookingServiceDetailsState();
}

class _BookingServiceDetailsState extends State<BookingServiceDetails> {
  final HomePageController controller=Get.put(HomePageController());
  late var _razorpay;
  @override

  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    controller.getBookingServiceDetails(widget.id);

    if (controller.bookingservicedetails.value.data!=null &&
        controller.bookingservicedetails.value.data!.transectionList!.isEmpty &&
        controller.bookingservicedetails.value.data!.paymentStatus=="0" &&
        controller.bookingservicedetails.value.data!.bookingStatus == "5") {
      // Schedule the alert dialog to appear after a 1-second delay
      Future.delayed(Duration(seconds: 1), () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title:Center(child: Text("Payment Details",style: bodyText1Style.copyWith(fontSize: 22.sp ,color: Colors.black,decoration: TextDecoration.none),)),
              content: Container(
                height: 200.h,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Rs:",textAlign:TextAlign.center,style: TextStyle( color: Colors.black,decoration: TextDecoration.none,fontSize: 27.sp,fontWeight: FontWeight.bold)),
                        Text(controller.bookingservicedetails.value.data!.payableAmount.toString(),textAlign:TextAlign.center,style: TextStyle( color: Colors.black,decoration: TextDecoration.none,fontSize: 27.sp,fontWeight: FontWeight.bold)),
                      ],
                    ),
                    SizedBox(height: 10.h,),
                    Container(
                      height:100.h,
                      width:Get.width,
                      child: TextFormField(
                        controller: controller.Remark,
                        decoration:  InputDecoration(

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
                          isDense: true,
                          counter: Offstage(),
                          labelText: "Remark",
                          labelStyle: robotoRegular.copyWith(color: Color(0xff049486)),
                          contentPadding:EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                        ),
                        minLines: 2,
                        maxLines:4,
                        keyboardType:
                        TextInputType.multiline,
                      ),
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            MaterialButton(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
                              elevation: 5.0,
                              minWidth: 100.w,
                              height: 40.h,
                              color: Color(0xFF25A48B),
                              child: Text('Pay Now',
                                  style: new TextStyle(fontSize: 14.sp, color: Colors.white,fontWeight: FontWeight.bold)),
                              onPressed: () {
                               controller.TransactionBookingApi(controller.bookingservicedetails.value.data!.id.toString(),
                                   controller.bookingservicedetails.value.data!.adminMasterId.toString(),
                                   controller.bookingservicedetails.value.data!.payableAmount.toString());
                               var options = {
                                 'key': "rzp_test_oXfKl9W8hb1zr7",
                                 'amount': (int.parse(controller.bookingservicedetails.value.data!.payableAmount.toString()) * 100).toString(), //So its pay 500
                                 'name':GetStorage().read(AppConstant.userName).toString(),
                                 'description': 'testing',
                                 'timeout': 300,
                                 'prefill': {
                                   'contact': GetStorage().read(AppConstant.mobile).toString(),
                                   'email': GetStorage().read(AppConstant.email).toString()
                                 }
                               };
                               _razorpay.open(options);
                               Navigator.of(context).pop();
                              },
                            ),
                            Spacer(),
                            MaterialButton(
                              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
                              elevation: 5.0,
                              minWidth: 100.w,
                              height: 40.h,
                              color: const Color(0xFFC90032),
                              child: Text('Cancel',
                                  style: new TextStyle(fontSize: 14.sp, color: Colors.white,fontWeight: FontWeight.bold)),
                              onPressed: () {
                                Navigator.of(context).pop(); // Close the dialog
                              },
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        );
      });
    }
  }
  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    print("Payment Done");
    var transection_Id='${response.paymentId}';
    if(response !="PaymentSuccessResponse"){
    }else{

    }
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print("Payment Fail");
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
  }

  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text(" Booking Details"),
        leadingWidth: 20.w,
      ),
      body: RefreshIndicator(
        color: const Color(0xff050505),
        onRefresh: (){
          return Future.delayed(Duration.zero, () {
            controller.getBookingServiceDetails(widget.id);
            if (controller.bookingservicedetails.value.data!=null &&
                controller.bookingservicedetails.value.data!.transectionList!.isEmpty &&
                controller.bookingservicedetails.value.data!.paymentStatus=="0" &&
                controller.bookingservicedetails.value.data!.bookingStatus == "5") {
              Future.delayed(Duration(seconds: 1), () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title:Center(child: Text("Payment Details",style: bodyText1Style.copyWith(fontSize: 22.sp ,color: Colors.black,decoration: TextDecoration.none),)),
                      content: Container(
                        height: 200.h,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Rs:",textAlign:TextAlign.center,style: TextStyle( color: Colors.black,decoration: TextDecoration.none,fontSize: 27.sp,fontWeight: FontWeight.bold)),
                                Text(controller.bookingservicedetails.value.data!.payableAmount.toString(),textAlign:TextAlign.center,style: TextStyle( color: Colors.black,decoration: TextDecoration.none,fontSize: 27.sp,fontWeight: FontWeight.bold)),
                              ],
                            ),
                            SizedBox(height: 10.h,),
                            Container(
                              height:100.h,
                              width:Get.width,
                              child: TextFormField(
                                controller: controller.Remark,
                                decoration:  InputDecoration(

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
                                  isDense: true,
                                  counter: Offstage(),
                                  labelText: "Remark",
                                  labelStyle: robotoRegular.copyWith(color: Color(0xff049486)),
                                  contentPadding:EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                                ),
                                minLines: 2,
                                maxLines:4,
                                keyboardType:
                                TextInputType.multiline,
                              ),
                            ),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    MaterialButton(
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
                                      elevation: 5.0,
                                      minWidth: 100.w,
                                      height: 40.h,
                                      color: Color(0xFF25A48B),
                                      child: Text('Pay Now',
                                          style: new TextStyle(fontSize: 14.sp, color: Colors.white,fontWeight: FontWeight.bold)),
                                      onPressed: () {
                                        controller.TransactionBookingApi(controller.bookingservicedetails.value.data!.id.toString(),
                                            controller.bookingservicedetails.value.data!.adminMasterId.toString(),
                                            controller.bookingservicedetails.value.data!.payableAmount.toString());
                                        var options = {
                                          'key': "rzp_test_oXfKl9W8hb1zr7",
                                          'amount': (int.parse(controller.bookingservicedetails.value.data!.payableAmount.toString()) * 100).toString(), //So its pay 500
                                          'name':GetStorage().read(AppConstant.userName).toString(),
                                          'description': 'testing',
                                          'timeout': 300,
                                          'prefill': {
                                            'contact': GetStorage().read(AppConstant.mobile).toString(),
                                            'email': GetStorage().read(AppConstant.email).toString()
                                          }
                                        };
                                        _razorpay.open(options);
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    Spacer(),
                                    MaterialButton(
                                      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
                                      elevation: 5.0,
                                      minWidth: 100.w,
                                      height: 40.h,
                                      color: const Color(0xFFC90032),
                                      child: Text('Cancel',
                                          style: new TextStyle(fontSize: 14.sp, color: Colors.white,fontWeight: FontWeight.bold)),
                                      onPressed: () {
                                        Navigator.of(context).pop(); // Close the dialog
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  },
                );
              });
            }
          });
        },
        child: Obx(()=>controller.bookingservicedetails.value.data!=null?
           SingleChildScrollView(
             child: Column(
              children: [
                ListView.builder(
                    itemCount: 1,
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    itemBuilder:
                    (context,index){
                      var dateTime=controller.bookingservicedetails.value.data!.addDate!=null?
                      controller.bookingservicedetails.value.data!.addDate.toString():DateTime.now();
                      DateTime parsedDate = DateTime.parse(dateTime.toString());
                      String Date =DateFormat('dd-MMM-yyyy').format(parsedDate);

                      var dateTime2=controller.bookingservicedetails.value.data!.serviceDate!=null?controller.bookingservicedetails.value.data!.serviceDate.toString():DateTime.now();
                      DateTime parsedDate2 = DateTime.parse(dateTime2.toString());
                      String Date2 =DateFormat('dd-MMM-yyyy').format(parsedDate2);
                  return Column(
                    children: [
                      Padding(
                        padding:  EdgeInsets.all(8.w),
                        child: Container(
                          padding: EdgeInsets.all(10.w),
                          width:Get.width,
                          decoration: BoxDecoration(
                              color: Colors.teal.withOpacity(.2),
                              borderRadius: BorderRadius.circular(10.r)
                          ),

                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                width:100.w,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Booking No",style:bodybold3Style.copyWith(color: Colors.black),),
                                    SizedBox(height: 5.h,),
                                    Text("User Name",style:bodybold3Style.copyWith(color: Colors.black),),
                                    SizedBox(height: 5.h,),
                                    Text("Owner Name",style:bodybold3Style.copyWith(color: Colors.black),),
                                    SizedBox(height: 5.h,),
                                    Text("Mobile No.",style:bodybold3Style.copyWith(color: Colors.black),),
                                  ],
                                ),
                              ),
                              Container(
                                width: Get.width/2,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(":  "+controller.bookingservicedetails.value.data!.bookingNo.toString(),style:bodybold3Style.copyWith(color: Colors.black),),
                                    SizedBox(height: 5.h,),
                                    Text(":  "+controller.bookingservicedetails.value.data!.username.toString(),style:bodybold3Style.copyWith(color: Colors.black),),
                                    SizedBox(height: 5.h,),
                                    Text(":  "+controller.bookingservicedetails.value.data!.ownerName.toString()??"",style:bodybold3Style.copyWith(color: Colors.black),),
                                    SizedBox(height: 5.h,),
                                    Text(":  "+controller.bookingservicedetails.value.data!.mobileNo.toString(),style:bodybold3Style.copyWith(color: Colors.black),),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Divider(),
                      Padding(
                        padding:  EdgeInsets.only(left: 8.w,right: 8.w),
                        child: Text("Service Details:",style: TextStyle(color: Color(0xff049486),fontSize: 15.sp,fontWeight: FontWeight.w800),),
                      ),
                      SizedBox(height: 10.h,),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0,right: 8,top: 8),
                        child: Container(
                          padding: EdgeInsets.all(8.w),
                          width:Get.width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                width:100.w,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Service Type",style:bodybold3Style.copyWith(color: Colors.black),),
                                    SizedBox(height: 5.h,),
                                    Text("Service Charge",style:bodybold3Style.copyWith(color: Colors.black),),
                                    SizedBox(height: 5.h,),
                                    Text("Service Date",style:bodybold3Style.copyWith(color: Colors.black),),
                                    SizedBox(height: 5.h,),
                                    Text("Booking Date",style:bodybold3Style.copyWith(color: Colors.black),),
                                    SizedBox(height: 5.h,),
                                    Text("Modify Date",style:bodybold3Style.copyWith(color: Colors.black),),
                                  ],
                                ),
                              ),
                              Container(
                                width: Get.width/2,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(":   "+controller.bookingservicedetails.value.data!.serviceType.toString(),style:bodybold3Style.copyWith(color: Colors.black),),
                                    SizedBox(height: 5.h,),
                                    Text(":   "+controller.bookingservicedetails.value.data!.serviceCharge.toString(),style:bodybold3Style.copyWith(color: Colors.black),),
                                    SizedBox(height: 5.h,),
                                    Text(":   "+Date2.toString(),style:bodybold3Style.copyWith(color: Colors.black),),
                                    SizedBox(height: 5.h,),
                                    Text(":   "+Date.toString(),style:bodybold3Style.copyWith(color: Colors.black),),
                                    SizedBox(height: 5.h,),
                                    Text(":   "+controller.bookingservicedetails.value.data!.modifyDate.toString(),style:bodybold3Style.copyWith(color: Colors.black),),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding:EdgeInsets.only(left: 14.w,right:10.w ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text("Booking Address :",style:bodybold3Style.copyWith(color: Colors.black),),
                            Container(
                              // padding: EdgeInsets.only(left: 4.w),
                              width: 220.w,
                              child: Column(
                                children: [
                                  Text(controller.bookingservicedetails.value.data!.bookingAddress.toString(),style:bodybold3Style.copyWith(color: Colors.black),),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding:  EdgeInsets.only(left: 14.w,right: 10.w,top: 8.h),
                        child: Container(
                          width:Get.width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Container(
                              //   width:Get.width/2.2,
                              //   child: Row(
                              //     mainAxisAlignment: MainAxisAlignment.start,
                              //     crossAxisAlignment: CrossAxisAlignment.start,
                              //     children: [
                              //       Container(
                              //         width:60.w,
                              //         child: Column(
                              //           mainAxisAlignment: MainAxisAlignment.start,
                              //           crossAxisAlignment: CrossAxisAlignment.start,
                              //           children: [
                              //             Text("Bike CC",style:bodybold3Style.copyWith(color: Colors.black),),
                              //             SizedBox(height: 5.h,),
                              //             Text("Status   :",style:bodybold3Style.copyWith(color: Colors.black),),
                              //           ],
                              //         ),
                              //       ),
                              //       Container(
                              //         width:70.w,
                              //         child: Column(
                              //           mainAxisAlignment: MainAxisAlignment.start,
                              //           crossAxisAlignment: CrossAxisAlignment.start,
                              //           children: [
                              //             Text(": "+controller.bookingservicedetails.value.data!.bikeCc.toString(),style:bodybold3Style.copyWith(color: Colors.black),),
                              //             SizedBox(height: 5.h,),
                              //             Text(    controller.bookingservicedetails.value.data!.status == "0" ? "Rejected" :
                              //                      controller.bookingservicedetails.value.data!.bookingStatus == "0" ? "Pending" :
                              //                      controller.bookingservicedetails.value.data!.bookingStatus=="1"? "Reached":
                              //                      controller.bookingservicedetails.value.data!.bookingStatus=="2"? "Picked Up":
                              //                      controller.bookingservicedetails.value.data!.bookingStatus=="3"? "Under Service":
                              //                      controller.bookingservicedetails.value.data!.bookingStatus=="4"? "Ready For Deliver":
                              //                      controller.bookingservicedetails.value.data!.bookingStatus=="5"? "Reached For Deliver":
                              //                      controller.bookingservicedetails.value.data!.bookingStatus=="6"? "Delivered":"",
                              //                      style:bodybold3Style.copyWith(color: Color(0xff049486)),),
                              //           ],
                              //         ),
                              //       ),
                              //     ],
                              //   ),
                              // ),
                              Container(
                                width:Get.width/2.2,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width:50.w,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text("Bike CC",style:bodybold3Style.copyWith(color: Colors.black),),
                                          SizedBox(height: 5.h,),
                                          Text("Status",style:bodybold3Style.copyWith(color: Colors.black),),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width:10.w,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(":",style:bodybold3Style.copyWith(color: Colors.black),),
                                          SizedBox(height: 5.h,),
                                          Text(":",style:bodybold3Style.copyWith(color: Colors.black),),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width:80.w,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(controller.bookingservicedetails.value.data!.bikeCc.toString(),style:bodybold3Style.copyWith(color: Colors.black),),
                                          SizedBox(height: 5.h,),
                                           Text(    controller.bookingservicedetails.value.data!.status == "0" ? "Rejected" :
                                           controller.bookingservicedetails.value.data!.bookingStatus == "0" ? "Pending" :
                                           controller.bookingservicedetails.value.data!.bookingStatus=="1"? "Reached":
                                           controller.bookingservicedetails.value.data!.bookingStatus=="2"? "Picked Up":
                                           controller.bookingservicedetails.value.data!.bookingStatus=="3"? "Under Service":
                                           controller.bookingservicedetails.value.data!.bookingStatus=="4"? "Ready For Deliver":
                                           controller.bookingservicedetails.value.data!.bookingStatus=="5"? "Reached For Deliver":
                                           controller.bookingservicedetails.value.data!.bookingStatus=="6"? "Delivered":"",
                                           style:bodybold3Style.copyWith(color: Color(0xff049486)),),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width:Get.width/2.2,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width:50.w,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text("Slot",style:bodybold3Style.copyWith(color: Colors.black),),
                                          SizedBox(height: 5.h,),
                                          Text("Brand",style:bodybold3Style.copyWith(color: Colors.black),),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width:10.w,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(":",style:bodybold3Style.copyWith(color: Colors.black),),
                                          SizedBox(height: 5.h,),
                                          Text(":",style:bodybold3Style.copyWith(color: Colors.black),),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width:80.w,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(controller.bookingservicedetails.value.data!.slotId.toString(),style:bodybold3Style.copyWith(color: Colors.black),),
                                          SizedBox(height: 5.h,),
                                          Text(controller.bookingservicedetails.value.data!.brandName.toString(),style:bodybold3Style.copyWith(color: Colors.black),),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Divider(),
                      SizedBox(height: 15.h,),
                      Padding(
                        padding:  EdgeInsets.only(left: 8.w,right: 8.w),
                        child: Text("Documents Details:",style: TextStyle(color: Color(0xff049486),fontSize: 15.sp,fontWeight: FontWeight.w800),),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(
                              width:Get.width/2.1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Vin Number Image:",style:bodybold3Style.copyWith(color: Colors.black),),
                                  SizedBox(height: 5.0.h),
                                  InkWell(
                                    onTap: () {
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
                                                child:Image.network(BASE_URL+controller.bookingservicedetails.value.data!.vinNoPic.toString(),fit: BoxFit.fill,),
                                              )

                                          ),
                                          dismissible: true);
                                        },
                                    child: Container(
                                        width: double.infinity,
                                        height: 100.0.h,
                                        padding:  EdgeInsets.all(
                                            8),
                                        decoration: BoxDecoration(
                                          color:Colors.tealAccent,
                                          border: Border.all(),
                                          borderRadius: BorderRadius.circular(
                                              8),
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                  BASE_URL+controller.bookingservicedetails.value.data!.vinNoPic.toString()
                                              ),
                                              fit: BoxFit.fill),
                                        )),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 10.0.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Prove ID Image:",style:bodybold3Style.copyWith(color: Colors.black),),
                                  SizedBox(height: 5.0.h),
                                  InkWell(
                                    onTap: () {
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
                                                child:Image.network(BASE_URL+controller.bookingservicedetails.value.data!.idProve.toString(),fit: BoxFit.fill,),
                                              )

                                          ),
                                          dismissible: true);
                                    },
                                    child: Container(
                                        width: double.infinity,
                                        height: 100.0.h,
                                        padding:  EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color:Colors.tealAccent,
                                          border: Border.all(),
                                          borderRadius: BorderRadius.circular(10.r),
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                  BASE_URL+controller.bookingservicedetails.value.data!.idProve.toString()
                                                // "https://www.bestcollections.org/wp-content/uploads/2020/04/company-id-card-template.jpg"
                                                // "${AppConstants.BASE_URL}/${detailsController.serviceModel.value.data![detailsController.detailsIndex.value].idProve.toString()}"
                                              ),
                                              fit: BoxFit.fill),
                                        )),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 15.h,),
                      ],
                  );
                }),
                SizedBox(height: 10.0.h),
                Padding(
                  padding:  EdgeInsets.only(left: 8.w,right: 8.w),
                  child: Column(
                    children: [
                      Column(
                        children: [
                          Table(
                            columnWidths: {
                              0: FlexColumnWidth(3),
                              1: FlexColumnWidth(3),
                            },
                            border: TableBorder.all(width: .5),
                            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                            children: [
                              TableRow(
                                children: [
                                  TableCell(
                                    child: Padding(
                                      padding:  EdgeInsets.only(top:5.h,bottom: 5.h),
                                      child: Center(child: Text("Parts Name",textAlign:TextAlign.center,style: TextStyle(fontSize: 12.sp,fontWeight: FontWeight.bold),)),
                                    ),
                                  ),
                                  TableCell(
                                    child: Padding(
                                      padding:  EdgeInsets.only(top:5.h,bottom: 5.h),
                                      child: Center(child: Text("Price(Rs)",textAlign:TextAlign.center,style: TextStyle(fontSize: 12.sp,fontWeight: FontWeight.bold))),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                      Container(
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: ScrollPhysics(),
                          itemCount: controller.bookingservicedetails.value.data!.partsList!.length,
                          itemBuilder: (BuildContext context, int index) {
                            final data=controller.bookingservicedetails.value.data!.partsList![index];
                            return  Column(
                              children: [
                                Table(
                                  columnWidths: {
                                    0: FlexColumnWidth(3),
                                    1: FlexColumnWidth(3),
                                  },
                                  border: TableBorder.all(width: .5),
                                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                                  children: [
                                    TableRow(
                                      children: [
                                        TableCell(
                                          child: Padding(
                                            padding:  EdgeInsets.only(top:5.h,bottom: 5.h),
                                            child: Center(child: Text(data.parts.toString(),textAlign:TextAlign.center,style: TextStyle(fontSize: 12.sp),)),
                                          ),
                                        ),
                                        TableCell(
                                          child: Padding(
                                            padding:  EdgeInsets.only(top:5.h,bottom: 5.h),
                                            child: Center(child: Text(data.amount.toString()+".00",textAlign:TextAlign.center,style: TextStyle(fontSize: 12.sp))),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30.0.h),
                   Padding(
                     padding:  EdgeInsets.only(left: 8.w,right: 8.w),
                     child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(5.r),
                      ),
                      child: ExpansionTile(
                          iconColor: Colors.grey,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.r)),
                          // trailing: Icon(Icons.add, size: 22.sp, color: Colors.black54,),
                          title: Text(
                            "Pickup Image",
                            style: smallTextStyle.copyWith(color: Colors.black),
                            textAlign: TextAlign.start,
                          ),
                          children: [
                      Obx(()=>controller.bookingservicedetails.value.data!.pickedupImage!.isNotEmpty?
                        Container(
                          color: Color(0x5fd7d6d6),
                          padding: EdgeInsets.only(left:8.w,right: 8.w,top: 13.h,bottom: 13.h),
                           child: GridView.builder(
                             itemCount: controller.bookingservicedetails.value.data!.pickedupImage!.length,
                             shrinkWrap: true,
                             physics: ScrollPhysics(),
                             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                 crossAxisCount: 2,
                                 childAspectRatio: 1,
                                 crossAxisSpacing: 8,
                                 mainAxisSpacing: 8,
                                  mainAxisExtent:120
                             ),
                             itemBuilder: (BuildContext context, int index){
                               final data=controller.bookingservicedetails.value.data!.pickedupImage![index];
                               return InkWell(onTap:(){

                                 showAnimatedDialog1(
                                     context,
                                     Center(
                                       child: Container(
                                         width: 320.0.w,
                                         height: 250.0.h,
                                         padding: const EdgeInsets.all(
                                             8),
                                         decoration: BoxDecoration(
                                           color: Theme.of(context).cardColor,
                                           borderRadius: BorderRadius.circular(
                                               10),
                                         ),
                                         child: PhotoView(
                                           minScale: PhotoViewComputedScale.contained * 1,
                                           maxScale: PhotoViewComputedScale.covered * 2,
                                           imageProvider:NetworkImage(BASE_URL+data.image.toString()) ,
                                         ),),
                                     ),
                                     dismissible: true);
                               },child: Image.network(BASE_URL+data.image.toString(),fit: BoxFit.fill,));
                             },
                           )):Container()
                      ),
                    ]

                ),
                     )),
                SizedBox(height: 10.0.h),
                Padding(
                  padding:  EdgeInsets.only(left: 8.w,right: 8.w),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(5.r),
                    ),
                    child: ExpansionTile(
                        iconColor: Colors.grey,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.r)),
                        // trailing: Icon(Icons.add, size: 22.sp, color: Colors.black54,),
                        title: Text(
                          "Service Image",
                          style: smallTextStyle.copyWith(color: Colors.black),
                          textAlign: TextAlign.start,
                        ),
                        children:  [
                          Obx(()=>controller.bookingservicedetails.value.data!.underServiceImage!.isNotEmpty?
                          Container(
                              color: Color(0x5fd7d6d6),
                              padding: EdgeInsets.only(left:8.w,right: 8.w,top: 13.h,bottom: 13.h),
                              child: GridView.builder(
                                itemCount: controller.bookingservicedetails.value.data!.underServiceImage!.length,
                                shrinkWrap: true,
                                physics: ScrollPhysics(),
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    childAspectRatio: 1,
                                    crossAxisSpacing: 8,
                                    mainAxisSpacing: 8,
                                    mainAxisExtent:120
                                ),
                                itemBuilder: (BuildContext context, int index){
                                  final data=controller.bookingservicedetails.value.data!.underServiceImage![index];
                                  return InkWell(onTap:(){

                                    showAnimatedDialog1(
                                        context,
                                        Center(
                                          child: Container(
                                            width: 320.0.w,
                                            height: 250.0.h,
                                            padding: const EdgeInsets.all(
                                                8),
                                            decoration: BoxDecoration(
                                              color: Theme.of(context).cardColor,
                                              borderRadius: BorderRadius.circular(
                                                  10),
                                            ),
                                            child: PhotoView(
                                              minScale: PhotoViewComputedScale.contained * 1,
                                              maxScale: PhotoViewComputedScale.covered * 2,
                                              imageProvider:NetworkImage(BASE_URL+data.image.toString()) ,
                                            ),),
                                        ),
                                        dismissible: true);
                                  },child: Image.network(BASE_URL+data.image.toString(),fit: BoxFit.fill,));
                                },
                              )):Container()
                          ),
                        ]
                    ),
                  ),
                ),
                SizedBox(height: 10.0.h),
                Padding(
                  padding:  EdgeInsets.only(left: 8.w,right: 8.w),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(5.r),
                    ),
                    child: ExpansionTile(
                        iconColor: Colors.grey,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.r)),
                        // trailing: Icon(Icons.add, size: 22.sp, color: Colors.black54,),
                        title: Text(
                          "Ready For Deliverd Images",
                          style: smallTextStyle.copyWith(color: Colors.black),
                          textAlign: TextAlign.start,
                        ),
                        children:  [
                          Obx(()=>controller.bookingservicedetails.value.data!.readyDeliverImage!.isNotEmpty?
                          Container(
                              color: Color(0x5fd7d6d6),
                              padding: EdgeInsets.only(left:8.w,right: 8.w,top: 13.h,bottom: 13.h),
                              child: GridView.builder(
                                itemCount: controller.bookingservicedetails.value.data!.readyDeliverImage!.length,
                                shrinkWrap: true,
                                physics: ScrollPhysics(),
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    childAspectRatio: 1,
                                    crossAxisSpacing: 8,
                                    mainAxisSpacing: 8,
                                    mainAxisExtent:120
                                ),
                                itemBuilder: (BuildContext context, int index){
                                  final data=controller.bookingservicedetails.value.data!.readyDeliverImage![index];
                                  return InkWell(onTap:(){

                                    showAnimatedDialog1(
                                        context,
                                        Center(
                                          child: Container(
                                            width: 320.0.w,
                                            height: 250.0.h,
                                            padding: const EdgeInsets.all(
                                                8),
                                            decoration: BoxDecoration(
                                              color: Theme.of(context).cardColor,
                                              borderRadius: BorderRadius.circular(
                                                  10),
                                            ),
                                            child: PhotoView(
                                              minScale: PhotoViewComputedScale.contained * 1,
                                              maxScale: PhotoViewComputedScale.covered * 2,
                                              imageProvider:NetworkImage(BASE_URL+data.image.toString()) ,
                                            ),),
                                        ),
                                        dismissible: true);
                                  },child: Image.network(BASE_URL+data.image.toString(),fit: BoxFit.fill,));
                                },
                              )):Container()
                          ),
                        ]
                    ),
                  ),
                ),
                SizedBox(height: 10.0.h),
                 Padding(
                   padding:  EdgeInsets.only(left: 8.w,right: 8.w),
                   child: Container(
                   height: 55.h,
                   width: Get.width,
                   decoration: BoxDecoration(
                     color: Colors.grey.shade300,
                     borderRadius: BorderRadius.circular(5.r),
                   ),
                     child: Padding(
                       padding:  EdgeInsets.only(left: 13.w,top: 15.h),
                       child: Text(controller.bookingservicedetails.value.data!.bookingStatus=="5"?"Reached Machenic":"Machenic Reach",
                         style: smallTextStyle.copyWith(
                         color: controller.bookingservicedetails.value.data!.bookingStatus == "5"
                             ? Colors.green
                             : Colors.black,
                         fontSize: 16.0,
                         fontWeight: FontWeight.bold,
                       ),),
                     ),
               ),
                 ),
                 SizedBox(height: 10.0.h),
                Padding(
                  padding:  EdgeInsets.only(left: 8.w,right: 8.w),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(5.r),
                    ),
                    child: ExpansionTile(
                      iconColor: Colors.grey,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.r)),
                        // trailing: Icon(Icons.add, size: 22.sp, color: Colors.black54,),
                        title: Text(
                          "Delivered Image",
                          style: smallTextStyle.copyWith(color: Colors.black),
                          textAlign: TextAlign.start,
                        ),
                        children:  [
                          Obx(()=>controller.bookingservicedetails.value.data!.deliveredImage!.isNotEmpty?
                          Container(
                              color: Color(0x5fd7d6d6),
                              padding: EdgeInsets.only(left:8.w,right: 8.w,top: 13.h,bottom: 13.h),
                              child: GridView.builder(
                                itemCount: controller.bookingservicedetails.value.data!.deliveredImage!.length,
                                shrinkWrap: true,
                                physics: ScrollPhysics(),
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    childAspectRatio: 1,
                                    crossAxisSpacing: 8,
                                    mainAxisSpacing: 8,
                                    mainAxisExtent:120
                                ),
                                itemBuilder: (BuildContext context, int index){
                                  final data=controller.bookingservicedetails.value.data!.deliveredImage![index];
                                  return InkWell(onTap:(){

                                    showAnimatedDialog1(
                                        context,
                                        Center(
                                          child: Container(
                                            width: 320.0.w,
                                            height: 250.0.h,
                                            padding: const EdgeInsets.all(
                                                8),
                                            decoration: BoxDecoration(
                                              color: Theme.of(context).cardColor,
                                              borderRadius: BorderRadius.circular(
                                                  10),
                                            ),
                                            child: PhotoView(
                                              minScale: PhotoViewComputedScale.contained * 1,
                                              maxScale: PhotoViewComputedScale.covered * 2,
                                              imageProvider:NetworkImage(BASE_URL+data.image.toString()) ,
                                            ),),
                                        ),
                                        dismissible: true);
                                  },child: Image.network(BASE_URL+data.image.toString(),fit: BoxFit.fill,));
                                },
                              )):Container()
                          ),
                        ]
                    ),
                  ),
                ),
                SizedBox(height: 30.0.h),
                Padding(
                  padding:  EdgeInsets.only(left: 8.w,right: 8.w),
                  child: Column(
                    children: [
                  Column(
                  children: [
                  Table(
                  columnWidths: {
                  0: FlexColumnWidth(2),
                  1: FlexColumnWidth(1),
                  1: FlexColumnWidth(1),
                  1: FlexColumnWidth(1),
                  },
                    border: TableBorder.all(width: .5),
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    children: [
                      TableRow(
                        children: [
                          TableCell(
                            child: Padding(
                              padding:  EdgeInsets.only(top:10.h,bottom: 10.h),
                              child: Center(child: Text("Transaction Id",textAlign:TextAlign.center,style: TextStyle(fontSize: 14.sp,fontWeight: FontWeight.bold),)),
                            ),
                          ),
                          TableCell(
                            child: Padding(
                              padding:  EdgeInsets.only(top:5.h,bottom: 5.h),
                              child: Center(child: Text("Amount",textAlign:TextAlign.center,style: TextStyle(fontSize: 14.sp,fontWeight: FontWeight.bold))),
                            ),
                          ),
                          TableCell(
                            child: Padding(
                              padding:  EdgeInsets.only(top:5.h,bottom: 5.h),
                              child: Center(child: Text("Remark",textAlign:TextAlign.center,style: TextStyle(fontSize: 14.sp,fontWeight: FontWeight.bold))),
                            ),
                          ),
                          TableCell(
                            child: Padding(
                              padding:  EdgeInsets.only(top:5.h,bottom: 5.h),
                              child: Center(child: Text("Date",textAlign:TextAlign.center,style: TextStyle(fontSize: 14.sp,fontWeight: FontWeight.bold))),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                  ],
                ),
                      Container(
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: ScrollPhysics(),
                          itemCount: controller.bookingservicedetails.value.data!.transectionList!.length,
                          itemBuilder: (BuildContext context, int index) {
                            final data=controller.bookingservicedetails.value.data!.transectionList![index];
                            // DateTime parsedDate2 = DateTime.parse(data.addDate.toString());
                            // String Date2 =DateFormat('dd-MMM-yyyy').format(data.addDate);
                            return
                              Column(
                              children: [
                                Table(
                                  columnWidths: {
                                    0: FlexColumnWidth(2),
                                    1: FlexColumnWidth(1),
                                    1: FlexColumnWidth(1),
                                    1: FlexColumnWidth(1),
                                  },
                                  border: TableBorder.all(width: .5),
                                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                                  children: [
                                    TableRow(
                                      children: [
                                        TableCell(
                                          child: Padding(
                                            padding:  EdgeInsets.only(top:5.h,bottom: 5.h),
                                            child: Center(child: Text(data.transactionId.toString(),textAlign:TextAlign.center,style: TextStyle(fontSize: 12.sp),)),
                                          ),
                                        ),
                                        TableCell(
                                          child: Padding(
                                            padding:  EdgeInsets.only(top:5.h,bottom: 5.h),
                                            child: Center(child: Text(("Rs.")+data.amount.toString()+".0",textAlign:TextAlign.center,style: TextStyle(fontSize: 12.sp))),
                                          ),
                                        ),
                                        TableCell(
                                          child: Padding(
                                            padding:  EdgeInsets.only(top:5.h,bottom: 5.h),
                                            child: Center(child: Text(data.remark.toString(),textAlign:TextAlign.center,style: TextStyle(fontSize: 12.sp))),
                                          ),
                                        ),
                                        TableCell(
                                          child: Padding(
                                            padding:  EdgeInsets.only(top:5.h,bottom: 5.h),
                                            child: Center(child: data.addDate!=null?
                                            Text(data.addDate.toString(),textAlign:TextAlign.center,style: TextStyle(fontSize: 10.sp,fontWeight: FontWeight.bold)):Text("")),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 15.h,)
               ]
        ),
           ):Container()
        ),
      )
    );
  }
  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }
}
