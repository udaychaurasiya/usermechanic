import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:usermechanic/Dashbord/Controller/dashbordcontroller.dart';
import 'package:usermechanic/Dashbord/View/HomePage/FullService.dart';
import 'package:usermechanic/Dashbord/View/ShopListDeatils.dart';
import 'package:usermechanic/auth/logincontroller.dart';

import '../../../AppConstant/APIConstant.dart';
import '../../../Widget/LodingWidget.dart';
import '../../../Widget/TextStyle.dart';
import '../../../Widget/styles.dart';
import 'MapView.dart';
class OnroadService extends StatefulWidget {
  const OnroadService({Key? key}) : super(key: key);

  @override
  State<OnroadService> createState() => _OnroadServiceState();
}

class _OnroadServiceState extends State<OnroadService> {
  HomePageController controller=Get.put(HomePageController());
  LoginController _controller=Get.put(LoginController());
  var searchKey = "";
  @override
  void initState() {
    // TODO: implement initState
    controller.getOnRoadServiceApi(searchKey);
    super.initState();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal.shade50,
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text("Onroad Service"),
      ),
      body: RefreshIndicator(
        color: const Color(0xff049486),
        onRefresh: (){
          return Future.delayed(Duration.zero, () {
            controller.getOnRoadServiceApi(searchKey);
          });
        },
        child: SingleChildScrollView(
          child: FadeInUp(
            delay: const Duration(microseconds: 450),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 60.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child:
                      Padding(
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
                                    borderRadius: BorderRadius.circular(30.r)
                                ),
                                enabledBorder:OutlineInputBorder(
                                    borderSide: const BorderSide(color: Colors.black,),
                                    borderRadius: BorderRadius.circular(30.r)
                                ),
                                labelStyle: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14.sp,
                                ),
                                hintText: "Search...",
                                enabled: true,
                                hintStyle: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14.sp,
                                ),
                                suffixIcon:controller.searchController.text.isNotEmpty? GestureDetector(
                                    onTap: ()
                                    {
                                      setState(() {
                                        controller.searchController.clear();
                                        controller.getOnRoadServiceApi("");
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
                    controller.shoplistModel.value.data.isNotEmpty ?
                    Padding(
                      padding:  EdgeInsets.all(8.w),
                      child: Column(
                        children: [
                          ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: controller.shoplistModel.value.data.length,
                              itemBuilder:
                                  (context, index) {
                                final data2 = controller.shoplistModel.value.data[index];
                                double km = double.parse(
                                    data2.distance.toString()) / 1000;
                                launchCaller() async {
                                  final url = "tel:"+data2.mobile.toString();
                                  if (await canLaunch(url)) {
                                    await launch(url);
                                  } else {
                                    throw 'Could not launch $url';
                                  }
                                }
                                return Column(
                                  children: [
                                    Card(
                                      elevation: 0,
                                      child: Container(
                                        padding: EdgeInsets.all(8),
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              height:100.h,
                                              width: 100.w,
                                              decoration: BoxDecoration(
                                                border:Border.all(color: Colors.teal)
                                              ),
                                              child: CachedNetworkImage(
                                                fit: BoxFit.fill,
                                                imageUrl: BASE_URL + data2.profile.toString(),
                                                height: 76.h,
                                                width: 76.w,
                                                placeholder: (context, url) =>
                                                const Center(
                                                child: CircularProgressIndicator()),
                                                errorWidget: (context, url, error) =>
                                                const Icon(Icons.error),
                                              ),
                                            ),
                                            Container(
                                              padding: EdgeInsets.only(left: 5.w),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                Text(data2.shopName.toString(),style: TextStyle(fontSize: 17.sp,fontWeight: FontWeight.bold),),
                                                SizedBox(height: 8.r,),
                                                  Row(
                                                    children: [
                                                      Text("Service Vehicle :    ",style: TextStyle(fontSize: 14.r,color: Colors.black,fontWeight: FontWeight.bold),),
                                                      Text("Two Wheeler",style: TextStyle(fontSize: 14.r,fontWeight: FontWeight.bold,),),
                                                    ],
                                                  ),
                                                  SizedBox(height: 8.r,),
                                                  Container(
                                                    width:Get.width/1.8,
                                                    child: Row(
                                                      children: [
                                                        Text(km.toStringAsFixed(2),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13.sp,color: Colors.teal)),
                                                         Text(" Km",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13.sp,color: Colors.teal),),
                                                          Spacer(),
                                                          InkWell(onTap: () {
                                                          _controller.lat.value =
                                                              double.parse(data2.latitude.toString());
                                                          _controller.long.value =
                                                              double.parse(data2.longitude.toString());
                                                          if (_controller.lat.value != 0.0 || _controller.long.value != 0.0) {
                                                            Get.to(() =>
                                                            const MapScreen());
                                                            }
                                                           },
                                                            child:Container(
                                                              height: 25.h,
                                                              width: 125.w,
                                                              decoration: BoxDecoration(
                                                                color: Colors.blue,
                                                                borderRadius: BorderRadius.circular(15.r),

                                                              ),
                                                              child: Row(
                                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                children: [
                                                                  Icon(Icons.directions,color: Colors.white,),
                                                                  Text("Directions",style: TextStyle(
                                                                    color: Colors.white
                                                                  ),)
                                                                ],
                                                              ),
                                                            )),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    width: Get.width/1.8,
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      children: [
                                                        InkWell(
                                                          onTap:(){
                                                            controller.shop_id.value = data2.id.toString();
                                                            Get.to(()=>ShopListDeatils(data2.id.toString()));
                                                          },
                                                          child: Card(
                                                            color: Colors.teal,
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius: BorderRadius.circular(25.r)
                                                            ),
                                                            child: Container(
                                                               height: 30.h,
                                                               width: 90.w,
                                                             child: Center(child: Text("Details",style: TextStyle(fontWeight:FontWeight.bold,color:Colors.white,fontSize: 13.sp))),
                                                            ),
                                                          ),
                                                        ),
                                                        Spacer(),
                                                        InkWell(
                                                          onTap:launchCaller,
                                                          child: Card(
                                                            color: Colors.teal,
                                                            shape: RoundedRectangleBorder(
                                                              borderRadius: BorderRadius.circular(20.r)
                                                            ),
                                                            child: Container(
                                                              height: 30.h,
                                                              width: 90.w,
                                                              child: Center(
                                                                child: Row(
                                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                  children: [
                                                                    Icon(Icons.call,color: Colors.white,size: 23.sp,),
                                                                    Text("Call Now",style: TextStyle(fontWeight:FontWeight.bold,color:Colors.white,fontSize: 13.sp),)
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                ],

                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                );
                              }),
                        ],
                      ),
                    ) : Container()
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
