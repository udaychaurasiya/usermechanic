// ignore_for_file: deprecated_member_use, invalid_use_of_protected_member

import 'dart:async';
import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:usermechanic/AppConstant/APIConstant.dart';
import 'package:usermechanic/Dashbord/Controller/dashbordcontroller.dart';
import 'package:usermechanic/Dashbord/View/HomePage/FullService.dart';
import 'package:usermechanic/Dashbord/View/HomePage/MapView.dart';
import 'package:usermechanic/Dashbord/View/HomePage/Rating.dart';
import 'package:usermechanic/Dashbord/View/ShopListDeatils.dart';
import 'package:usermechanic/Widget/LodingWidget.dart';
import 'package:usermechanic/Widget/TextStyle.dart';
import 'package:usermechanic/Widget/styles.dart';
import 'package:usermechanic/auth/logincontroller.dart';
import 'package:usermechanic/utils/all_image.dart';
import 'package:usermechanic/utils/data_not_found.dart';
import 'OnroadService.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {
  var searchKey = "";
  late String keyMessage;
  HomePageController controller=Get.put(HomePageController());
  final LoginController _controller=Get.put(LoginController());
  int start=0;
  List imgList = [
    Image.asset('assets/images/splash.jpg'),
    Image.asset('assets/images/onb2.jpg'),
    Image.asset('assets/images/onb1.jpg'),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.getBannerNetworkApi();
    controller.getCategryNetworkApi();
    controller.getShopListNetworkApi(searchKey);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeMap();
    });
  }

  Future<void> _initializeMap() async {
    GoogleMapController.init;
  }
 @override
  Widget build(BuildContext context) {
    controller.selectedHomeIndex==0;
    return Scaffold(
      body:RefreshIndicator(
        color: const Color(0xff049486),
        onRefresh: (){
       return Future.delayed(Duration.zero, () {
        controller.getBannerNetworkApi();
        controller.getCategryNetworkApi();
        controller.getShopListNetworkApi(searchKey);
        controller.postcurrentaddressNetworkApi();
        });
        },
        child: SingleChildScrollView(
            controller: controller.scrollController,
            child: FadeInUp(
              delay: const Duration(microseconds: 450),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(() =>
                  controller.bannerModel.value.data != null ?
                  Padding(
                    padding:  EdgeInsets.only(left: 8.w,right: 8.w,top: 6.h),
                    child: SizedBox(
                        height: 150.h,
                        width: MediaQuery.of(context).size.width,
                        child: CarouselSlider.builder(
                          itemCount:
                          controller.bannerModel.value.data!.length,
                          options: CarouselOptions(
                            aspectRatio: 2.0,
                            enlargeCenterPage: true,
                            viewportFraction: 1,
                            autoPlay: true,
                            autoPlayAnimationDuration:
                            const Duration(milliseconds: 800),
                            autoPlayInterval: const Duration(seconds: 3),
                            autoPlayCurve: Curves.fastOutSlowIn,
                          ),
                          itemBuilder: (ctx, index, realIdx) {
                            final datas =
                            controller.bannerModel.value.data![index];
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(10.r),
                              child: Container(
                                height: 180.h,
                                decoration: BoxDecoration(
                                  // border: Border.all(),
                                  borderRadius: BorderRadius.circular(10.r)
                                ),
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width,
                                child: CachedNetworkImage(
                                  fit: BoxFit.fill,
                                  imageUrl: BASE_URL + datas.image.toString(),
                                  height: 76.h,
                                  width: 76.w,
                                  placeholder: (context, url) =>
                                      const Center(
                                          child:
                                          CircularProgressIndicator()),
                                  errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                                ),
                              ),
                            );
                          },
                        )),
                  ) : Container()
                  ),
                  SizedBox(height: 10.h,),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: (){
                        Get.to(()=> const OnroadService());
                      },
                      child: Card(
                        color: Colors.teal,
                        shape:RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.r)
                        ),
                        child: Container(
                          height: 40.h,
                          width: Get.width,
                          padding: EdgeInsets.only(left: 15.w,right: 8.w),
                          child: Row(
                            children: [
                              Text("OnRoad Service",style: TextStyle(fontSize: 15.r,fontWeight: FontWeight.bold,color: Colors.white),),
                              const Spacer(),
                              Icon(Icons.arrow_forward_outlined,color: Colors.white,size: 24.r,)
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10.h,),
                  Padding(
                    padding: const EdgeInsets.only(left: 6.0, right: 6),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 5.h,),
                        Obx(()=>controller.categryModel2.value.data.isNotEmpty?
                          Padding(
                            padding:  EdgeInsets.only(left: 8.w, right: 8.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text("Services", style: robotoBold.copyWith(
                                      fontSize: 20.sp, color: const Color(0xff049486)),),
                                ),
                                   SizedBox(
                                    height: 70.h,
                                    child:
                                    ListView.builder(
                                        itemCount: controller.categryModel2.value.data.length,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context,index){
                                        final data=controller.categryModel2.value.data[index];
                                      return InkWell(
                                                  onTap: () {
                                                    controller.Categry=data;
                                                    Get.to(() => const FullService());
                                                    print(BASE_URL+data.image.toString());
                                                  },
                                                  child: Padding(
                                                    padding:  EdgeInsets.only(right: 8.w),
                                                    child: Container(
                                                      padding: EdgeInsets.only(
                                                          left: 5.w, top: 5.h),
                                                      height: 71.h,
                                                      width: 105.w,
                                                      decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(
                                                              10.r),
                                                          border: Border.all(
                                                              color: const Color(0xff4f5252))
                                                      ),
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        children: [
                                                          Text(data.title.toString(),style: TextStyle(color: Colors.teal,fontSize: 14.sp),),
                                                          Row(
                                                            children: [
                                                              // SizedBox(
                                                              //   height: 45.h,
                                                              //   width: 55.w,
                                                              //   child: Column(
                                                              //     crossAxisAlignment:
                                                              //     CrossAxisAlignment.start,
                                                              //     mainAxisAlignment:
                                                              //     MainAxisAlignment.start,
                                                              //     children: [
                                                              //       // Text(
                                                              //       //   data.title.toString(),
                                                              //       //   style: bodyText2Style
                                                              //       //       .copyWith(
                                                              //       //       color: Color(0xff049486),
                                                              //       //       fontSize: 14.sp),
                                                              //       // ),
                                                              //       Text("Service",
                                                              //           style: smallTextStyle
                                                              //               .copyWith(
                                                              //               fontSize: 14.sp))
                                                              //     ],
                                                              //   ),
                                                              // ),
                                                              SizedBox(
                                                                height: 30.h,
                                                                width: 30.w,
                                                                child: Image.network(BASE_URL+data.image.toString(),
                                                                  fit: BoxFit.fill,),
                                                              )
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                );
                                    })
                                    // ListView(
                                    //   scrollDirection: Axis.horizontal,
                                    //   children: [
                                    //     Padding(
                                    //       padding: EdgeInsets.only(right: 10.w),
                                    //       child: InkWell(
                                    //         onTap: () {
                                    //           Get.to(() => FullService());
                                    //         },
                                    //         child: Container(
                                    //           padding: EdgeInsets.only(
                                    //               left: 5.w, top: 5.h),
                                    //           height: 71.h,
                                    //           width: 105.w,
                                    //           decoration: BoxDecoration(
                                    //               borderRadius: BorderRadius.circular(
                                    //                   10.r),
                                    //               border: Border.all(
                                    //                   color: Color(0xff4f5252))
                                    //           ),
                                    //           child: Row(
                                    //             children: [
                                    //               Container(
                                    //                 height: 60.h,
                                    //                 width: 55.w,
                                    //                 child: Column(
                                    //                   crossAxisAlignment:
                                    //                   CrossAxisAlignment.start,
                                    //                   mainAxisAlignment:
                                    //                   MainAxisAlignment.start,
                                    //                   children: [
                                    //                     Text(
                                    //                       "Full",
                                    //                       style: bodyText2Style
                                    //                           .copyWith(
                                    //                           color: Color(0xff049486),
                                    //                           fontSize: 14.sp),
                                    //                     ),
                                    //                     Text("Service",
                                    //                         style: smallTextStyle
                                    //                             .copyWith(
                                    //                             fontSize: 14.sp))
                                    //                   ],
                                    //                 ),
                                    //               ),
                                    //               Container(
                                    //                 height: 60.h,
                                    //                 width: 40.w,
                                    //                 child: Image.asset(
                                    //                   "assets/images/splash.jpg",
                                    //                   fit: BoxFit.fill,),
                                    //               )
                                    //             ],
                                    //           ),
                                    //         ),
                                    //       ),
                                    //     ),
                                    //     Padding(
                                    //       padding: EdgeInsets.only(right: 10.w),
                                    //       child: InkWell(
                                    //         onTap: () {
                                    //           Get.to(()=>OnRoadService());
                                    //         },
                                    //         child: Container(
                                    //           padding: EdgeInsets.only(
                                    //               left: 5.w, top: 5.h),
                                    //           height: 71.h,
                                    //           width: 105.w,
                                    //           decoration: BoxDecoration(
                                    //               borderRadius: BorderRadius.circular(
                                    //                   10.r),
                                    //               border: Border.all(
                                    //                   color: Color(0xff4f5252))
                                    //           ),
                                    //           child: Row(
                                    //             children: [
                                    //               Container(
                                    //                 height: 60.h,
                                    //                 width: 55.w,
                                    //                 child: Column(
                                    //                   crossAxisAlignment:
                                    //                   CrossAxisAlignment.start,
                                    //                   mainAxisAlignment:
                                    //                   MainAxisAlignment.start,
                                    //                   children: [
                                    //                     Text(
                                    //                       "OnRoad",
                                    //                       style: bodyText2Style
                                    //                           .copyWith(
                                    //                           color: Color(0xff049486),
                                    //                           fontSize: 14.sp),
                                    //                     ),
                                    //                     Text("Service",
                                    //                         style: smallTextStyle
                                    //                             .copyWith(
                                    //                             fontSize: 14.sp))
                                    //                   ],
                                    //                 ),
                                    //               ),
                                    //               Container(
                                    //                 height: 60.h,
                                    //                 width: 40.w,
                                    //                 child: Image.asset(
                                    //                   "assets/images/onb1.jpg",
                                    //                   fit: BoxFit.fill,),
                                    //               )
                                    //             ],
                                    //           ),
                                    //         ),
                                    //       ),
                                    //     ),
                                    //     Padding(
                                    //       padding: EdgeInsets.only(right: 10.w),
                                    //       child: InkWell(
                                    //         onTap: () {
                                    //           Get.to(()=>BikeService());
                                    //         },
                                    //         child: Container(
                                    //           padding: EdgeInsets.only(
                                    //               left: 5.w, top: 5.h),
                                    //           height: 71.h,
                                    //           width: 105.w,
                                    //           decoration: BoxDecoration(
                                    //               borderRadius: BorderRadius.circular(
                                    //                   10.r),
                                    //               border: Border.all(
                                    //                   color: Color(0xff4f5252))
                                    //           ),
                                    //           child: Row(
                                    //             children: [
                                    //               Container(
                                    //                 height: 60.h,
                                    //                 width: 55.w,
                                    //                 child: Column(
                                    //                   crossAxisAlignment:
                                    //                   CrossAxisAlignment.start,
                                    //                   mainAxisAlignment:
                                    //                   MainAxisAlignment.start,
                                    //                   children: [
                                    //                     Text(
                                    //                       "Bike",
                                    //                       style: bodyText2Style
                                    //                           .copyWith(
                                    //                           color: Color(0xff049486),
                                    //                           fontSize: 14.sp),
                                    //                     ),
                                    //                     Text("Service",
                                    //                         style: smallTextStyle
                                    //                             .copyWith(
                                    //                             fontSize: 14.sp))
                                    //                   ],
                                    //                 ),
                                    //               ),
                                    //               Container(
                                    //                 height: 60.h,
                                    //                 width: 40.w,
                                    //                 child: Image.asset(
                                    //                   "assets/images/onb2.jpg",
                                    //                   fit: BoxFit.fill,),
                                    //               )
                                    //             ],
                                    //           ),
                                    //         ),
                                    //       ),
                                    //     ),
                                    //   ],
                                    // ),

                                ),
                              ],
                            ),
                          ):Container()
                        ),
                        // Obx(()=>controller.categryModel.value.data!=null?
                        //    Padding(
                        //     padding: const EdgeInsets.all(4.0),
                        //     child: Container(
                        //       width: MediaQuery.of(context).size.width,
                        //       height: 70.h,
                        //       child: ListView.builder(
                        //           itemCount:controller.categryModel.value.data!.length,
                        //           shrinkWrap: true,
                        //           scrollDirection: Axis.horizontal,
                        //           itemBuilder: (context, index) {
                        //             final data2=controller.categryModel.value.data![index];
                        //             return Padding(
                        //               padding: EdgeInsets.only(right: 20.w),
                        //               child: InkWell(
                        //                 onTap: (){
                        //                 Get.to(()=>FadeInUp(
                        //                     delay: Duration(microseconds:480),
                        //                     child: BookingPage()));
                        //                 },
                        //                 child: Container(
                        //                   padding: EdgeInsets.all(5.w),
                        //                   height: 60.h,
                        //                   width: 60.w,
                        //                   decoration: BoxDecoration(
                        //                       // color: Color(0xffffaaaa),
                        //                       shape: BoxShape.circle,
                        //                       border: Border.all(color: Color(0xff4f5252)),
                        //                     // image: DecorationImage(
                        //                     //   image: NetworkImage(BASE_URL+data2.image.toString())
                        //                     // )
                        //                   ),
                        //                   child: Center(child: Text(data2.title.toString(),style: bodyboldStyle.copyWith(fontSize: 12.sp,),textAlign: TextAlign.center,)),
                        //                 ),
                        //               ),
                        //             );
                        //           }),
                        //     ),
                        //   ):Container()
                        // ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text("Nearest Mechanic Shop",
                            style: robotoMedium.copyWith(
                                fontSize: 20.r, color: const Color(0xff049486)),),
                        ),
                        Container(
                          height: 60.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          child:Padding(
                              padding:  EdgeInsets.all(8.w),
                              child: TextFormField(
                                controller: controller.searchController,
                                textInputAction: TextInputAction.search,
                                onChanged: (value) {
                                  setState(() {
                                    searchKey = value;
                                    controller.getShopListSearchNetworkApi(value);
                                  });
                                  },
                                onFieldSubmitted: (value){
                                  controller.getShopListSearchNetworkApi(value);
                                },
                                style: smallTextStyle.copyWith(color: Colors.black),
                                decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(color: Colors.black,),
                                        borderRadius: BorderRadius.circular(25.r)
                                    ),
                                    enabledBorder:OutlineInputBorder(
                                        borderSide: const BorderSide(color: Colors.black,),
                                        borderRadius: BorderRadius.circular(25.r)
                                    ),
                                    labelStyle: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 15.sp,
                                    ),
                                    hintText: "Search...",
                                    enabled: true,
                                    hintStyle: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 15.sp,
                                    ),
                                    contentPadding: EdgeInsets.only(left: 12.r),
                                    suffixIcon: controller.searchController.text.isNotEmpty?
                                    GestureDetector(
                                        onTap: ()
                                        {
                                          setState(() {
                                            controller.searchController.clear();
                                            controller.getShopListSearchNetworkApi("");
                                          });
                                        },
                                        child: Icon(
                                          Icons.clear,
                                          size: 20.sp,color: Colors.teal,
                                        )):null,
                                    border: const OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.grey),
                                        borderRadius: BorderRadius.all(Radius.circular(5.0)))),
                              )),
                        ),
                        Obx(() =>
                        controller.shoplistModel.value.message != "Records is not found." ?
                          Padding(
                            padding:  EdgeInsets.all(8.r),
                            child: Column(
                              children: [
                                ListView.builder(
                                    physics: const BouncingScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: controller.shoplistModel.value.data.length,
                                    itemBuilder:
                                        (context, index) {
                                      final data2 = controller.shoplistModel.value.data[index];
                                      double km = double.parse(data2.distance.toString()) / 1000;
                                      launchCaller() async {
                                        final url = "tel:${data2.mobile}";
                                        if (await canLaunch(url)) {
                                          await launch(url);
                                        } else {
                                          throw 'Could not launch $url';
                                        }
                                      }
                                      return Column(
                                        children: [
                                          InkWell(onTap: () {
                                            controller.shop_id.value = data2.id.toString();
                                            Get.to(() =>ShopListDetails(data2.id.toString()));
                                          },
                                            child: Container(
                                              margin: EdgeInsets.only(bottom: 10.h),
                                              padding: EdgeInsets.all(8.r),
                                              width: Get.width,
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(15.r),
                                                  border: Border.all(width: 0.8.w, color: Colors.grey.shade400.withOpacity(0.8))
                                                // color: Color(0xffffaaaa),
                                              ),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: [
                                                      Container(
                                                        height: 50.r,
                                                        width: 50.r,
                                                        decoration: BoxDecoration(
                                                          shape: BoxShape.circle,
                                                          border: Border.all(color: Colors.black),
                                                        ),
                                                        child: ClipRRect(
                                                          borderRadius: BorderRadius.circular(50.r),
                                                          child: CachedNetworkImage(
                                                            fit: BoxFit.cover,
                                                            imageUrl: BASE_URL + data2.profile.toString(),
                                                            placeholder: (context,
                                                                url) =>
                                                                const Center(
                                                                    child: CircularProgressIndicator(
                                                                        color: Colors
                                                                            .black)),
                                                            errorWidget: (context,
                                                                url, error) =>
                                                                Icon(Icons.error,
                                                                  color: Colors
                                                                      .black,
                                                                  size: 30.sp,),
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Padding(
                                                          padding: EdgeInsets.only(left: 3.w),
                                                          child: Column(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            children: [
                                                              Padding(
                                                                padding:  EdgeInsets.only(left: 4.w),
                                                                child: Text(
                                                                  data2.shopName==""?"Unknown":data2.shopName??"Unknown",
                                                                  style: robotoMedium
                                                                      .copyWith(
                                                                      fontSize: 17.sp,
                                                                      color: const Color(0xff049486)),),
                                                              ),
                                                              Padding(
                                                                padding:  EdgeInsets.only(left: 4.w),
                                                                child: Row(
                                                                  children: [
                                                                    Text("Shop Mechanic No :    ",style: TextStyle(fontSize: 14.r,color: Colors.black,fontWeight: FontWeight.bold),),
                                                                    InkWell(onTap:launchCaller,child: Text("+91${data2.mobile}",style: TextStyle(fontSize: 14.r,color: Colors.blue,fontWeight: FontWeight.bold,decoration: TextDecoration.underline),)),
                                                                  ],
                                                                ),
                                                              ),
                                                              SizedBox(height: 10.r,),
                                                              Padding(
                                                                padding:  EdgeInsets.only(left: 4.w),
                                                                child: Row(
                                                                  children: [
                                                                    Text("Service Vehicle :  ",style: TextStyle(fontSize: 14.r,color: Colors.black,fontWeight: FontWeight.bold),),
                                                                    Expanded(child: Text(data2.selectVehicle.toString(),style: robotoMedium.copyWith(fontSize: 14.r,overflow: TextOverflow.ellipsis),)),
                                                                  ],
                                                                ),
                                                              ),
                                                              Row(
                                                                children: [
                                                                  // RatingBar.builder(
                                                                  //   initialRating: 1,
                                                                  //   minRating: 5,
                                                                  //   direction: Axis.horizontal,
                                                                  //   itemSize: 15,
                                                                  //   tapOnlyMode: true,
                                                                  //   unratedColor: Colors.grey,
                                                                  //   glowColor: Colors.cyan,
                                                                  //   allowHalfRating: false,
                                                                  //   itemCount:5,
                                                                  //   itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                                                                  //   itemBuilder: (context, _) => Icon(
                                                                  //     Icons.star,
                                                                  //     color: Colors.amber,
                                                                  //   ), onRatingUpdate: (int) {
                                                                  // },
                                                                  // ),
                                                                  // Text("  3.1",style: bodyboldStyle,),
                                                                  InkWell(
                                                                    onTap:(){
                                                                      controller.shop_id.value=data2.id.toString();
                                                                      print( "aasadsa ${controller.shop_id.value}");
                                                                      Get.to(()=>RateUsApp(data2.id.toString()));
                                                                    },
                                                                    child: Padding(
                                                                      padding:  EdgeInsets
                                                                          .only(left: 0,right: 8.w,top: 4.h,bottom: 4.h),
                                                                      child: Row(
                                                                        children: [
                                                                          Icon(Icons
                                                                              .star_rate_outlined,
                                                                            color: const Color(
                                                                                0xff049486),
                                                                            size: 14.sp
                                                                                .sp,),
                                                                          Text(data2.rating.toString(),
                                                                            style: TextStyle(
                                                                                color: const Color(
                                                                                    0xff049486),
                                                                                fontSize: 12
                                                                                    .sp,
                                                                                fontWeight: FontWeight
                                                                                    .bold),)
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                   Text(data2.noRating.toString()+" reviews",style: smallTextStyle,),

                                                                  // Card(
                                                                  //   color: Colors.teal,
                                                                  //   shape: RoundedRectangleBorder(
                                                                  //     borderRadius: BorderRadius.circular(25.r)
                                                                  //   ),
                                                                  //   child: Container(
                                                                  //     padding: EdgeInsets.only(left: 20.w,right: 20.w),
                                                                  //     height: 30.h,
                                                                  //     child: Center(child: Text("Book",style:TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)),
                                                                  //   ),
                                                                  // )
                                                                ],
                                                              ),
                                                              SizedBox(height: 5.h,),
                                                              Padding(
                                                                padding:  EdgeInsets.only(left: 4.w),
                                                                child: Row(
                                                                  // crossAxisAlignment: CrossAxisAlignment.center,
                                                                  // mainAxisAlignment: MainAxisAlignment.center,
                                                                  children: [
                                                                    Text(km.toStringAsFixed(2),style: smallTextStyle,),
                                                                     Text(" Km",style: smallTextStyle,),
                                                                    InkWell(onTap: () {
                                                                      print(data2.latitude.toString()+"oihuytfyrt");
                                                                      _controller.lat.value = double.parse(data2.latitude.toString());
                                                                      _controller.long.value = double.parse(data2.longitude.toString());
                                                                      print(_controller.lat.value);
                                                                      print(_controller.long.value);
                                                                      print("_controller.long.value");
                                                                      if (_controller.lat.value !=
                                                                          0.0 ||
                                                                          _controller.long.value !=
                                                                              0.0) {
                                                                        Get.to(() => const MapScreen());
                                                                      }
                                                                    },
                                                                        child: Text(
                                                                          " Direction",
                                                                          style: bodyboldStyle
                                                                              .copyWith(
                                                                              color: Colors
                                                                                  .blue),textAlign: TextAlign.center,)),
                                                                  ],
                                                                ),
                                                              ),
                                                              const Divider()
                                                            ],
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  Padding(
                                                      padding:  EdgeInsets.only(
                                                          left: 4.w,
                                                          right: 4.w,
                                                          bottom: 5.h),
                                                      child: data2.description != null
                                                          ? Text(
                                                        data2.description.toString(),
                                                        style: smallTextStyle
                                                            .copyWith(
                                                            fontSize: 10.sp),)
                                                          : Container()
                                                  )
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      );
                                    }),
                                Obx(() => controller.isLoadingPage.value
                                    ? const LoadingWidget()
                                    : Container(),
                                ),
                              ],
                            ),
                          ) :
                          Container(
                            padding: EdgeInsets.only(top: 50.r),
                            alignment: Alignment.center,
                            child: const DataNotFound(),
                          )
                        ),
                      ],
                    ),
                  )
                ],
              ),
        ),
    ),
      )
    );
  }
  }

