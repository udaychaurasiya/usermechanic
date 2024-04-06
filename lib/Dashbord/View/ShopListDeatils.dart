import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:usermechanic/AppConstant/APIConstant.dart';
import 'package:usermechanic/Dashbord/Controller/dashbordcontroller.dart';
import 'package:usermechanic/Dashbord/View/HomePage/MapView.dart';
import 'package:usermechanic/Dashbord/View/HomePage/Rating.dart';
import 'package:usermechanic/Dashbord/View/MechanicBook.dart';
import 'package:usermechanic/Widget/PhotoViews.dart';
import 'package:usermechanic/Widget/styles.dart';

import '../../Widget/coustom_Dailog.dart';
class ShopListDeatils extends StatefulWidget {
  final String id;
  const ShopListDeatils( this.id,{Key? key}) : super(key: key);

  @override
  State<ShopListDeatils> createState() => _ShopListDeatilsState();
}

class _ShopListDeatilsState extends State<ShopListDeatils> {
  final HomePageController controller=Get.put(HomePageController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     controller.getShopDetailsNetworkApi(widget.id);
  }
  Widget build(BuildContext context) {
    return Scaffold(
      /*bottomSheet: Container(
        child: Obx(()=>controller.shopDetailsModel.value.data!=null?
           Padding(
            padding: const EdgeInsets.only(bottom: 28.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: (){
                    controller.ShopDetails=controller.shopDetailsModel.value.data;
                    Get.to(()=>BookingShop(controller.shopDetailsModel.value.data!.id.toString()));
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.r)
                    ),
                    color: Colors.teal,
                    child: Container(
                      width: 150.w,
                      // padding: EdgeInsets.only(left: 15.w,right: 15.w),
                      height:40.h,
                      child: Center(child: Text("Book Service",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 14.sp),textAlign: TextAlign.center,)),
                    ),
                  ),
                ),
              ],
            ),
          ):Container()
        ),
      ),*/
        appBar: AppBar(
          elevation: 0.0,
        backgroundColor: Color(0xff049486),
        title: Text("Details"),
        leadingWidth: 20.w,
        ),
        body:Obx(()=>controller.shopDetailsModel.value.data!=null
          ?
        Column(
          children: [
            ListView.builder(
                shrinkWrap: true,
                physics: ScrollPhysics(),
                itemCount: 1,
                itemBuilder:
                    (context,index){
                  double km = double.parse(
                      controller.shopDetailsModel.value.data!.distance.toString()) / 1000;
                  launchCaller() async {
                    final url = "tel:"+controller.shopDetailsModel.value.data!.mobile.toString();
                    if (await canLaunch(url)) {
                      await launch(url);
                    } else {
                      throw 'Could not launch $url';
                    }
                  }
                  return Padding(
                    padding:  EdgeInsets.only(left: 8.w,right: 8.w,top: 8.h),
                    child: Column(
                      children: [
                        Container(
                          height: 250.r,
                          child: Stack(
                            children: [
                              Container(
                                  height: 200.r,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20.r)
                                  ),
                                  child:  CarouselSlider.builder(
                                    itemCount:1,
                                    options: CarouselOptions(
                                      aspectRatio: 1.0,
                                      enlargeCenterPage: true,
                                      viewportFraction: 1,
                                      autoPlay: true,
                                      pageSnapping: true,
                                      autoPlayAnimationDuration: Duration(milliseconds: 800),
                                      autoPlayInterval: Duration(seconds: 3),
                                      autoPlayCurve: Curves.fastOutSlowIn,
                                    ),
                                    itemBuilder: (ctx, index, realIdx) {
                                      return ClipRRect(
                                        child: Container(
                                          height: 230.r,
                                          width: MediaQuery.of(context).size.width,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10.r),
                                              image: DecorationImage(
                                                image:NetworkImage(
                                                  "https://cdni.autocarindia.com/Utils/ImageResizer.ashx?n=https://cdni.autocarindia.com/ExtraImages/20200204073706_MT15.jpg",
                                                ),fit:BoxFit.fill,
                                              )
                                          ),
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Container(
                                                    height: 20.h,
                                                    width: 100.w,
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(20.r),
                                                      color: Colors.black,
                                                    ),
                                                    child:Text("uday")),
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  )
                              ),
                              Positioned(
                                top: 170.h,
                                left: 20.w,
                                child: Row(
                                  children: [
                                    InkWell(onTap:(){
                                      showAnimatedDialog1(
                                          context,
                                          Center(
                                            child: Stack(
                                                children:[
                                                  Positioned(
                                                      top: 10.h,
                                                      left: 20.w,
                                                      child: TextButton(onPressed: (){}, child: Icon(Icons.clear,color: Colors.white,))),
                                                  Container(
                                                    width: 320.w,
                                                    height: 250.h,
                                                    decoration: BoxDecoration(
                                                      color: Theme.of(context).cardColor,
                                                      border: Border.all(),
                                                      borderRadius: BorderRadius.circular(
                                                          8),),
                                                    child: PhotoView(
                                                      imageProvider:NetworkImage(BASE_URL+controller.shopDetailsModel.value.data!.profile.toString()) ,
                                                    ),
                                                  ),]
                                            ),
                                          ),
                                          dismissible: true);
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(18.w),
                                        height: 70.h,
                                        width: 70.w,
                                        decoration: BoxDecoration(
                                            color:Colors.black,
                                            shape: BoxShape.circle,
                                            border: Border.all(color: Colors.black,width: 3),
                                            image: DecorationImage(
                                                image: NetworkImage(BASE_URL+controller.shopDetailsModel.value.data!.profile.toString()),fit: BoxFit.cover
                                            )
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:  EdgeInsets.only(top: 20.h,),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          SizedBox(height: 15.h,),
                                          Text(" "+controller.shopDetailsModel.value.data!.shopName.toString(),style:bodyText1Style.copyWith(fontSize: 18.sp,color: Color(
                                              0xff0e877f)),maxLines: 2,),
                                          SizedBox(height: 5.h,),
                                          Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              InkWell(
                                                onTap: (){
                                                  controller.shop_id.value=controller.shopDetailsModel.value.data!.id.toString();
                                                  Get.to(()=>RateUsApp(controller.shopDetailsModel.value.data!.id.toString()));
                                                },
                                                child: Row(
                                                  children: [
                                                    Icon(Icons.star_rate_outlined,color: Color(0xff049486),size: 14.sp,),
                                                    Text(controller.shopDetailsModel.value.data!.rating.toString(),style:TextStyle(color: Color(0xff049486),fontSize: 12.sp,fontWeight: FontWeight.bold),),
                                                  ],
                                                ),
                                              ),
                                              Text("   "+controller.shopDetailsModel.value.data!.noRating.toString()+" Review",style: TextStyle(color: Color(
                                                  0xff000000),fontWeight: FontWeight.bold,fontSize: 12.sp),),
                                            ],
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
                        Padding(
                          padding:  EdgeInsets.only(left: 12.0.w,),
                          child: Container(
                            width: MediaQuery
                                .of(context)
                                .size
                                .width,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: Get.width/1.1,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text("Address:-",style: TextStyle(color: Color(0xff1e7c69),fontWeight: FontWeight.bold,fontSize: 14.sp),),
                                              Spacer(),
                                              InkWell(onTap:(){
                                                Navigator.push(context, MaterialPageRoute(builder: (context)=> const MapScreen()));
                                              },child: Container(
                                                  color: Color(0xffcdeae6),
                                                  padding: EdgeInsets.only(left: 5.w,right: 5.w),
                                                  height: 25.h,
                                                  child: Center(child: Row(
                                                    children: [
                                                      Text(" Direction ",style: bodyboldStyle.copyWith(color: Color(0xff049486)),),
                                                      Icon(Icons.directions,color: Color(0xff049486),)
                                                    ],
                                                  )))),
                                            ],
                                          ),
                                          Text(controller.shopDetailsModel.value.data!.address.toString(),style: TextStyle(fontSize: 14.sp),),
                                          // Row(
                                          //   children: [
                                          //     // InkWell(onTap:(){
                                          //     //   Navigator.push(context, MaterialPageRoute(builder: (context)=> const MapScreen()));
                                          //     // },child: Container(
                                          //     //   color: Color(0xffcdeae6),
                                          //     //   padding: EdgeInsets.only(left: 5.w,right: 5.w),
                                          //     //     height: 25.h,
                                          //     //     child: Center(child: Row(
                                          //     //       children: [
                                          //     //         Text(" Direction ",style: bodyboldStyle.copyWith(color: Color(0xff049486)),),
                                          //     //         Icon(Icons.directions,color: Color(0xff049486),)
                                          //     //       ],
                                          //     //     )))),
                                          //     // Spacer(),
                                          //     // Card(
                                          //     //   color: Color(0xffcdeae6),
                                          //     //   elevation: 0,
                                          //     //   child: Padding(
                                          //     //     padding: const EdgeInsets.all(8.0),
                                          //     //     child: Row(
                                          //     //       children: [
                                          //     //         Icon(Icons.star_rate_outlined,color: Color(0xff049486),size: 14.sp,),
                                          //     //         Text(" 3.8",style:TextStyle(color: Color(0xff049486),fontSize: 12.sp,fontWeight: FontWeight.bold),)
                                          //     //       ],
                                          //     //     ),
                                          //     //   ),
                                          //     // ),
                                          //     // Text("Review",style:TextStyle(color: Color(0xff049486),fontSize: 12.sp,fontWeight: FontWeight.bold),)
                                          //     Container(
                                          //     width: Get.width/2,
                                          //       child: Column(
                                          //         crossAxisAlignment: CrossAxisAlignment.start,
                                          //         children: [
                                          //           Text("Address:-",style: TextStyle(color: Color(0xff1e7c69),fontWeight: FontWeight.bold),),
                                          //           Text(controller.shopDetailsModel.value.data![0].address.toString(),style: smallTextStyle.copyWith(fontSize: 14.sp,color: Color(
                                          //               0xff090808)),maxLines: null,),
                                          //         ],
                                          //       ),
                                          //     ),
                                          //     Spacer(),
                                          //     Container(
                                          //       child: Column(
                                          //         crossAxisAlignment: CrossAxisAlignment.end,
                                          //         mainAxisAlignment: MainAxisAlignment.start,
                                          //         children: [
                                          //           Card(
                                          //             color: Color(0xffcdeae6),
                                          //             elevation: 0,
                                          //             child: Padding(
                                          //               padding: const EdgeInsets.all(8.0),
                                          //               child: Row(
                                          //                 children: [
                                          //                   Icon(Icons.star_rate_outlined,color: Color(0xff049486),size: 14.sp,),
                                          //                   Text(" 3.8",style:TextStyle(color: Color(0xff049486),fontSize: 12.sp,fontWeight: FontWeight.bold),),
                                          //                 ],
                                          //               ),
                                          //             ),
                                          //           ),
                                          //           Text("13 Review",style: TextStyle(color: Color(0xff049486),fontWeight: FontWeight.bold,fontSize: 12.sp),),
                                          //           SizedBox(height: 5.h,),
                                          //           InkWell(onTap:(){
                                          //             Navigator.push(context, MaterialPageRoute(builder: (context)=> const MapScreen()));
                                          //           },child: Container(
                                          //             decoration: BoxDecoration(
                                          //               borderRadius: BorderRadius.circular(5.r),
                                          //               color: Color(0xffcdeae6),
                                          //             ),
                                          //             padding: EdgeInsets.only(left: 5.w,right: 5.w),
                                          //               height: 25.h,
                                          //               child: Center(child: Row(
                                          //                 children: [
                                          //                   Text(" Direction ",style: bodyboldStyle.copyWith(color: Color(0xff049486)),),
                                          //                   Icon(Icons.directions,color: Color(0xff049486),)
                                          //                 ],
                                          //               )))),
                                          //         ],
                                          //       ),
                                          //     ),
                                          //   ],
                                          // ),
                                          SizedBox(height: 5.h,),
                                          Row(
                                            children: [
                                              Container(
                                                width:MediaQuery.of(context).size.width/2.2,
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Text("Distance:- ",style: smallTextStyle.copyWith(fontSize: 14.sp,fontWeight: FontWeight.bold,color: Color(0xff1e7c69))),
                                                        Text(km.toStringAsFixed(2),maxLines:1,style: smallTextStyle.copyWith(fontSize: 14.sp,color: Color(
                                                            0xfc090100)),),
                                                        Text(" Km"),
                                                      ],
                                                    ),
                                                    SizedBox(height:5.h,),
                                                    Text("Timing:- ",style: smallTextStyle.copyWith(fontSize: 14.sp,fontWeight: FontWeight.bold,color: Color(0xff1e7c69))),
                                                    controller.shopDetailsModel.value.data!.storeTime!=null? Text(controller.shopDetailsModel.value.data!.storeTime.toString(),maxLines:1,style: smallTextStyle.copyWith(fontSize: 14.sp,color: Color(
                                                        0xfc090100)),):Text(""),
                                                    SizedBox(height: 5.h,),
                                                    Text("Note :-",style: smallTextStyle.copyWith(fontSize: 14.sp,fontWeight: FontWeight.bold,color: Color(0xff1e7c69)))
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                width:MediaQuery.of(context).size.width/2.2,
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Text("Shop:- ",style: smallTextStyle.copyWith(fontSize: 14.sp,fontWeight: FontWeight.bold,color: Color(0xff1e7c69))),
                                                        Text(controller.shopDetailsModel.value.data!.shopOpen=="1"?"Open":controller.shopDetailsModel.value.data!.shopOpen=="2"?"Close":"",maxLines:1,style: smallTextStyle.copyWith(fontSize: 14.sp,color: Color(
                                                            0xfc090100)),)
                                                      ],
                                                    ),
                                                    SizedBox(height:5.h,),
                                                    Row(
                                                      children: [
                                                        Text("Road Service:- ",style: smallTextStyle.copyWith(fontSize: 14.sp,fontWeight: FontWeight.bold,color: Color(0xff1e7c69))),
                                                        Text(controller.shopDetailsModel.value.data!.isOnRoadService=="0"?"No":controller.shopDetailsModel.value.data!.shopOpen=="1"?"Yes":"",maxLines:1,style: smallTextStyle.copyWith(fontSize: 14.sp,color: Color(
                                                            0xfc090100)),)
                                                      ],
                                                    ),
                                                    SizedBox(height:5.h,),
                                                    Text("Contact Number:- ",style: smallTextStyle.copyWith(fontSize: 14.sp,fontWeight: FontWeight.bold,color: Color(0xff1e7c69))),
                                                    InkWell(onTap:launchCaller,
                                                      child: Row(
                                                        children: [
                                                          Icon(Icons.call,size: 18.sp,color: Colors.teal,),
                                                          Text(" "+controller.shopDetailsModel.value.data!.mobile.toString(),maxLines:1,style: smallTextStyle.copyWith(fontSize: 14.sp,fontWeight:FontWeight.bold,color: Color(
                                                              0xfc090100)),),
                                                        ],
                                                      ),
                                                    ),

                                                  ],
                                                ),
                                              ),

                                            ],
                                          ),
                                          Text(controller.shopDetailsModel.value.data!.description.toString(),style: TextStyle(fontSize: 14.sp),)
                                        ],
                                      ),
                                    ),
                                    // Spacer(),
                                    // Container(
                                    //   width: 140.w,
                                    //   child: Column(
                                    //     crossAxisAlignment: CrossAxisAlignment.start,
                                    //     mainAxisAlignment: MainAxisAlignment.start,
                                    //     children: [
                                    //       Row(
                                    //         children: [
                                    //           Text("Apporox : 20km", style: smallTextStyle.copyWith(fontSize: 13.sp,color: Colors.black),),
                                    //         ],
                                    //       ),
                                    //       SizedBox(height: 5.w,),
                                    //       Row(
                                    //         children:[
                                    //           Container(
                                    //             padding: EdgeInsets.only(left: 3.w,right: 3),
                                    //               height:15.h,
                                    //               decoration: BoxDecoration(
                                    //                   color: Color(
                                    //                       0xff018c04)
                                    //               ),
                                    //             child: Center(child: Text("4.5",style: smallText1Style.copyWith(fontSize:9.sp,color: Colors.white),)),
                                    //           ),
                                    //           SizedBox(width: 2.w,),
                                    //
                                    //           Container(
                                    //             padding: EdgeInsets.only(left: 3.w,right: 3),
                                    //             height:15.h,
                                    //             decoration: BoxDecoration(
                                    //                 color: Color(0xff437644)
                                    //             ),
                                    //             child:Center(
                                    //               child: Text("Rating",style: smallText1Style.copyWith(fontSize:9.sp,color: Colors.white),),
                                    //             ),
                                    //           ),
                                    //           SizedBox(width: 2.w,),
                                    //           InkWell(
                                    //               onTap: (){
                                    //
                                    //               },
                                    //               child: Text(" Rating >",
                                    //                 style: smallTextStyle.copyWith(fontSize: 8.sp),))
                                    //         ],
                                    //       ),
                                    //       SizedBox(height: 5.h,),
                                    //       InkWell(
                                    //         onTap: (){
                                    //
                                    //         },
                                    //         child: Container(
                                    //           height: 20.h,
                                    //           width: 100.w,
                                    //           decoration: BoxDecoration(
                                    //             color: Color(0xff105648),
                                    //             borderRadius: BorderRadius.circular(5.r)
                                    //           ),
                                    //           child: Row(
                                    //             crossAxisAlignment: CrossAxisAlignment.center,
                                    //             mainAxisAlignment: MainAxisAlignment.center,
                                    //             children: [
                                    //               Text("Direction",style: smallTextStyle.copyWith(fontSize: 13.sp,color: Colors.white),),
                                    //               Icon(Icons.location_on,size: 17.sp,color: Colors.white,)
                                    //             ],
                                    //           ),
                                    //         ),
                                    //       )
                                    //     ],
                                    //   ),
                                    // )
                                  ],
                                ),
                                // SizedBox(height: 30.h,),
                                // Row(
                                //   crossAxisAlignment: CrossAxisAlignment.center,
                                //   mainAxisAlignment: MainAxisAlignment.center,
                                //   children: [
                                //     Card(
                                //       shape: RoundedRectangleBorder(
                                //         borderRadius: BorderRadius.circular(30.r)
                                //       ),
                                //       color: Colors.teal,
                                //       child: Container(
                                //         width: 150.w,
                                //         // padding: EdgeInsets.only(left: 15.w,right: 15.w),
                                //         height:40.h,
                                //         child: Center(child: Text("Book Service",style: TextStyle(),textAlign: TextAlign.center,)),
                                //       ),
                                //     ),
                                //   ],
                                // )

                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
          ],
        ):Container()
      )
    );
  }
}
