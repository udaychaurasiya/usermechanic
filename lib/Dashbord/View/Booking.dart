// ignore_for_file: deprecated_member_use

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:usermechanic/Dashbord/Controller/dashbordcontroller.dart';
import 'package:usermechanic/Dashbord/View/BookingServiceDetails.dart';
import 'package:usermechanic/Widget/LodingWidget.dart';
import 'package:usermechanic/Widget/styles.dart';

class Booking extends StatefulWidget {
  const Booking({Key? key}) : super(key: key);
  @override
  State<Booking> createState() => _BookingState();
}

class _BookingState extends State<Booking> {
  var searchKey = "";
  HomePageController controller = Get.put(HomePageController());
  List data = ["All", "Pending", "Completed", "Cancelled"];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // controller.BookingPagenation();
    // controller.getBookingNetworkApi();
    // controller.getSerachNetworkApi();
    // controller.getBookingCategryNetworkApi();
    controller.getBookingAllDataNetworkApi(data[controller.indexValue.value] ?? "ALl", "", searchKey);
  }

  Widget build(BuildContext context) {
    double height, width;
      height = MediaQuery.of(context).size.height;
      width = MediaQuery.of(context).size.width;
    void _selectOption(option) {
      print('Selected: $option');
    }

    List<PopupMenuEntry> _buildPopupMenuItems() {
      return controller.categryModel2.value.data.map((item) {
        return PopupMenuItem(
          onTap: () {
            controller.CategaryId.value = int.parse(item.id.toString());
            controller.getBookingAllDataNetworkApi(
                data[controller.indexValue.value] ?? "ALl",
                int.parse(item.id.toString()),searchKey);
            print("${item.id.toString()} +djhyugy8fd");
          },
          value: item.id.toString(),
          child: Text("${item.title}"),
        );
      }).toList();
    }

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () {
          return Future.delayed(Duration.zero, () {
            controller.getBookingAllDataNetworkApi(data[controller.indexValue.value] ?? "ALl", "", "");
          });
        },
        child: FadeInUp(
          delay: const Duration(microseconds: 450),
          child: Padding(
            padding: EdgeInsets.only(left: 8.w, right: 8.w),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      height: 50.h,
                      width: Get.width / 1.2,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: SizedBox(
                        height: 50.h,
                        child: Padding(
                            padding: EdgeInsets.only(top: 8.0.h),
                            child: TextFormField(
                              showCursor: EditableText.debugDeterministicCursor,
                              controller: controller.bookingSearch,
                              textInputAction: TextInputAction.search,
                              onChanged: (value) {
                               setState(() {
                                 searchKey = value;
                                 controller.getBookingAllDataSearchNetworkApi(data[controller.indexValue.value] ?? "ALl", "", value);
                               });
                              },
                              onFieldSubmitted: (value) {
                                  searchKey = value;
                                  controller.getBookingAllDataSearchNetworkApi(data[controller.indexValue.value] ?? "ALl", "", value);
                              },
                              style:
                                  smallTextStyle.copyWith(color: Colors.black),
                              decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Colors.black,
                                      ),
                                      borderRadius:
                                          BorderRadius.circular(30.r)),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Colors.black,
                                      ),
                                      borderRadius:
                                          BorderRadius.circular(30.r)),
                                  labelStyle:  TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14.r,
                                  ),
                                  hintText: "Search...",
                                  enabled: true,
                                  hintStyle:  TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14.r,
                                  ),
                                  suffixIcon: controller.bookingSearch.text.isNotEmpty? GestureDetector(
                                      onTap: () {
                                        setState(() {

                                        });
                                        controller.bookingSearch.clear();
                                        controller.getBookingAllDataSearchNetworkApi(data[controller.indexValue.value] ?? "ALl", "", "");
                                      },
                                      child: const Icon(
                                        Icons.clear,
                                        size: 25,
                                        color: Colors.teal,
                                      )):null,
                                      contentPadding: EdgeInsets.symmetric(horizontal: 12.0.w),
                                      border: const OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.grey),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(5.0)))),
                            )),
                      ),
                    ),
                    const Spacer(),
                    InkWell(
                      onTap: () {
                        showMenu(
                          context: context,
                          position: const RelativeRect.fromLTRB(100, 140, 0, 0),
                          items: _buildPopupMenuItems(),
                        ).then((selectedValue) {
                          if (selectedValue != null) {
                            _selectOption(selectedValue);
                          }
                        });
                      },
                      child: SizedBox(
                        height: 20.h,
                        width: 20.w,
                        child: Image.asset(
                          "assets/images/filter.png",
                          color: Colors.teal,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10.w,
                    )
                  ],
                ),
                SizedBox(height: 10.h),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 40.h,
                        width: Get.width,
                        child: ListView.builder(
                            itemCount: data.length,
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return data.isNotEmpty
                                  ? GestureDetector(
                                      onTap: () {
                                        setState(() {

                                        });
                                        controller.booktype = index;
                                        controller.getBookingAllDataNetworkApi(
                                            data[index], "","");
                                      },
                                      child: Container(
                                        padding: EdgeInsets.only(
                                            left: 10.w, right: 10.w),
                                        height: 20.w,
                                        margin: const EdgeInsets.only(left: 10),
                                        decoration: BoxDecoration(
                                          color: controller.booktype == index
                                              ? Colors.teal
                                              : Colors.white,
                                          border: Border.all(
                                              color:
                                                  controller.booktype == index
                                                      ? Colors.black
                                                      : Colors.teal,
                                              width: Colors.black == index
                                                  ? 1
                                                  : 1),
                                          borderRadius:
                                              BorderRadius.circular(3),
                                        ),
                                        child: Center(
                                            child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              data[index].toString(),
                                              style: smallTextStyle.copyWith(
                                                  color: controller.booktype ==
                                                          index
                                                      ? Colors.white
                                                      : Colors.black,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        )),
                                      ),
                                    )
                                  : const SizedBox();
                            }),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Obx(
                  () => controller.bookingmodel.value.data.isNotEmpty
                      ? Expanded(
                          child: SingleChildScrollView(
                            child: ListView.builder(
                                itemCount: controller.bookingmodel.value.data.length,
                                physics: const BouncingScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  final data = controller
                                      .bookingmodel.value.data[index];
                                  _launchCaller() async {
                                    final url = "tel: ${data.mobileNo}";
                                    if (await canLaunch(url)) {
                                      await launch(url);
                                    } else {
                                      throw 'Could not launch $url';
                                    }
                                  }
                                  // if(data.addDate==null)
                                  var dateTime = data.addDate != null
                                      ? data.addDate.toString()
                                      : DateTime.now();
                                  DateTime parsedDate =
                                      DateTime.parse(dateTime.toString());
                                  String Date = DateFormat('dd-MMM-yyyy')
                                      .format(parsedDate);

                                  var dateTime2 = data.serviceDate != null
                                      ? data.serviceDate.toString()
                                      : DateTime.now();
                                  DateTime parsedDate2 =
                                      DateTime.parse(dateTime2.toString());
                                  String Date2 = DateFormat('dd-MMM-yyyy')
                                      .format(parsedDate2);
                                  return InkWell(
                                    onTap: () {
                                      // controller.Booking=data;
                                      controller.shop_Details.value = data.id.toString();
                                      Get.to(() => BookingServiceDetails(
                                          data.id.toString()));
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(5.w),
                                      margin: EdgeInsets.only(top: 5.h),
                                      decoration: BoxDecoration(
                                          // color: Colors.deepPurple.withOpacity(.1),
                                          borderRadius: BorderRadius.circular(8.r),
                                          border: Border.all(
                                              color:
                                                  const Color(0x4D049486))),
                                      child: Column(
                                        children: [
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Container(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Container(
                                                            padding:
                                                                EdgeInsets
                                                                    .all(5.w),
                                                            decoration:
                                                                const BoxDecoration(
                                                                    // border: Border.all(color: Color(0xff049486)),
                                                                    shape: BoxShape
                                                                        .circle),
                                                            child: Icon(
                                                              Icons.menu_book,
                                                              size: 20.sp,
                                                              color: const Color(
                                                                  0xff049486),
                                                            )),
                                                        SizedBox(
                                                          width: 5.w,
                                                        ),
                                                        SizedBox(
                                                            width: 160.w,
                                                            child: Text(
                                                              data.bookingNo
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      14.sp,
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            )),
                                                        Container(
                                                            padding:
                                                                EdgeInsets
                                                                    .all(5.w),
                                                            decoration:
                                                                const BoxDecoration(
                                                                    // border: Border.all(color: Color(0xff049486)),
                                                                    shape: BoxShape
                                                                        .circle),
                                                            child: Icon(
                                                              Icons
                                                                  .date_range,
                                                              size: 20.sp,
                                                              color: const Color(
                                                                  0xff049486),
                                                            )),
                                                        SizedBox(
                                                          width: 5.w,
                                                        ),
                                                        Text(
                                                          Date.toString(),
                                                          style: TextStyle(
                                                            fontSize: 11.sp,
                                                            color:
                                                                Colors.black,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 5.h,
                                                    ),
                                                    Row(
                                                      children: [
                                                        InkWell(
                                                          onTap:
                                                              _launchCaller,
                                                          child: Container(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(5
                                                                          .w),
                                                              decoration:
                                                                  const BoxDecoration(
                                                                      // border: Border.all(color: Color(0xff049486)),
                                                                      shape: BoxShape
                                                                          .circle),
                                                              child: Icon(
                                                                Icons.call,
                                                                size: 20.sp,
                                                                color: const Color(
                                                                    0xff049486),
                                                              )),
                                                        ),
                                                        SizedBox(
                                                          width: 5.w,
                                                        ),
                                                        InkWell(
                                                            onTap:
                                                                _launchCaller,
                                                            child: Text(
                                                              data.mobileNo
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      14.sp,
                                                                  color: Colors
                                                                      .black),
                                                            )),
                                                        SizedBox(
                                                          width: 100.w,
                                                        ),
                                                         Text(
                                                          "Bike CC :  ",
                                                          style: TextStyle(fontSize: 14.sp,
                                                            color: Color(
                                                                0xff049486),
                                                          ),
                                                        ),
                                                        Text(
                                                          data.bikeCc
                                                              .toString(),
                                                          style: TextStyle(
                                                            fontSize: 14.sp,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 5.5.h,
                                                    ),
                                                    Row(
                                                      children: [
                                                         Text(
                                                          "Owner Name     :  ",
                                                          style: TextStyle(fontSize: 14.sp,
                                                            color: Color(
                                                                0xff049486),
                                                          ),
                                                        ),
                                                        Text(
                                                          data.ownerName
                                                              .toString(),
                                                          style: TextStyle(
                                                            fontSize: 14.sp,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 2.5.h,
                                                    ),
                                                    Row(
                                                      children: [
                                                         Text(
                                                          "Service Type      :  ",
                                                          style: TextStyle(fontSize: 14.sp,
                                                            color: Color(
                                                                0xff049486),
                                                          ),
                                                        ),
                                                        Text(
                                                          data.serviceType
                                                              .toString(),
                                                          style: TextStyle(
                                                            fontSize: 14.sp,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 2.5.h,
                                                    ),
                                                    Row(
                                                      children: [
                                                         Text(
                                                          "Service Date      :  ",
                                                          style: TextStyle(fontSize: 14.sp,
                                                            color: Color(
                                                                0xff049486),
                                                          ),
                                                        ),
                                                        Text(
                                                          Date2.toString(),
                                                          style: TextStyle(
                                                            fontSize: 14.sp,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 2.5.h,
                                                    ),
                                                    Row(
                                                      children: [
                                                         Text(
                                                          "Status                 :  ",
                                                          style: TextStyle(fontSize: 14.sp,
                                                            color: Color(
                                                                0xff049486,),
                                                          ),
                                                        ),
                                                                   Text(
                                                                   data.status == "0" ? "Rejected" :
                                                                   data.bookingStatus == "0" ? "Pending" :
                                                                   data.bookingStatus=="1"? "Reached":
                                                                   data.bookingStatus=="2"? "Picked Up":
                                                                   data.bookingStatus=="3"? "Under Service":
                                                                   data.bookingStatus=="4"? "Ready For Deliver":
                                                                   data.bookingStatus=="5"? "Reached For Deliver":
                                                                   data.bookingStatus=="6"? "Delivered":"",
                                                          style: bodybold3Style
                                                              .copyWith(
                                                                  color: const Color(
                                                                      0xff049486)),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                          // Divider()
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                          ),
                        )
                      : Obx(() => controller.shimmer.value == true
                          ? Expanded(
                            child: SingleChildScrollView(
                              child: ListView.builder(
                                itemCount: 15,
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return Container(
                                    padding: EdgeInsets.all(5.w),
                                    margin: EdgeInsets.only(top: 5.h),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8.r),
                                        border: Border.all(width: 1.0.w, color: Colors.black12)),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Shimmer.fromColors(
                                          baseColor: Colors.grey.shade300,
                                          highlightColor: Colors.grey.shade100,
                                          direction: ShimmerDirection.ltr,
                                          period: const Duration(seconds: 2),
                                          child: Container(
                                            height: 10.0.h,
                                            width: width * 0.40.w,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.circular(8.0.r)
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 5.0.h),
                                        Shimmer.fromColors(
                                          baseColor: Colors.grey.shade300,
                                          highlightColor: Colors.grey.shade100,
                                          direction: ShimmerDirection.ltr,
                                          period: const Duration(seconds: 2),
                                          child: Container(
                                            height: 10.0.h,
                                            width: width * 0.40.w,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(8.0.r)
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 5.0.h),
                                        Shimmer.fromColors(
                                          baseColor: Colors.grey.shade300,
                                          highlightColor: Colors.grey.shade100,
                                          direction: ShimmerDirection.ltr,
                                          period: const Duration(seconds: 2),
                                          child: Container(
                                            height: 10.0.h,
                                            width: width * 0.40.w,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.circular(8.0.r)
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 5.0.h),
                                        Shimmer.fromColors(
                                          baseColor: Colors.grey.shade300,
                                          highlightColor: Colors.grey.shade100,
                                          direction: ShimmerDirection.ltr,
                                          period: const Duration(seconds: 2),
                                          child: Container(
                                            height: 10.0.h,
                                            width: width * 0.60.w,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.circular(8.0.r)
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 5.0.h),
                                        Shimmer.fromColors(
                                          baseColor: Colors.grey.shade300,
                                          highlightColor: Colors.grey.shade100,
                                          direction: ShimmerDirection.ltr,
                                          period: const Duration(seconds: 2),
                                          child: Container(
                                            height: 10.0.h,
                                            width: width * 0.60.w,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.circular(8.0.r)
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 5.0.h),
                                        Shimmer.fromColors(
                                          baseColor: Colors.grey.shade300,
                                          highlightColor: Colors.grey.shade100,
                                          direction: ShimmerDirection.ltr,
                                          period: const Duration(seconds: 2),
                                          child: Container(
                                            height: 10.0.h,
                                            width: width * 0.80.w,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.circular(8.0.r)
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 5.0.h),
                                        Shimmer.fromColors(
                                          baseColor: Colors.grey.shade300,
                                          highlightColor: Colors.grey.shade100,
                                          direction: ShimmerDirection.ltr,
                                          period: const Duration(seconds: 2),
                                          child: Container(
                                            height: 10.0.h,
                                            width: width * 0.80.w,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.circular(8.0.r)
                                            ),
                                          ),
                                        ),

                                      ],
                                    ),
                                  );
                                }),
                    ),
                  )
                          : Container(
                            alignment: Alignment.center,
                              padding: EdgeInsets.only(top: 50.0.h),
                              child: const Image(
                                  image: AssetImage("assets/images/norecord.png")),
                            ),
                      ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
