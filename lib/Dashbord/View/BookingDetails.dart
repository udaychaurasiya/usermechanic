import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:photo_view/photo_view.dart';
import 'package:usermechanic/AppConstant/APIConstant.dart';
import 'package:usermechanic/Dashbord/Controller/dashbordcontroller.dart';
import 'package:usermechanic/Dashbord/Model/BookingModel.dart';
import 'package:usermechanic/Widget/coustom_Dailog.dart';
import 'package:usermechanic/Widget/styles.dart';


class BookingDetails extends StatefulWidget {
  final String id;
  const BookingDetails(this.id,{Key? key}) : super(key: key);

  @override
  State<BookingDetails> createState() => _BookingDetailsState();
}

class _BookingDetailsState extends State<BookingDetails> {
  HomePageController controller=Get.put(HomePageController());
  Datum  data=Datum();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    data=controller.Booking;
    // controller.getBookingNetworkApi();
  }
  Widget build(BuildContext context) {
    var dateTime=data.addDate!=null?data.addDate.toString():DateTime.now();
    DateTime parsedDate = DateTime.parse(dateTime.toString());
    String Date =DateFormat('dd-MMM-yyyy').format(parsedDate);
    // DateTime parsedDate = DateTime.parse(data.addDate.toString());
    // String Date =DateFormat('dd-MMM-yyyy  hh:mm a').format(parsedDate);
    var dateTime2=data.serviceDate!=null?data.serviceDate.toString():DateTime.now();
    DateTime parsedDate2 = DateTime.parse(dateTime2.toString());
    String Date2 =DateFormat('dd-MMM-yyyy').format(parsedDate2);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor:Color(0xff049486),
        title: Text(
          "  Booking Details",
          style: bodyText1Style.copyWith(fontSize: 19.sp, color: Colors.white),
        ),
        leadingWidth: 20.w,
        actions: [
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                            Text(":  ${data.bookingNo}",style:bodybold3Style.copyWith(color: Colors.black),),
                            SizedBox(height: 5.h,),
                            data.username!=null?Text(":  ${data.username}",style:bodybold3Style.copyWith(color: Colors.black),):Text(":",style:bodybold3Style.copyWith(color: Colors.black)),
                            SizedBox(height: 5.h,),
                            data.ownerName!=null?Text(":  ${data.ownerName}",style:bodybold3Style.copyWith(color: Colors.black),):Text(":",style:bodybold3Style.copyWith(color: Colors.black)),
                            SizedBox(height: 5.h,),
                            Text(":  ${data.mobileNo}",style:bodybold3Style.copyWith(color: Colors.black),),
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
                child: Text("Service Details:",style: TextStyle(color: const Color(0xff049486),fontSize: 15.sp,fontWeight: FontWeight.w800),),
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
                            Text(":   ${data.serviceType}",style:bodybold3Style.copyWith(color: Colors.black),),
                            SizedBox(height: 5.h,),
                            Text(":   $Date2",style:bodybold3Style.copyWith(color: Colors.black),),
                            SizedBox(height: 5.h,),
                            Text(":   $Date",style:bodybold3Style.copyWith(color: Colors.black),),
                            SizedBox(height: 5.h,),
                            Text(":   ${data.modifyDate}",style:bodybold3Style.copyWith(color: Colors.black),),
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
                          Text(data.bookingAddress.toString(),style:bodybold3Style.copyWith(color: Colors.black),),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:  EdgeInsets.only(left: 14.w,right: 10.w),
                child: Container(
                  width:Get.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width:Get.width/2.2,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width:60.w,
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
                              width:80.w,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(": ${data.bikeCc}",style:bodybold3Style.copyWith(color: Colors.black),),
                                  SizedBox(height: 5.h,),
                                  Text(data.status == "0" ? "Rejected" :
                                  data.bookingStatus == "0" ? "Pending" :
                                  data.bookingStatus=="1"? "Reached":
                                  data.bookingStatus=="2"? "Picked Up":
                                  data.bookingStatus=="3"? "Under Service":
                                  data.bookingStatus=="4"? "Ready For Deliver":
                                  data.bookingStatus=="5"? "Reached For Deliver":
                                  data.bookingStatus=="6"? "Delivered":"",style:bodybold3Style.copyWith(color: Color(0xff049486)),),
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
                                  Text(data.slotId.toString(),style:bodybold3Style.copyWith(color: Colors.black),),
                                  SizedBox(height: 5.h,),
                                  Text(data.brandName.toString(),style:bodybold3Style.copyWith(color: Colors.black),),
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
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                              print( "$BASE_URL${data.idProve}kdnfh");
                              print( "$BASE_URL${data.vinNoPic}kdnfh2");
                              showAnimatedDialog1(
                                  context,
                                  Center(
                                    child: Stack(
                                      children:[
                                        Positioned(
                                            top: 10,
                                            left: 20,
                                            child: TextButton(onPressed: (){}, child: Icon(Icons.clear,color: Colors.white,))),
                                        Container(
                                        // width: 320.w,
                                        // height: 250.h,
                                        decoration: BoxDecoration(
                                          color: Theme.of(context).cardColor,
                                          border: Border.all(),
                                          borderRadius: BorderRadius.circular(
                                              8),),
                                        child: PhotoView(
                                          imageProvider:NetworkImage( BASE_URL+data.vinNoPic.toString()) ,
                                        ),
                                      ),]
                                    ),
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
                                          BASE_URL+data.vinNoPic.toString()
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
                                        // width: 320.0.w,
                                        // height: 250.0.h,
                                        // padding: const EdgeInsets.all(
                                        //     8),
                                        decoration: BoxDecoration(
                                          color: Theme.of(context).cardColor,
                                          borderRadius: BorderRadius.circular(
                                              10),
                                        ),
                                      child: PhotoView(
                                        imageProvider:NetworkImage(BASE_URL+data.idProve.toString()) ,
                                      ),),
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
                                          BASE_URL+data.idProve.toString()
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
            ],
          ),
        ),
      ),
    );
    //   Scaffold(
    //   appBar: AppBar(
    //     title:Text("Booking Details"),
    //   ),
    //   body: Obx(()=>controller.bookingmodel.value.data!=null
    // ? Column(
    //     children: [
    //
    //     ],
    //   ):Container())
    // );
  }
}
