import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:usermechanic/Dashbord/Controller/dashbordcontroller.dart';
import 'package:usermechanic/Dashbord/View/Profile/TranscationDeatils.dart';
import 'package:usermechanic/Dashbord/View/Profile/TranscationDetail.dart';

import '../../../Widget/styles.dart';
class Transaction extends StatefulWidget {
  const Transaction({Key? key}) : super(key: key);
  @override
  State<Transaction> createState() => _TransactionState();
}
class _TransactionState extends State<Transaction> {
  final HomePageController controller=Get.put(HomePageController());
  var SearchKey="";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.getTransctionHistoryApi(SearchKey);
  }
  Widget build(BuildContext context) {
    double height, width;
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    void _selectOption(option) {
      print('Selected: $option');
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text("Transaction History"),
        leadingWidth: 30.w,
      ),
      body:
      RefreshIndicator(
            color: const Color(0xff050505),
            onRefresh: (){
              return Future.delayed(Duration.zero, () {
                controller.getTransctionHistoryApi(SearchKey);
              });
            },
            child: Obx(()=>controller.transcationModel.value.data!=null?
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 50.h,
                        width: Get.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: SizedBox(
                          height: 50.h,
                          child: Padding(
                              padding: EdgeInsets.only(top: 8.0.h),
                              child: TextFormField(
                                mouseCursor: MouseCursor.defer,
                                controller: controller.bookingSearch,
                                textInputAction: TextInputAction.search,
                                onChanged: (value) {
                                  SearchKey = value;
                                  controller.getTransctionHistoryApi(value);
                                },
                                onFieldSubmitted: (value) {
                                  SearchKey = value;
                                  controller.getTransctionHistoryApi(value);
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
                                    labelStyle: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                    ),
                                    hintText: "Search...",
                                    enabled: true,
                                    hintStyle:  TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14.r,
                                    ),
                                    suffixIcon: GestureDetector(
                                        onTap: () {
                                          controller.bookingSearch.clear();
                                          controller.getTransctionHistoryApi("");
                                        },
                                        child: const Icon(
                                          Icons.clear,
                                          size: 25,
                                          color: Colors.teal,
                                        )),
                                    contentPadding: EdgeInsets.symmetric(horizontal: 12.0.w),
                                    border: const OutlineInputBorder(
                                        borderSide:
                                        BorderSide(color: Colors.grey),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5.0)))),
                              )),
                        ),
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: ListView.builder(
                            itemCount: controller.transcationModel.value.data!.length,
                            physics: ScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder:
                            (context,index)
                            {
                              final data=controller.transcationModel.value.data![index];
                              return InkWell(
                                onTap: ()async{
                                  print("object ${controller.transcationModel.value.data![index].bookingNo}");
                                  bool status = await controller.getTransctionDetails(controller.transcationModel.value.data![index].tblUsersBookingId.toString());
                                  if(status==true){
                                   Get.to(()=>TranscationDeatil(data.tblUsersBookingId.toString()));

                                  }
                                },
                                 child: Padding(
                                  padding:  EdgeInsets.all(5.w),
                                  child: Container(
                                    padding: EdgeInsets.all(4.r),
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.teal),
                                        borderRadius: BorderRadius.circular(5.0)),
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 30.r,
                                          width: Get.width,
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.start,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Column(
                                                mainAxisAlignment:
                                                MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Container(
                                                        width:Get.width/1.06,
                                                        child: Row(
                                                          children: [
                                                            Text(
                                                              "Booking No     : ",
                                                              style: TextStyle(
                                                                  fontSize: 14.sp,color: Colors.teal),
                                                            ),
                                                            SizedBox(width: 6.0.w),
                                                            Text(data.bookingNo.toString(),
                                                              style: TextStyle(
                                                                  fontSize:14.r,
                                                                  fontWeight: FontWeight.bold,
                                                                  color:Colors.black
                                                                      .withAlpha(
                                                                      150)),
                                                            ),
                                                            Spacer(),
                                                            Icon(Icons.date_range_sharp,size: 14.sp,),
                                                            Text("  "+data.addDate.toString(),
                                                              style: TextStyle(
                                                                  fontSize:14.r,
                                                                  color:Colors.black
                                                                      .withAlpha(
                                                                      150)),
                                                            ),
                                                          ],
                                                        ),
                                                      ),

                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: Get.width,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(5),
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    'Shop Name     : ',
                                                    style: TextStyle(
                                                        fontSize: 14.sp,color: Colors.teal
                                                            ),
                                                  ),
                                                  SizedBox(width: 5.0.w),
                                                  Expanded(
                                                      child: Text(
                                                        data.shopName.toString(),
                                                        style: TextStyle(
                                                            fontSize: 14.sp,
                                                            color: Colors.black
                                                                .withAlpha(150)),
                                                        maxLines: 3,
                                                      )),
                                                ],
                                              ),
                                              SizedBox(height: 2.0.h),
                                              Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    width: Get.width/1.06,
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                          'Service Type   :   ',
                                                          style: TextStyle(
                                                              fontSize: 14.sp,color: Colors.teal
                                                                  ),
                                                        ),
                                                        Text(data.serviceType.toString(),
                                                          style: TextStyle(
                                                              fontSize: 14.sp
                                                          ),
                                                        ),Spacer(),
                                                        Text(
                                                          'Status  :   ',
                                                          style: TextStyle(
                                                              fontSize: 14.sp,color: Colors.teal
                                                          ),
                                                        ),
                                                        Text(
                                                          data.status=="1"?"Succes":data.status=="0"?"Failled":"",
                                                          style: TextStyle(
                                                              fontSize: 14.sp,color: data.status=="1"?Colors.green:Colors.red
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 2.0.h),
                                              Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    width: Get.width/1.06,
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                          'TXN-Id             :   ',
                                                          style: TextStyle(
                                                              fontSize: 14.sp,color: Colors.teal
                                                          ),
                                                        ),
                                                        Text(data.transactionId.toString(),overflow: TextOverflow.ellipsis,
                                                          style: TextStyle(
                                                              fontSize: 14.sp
                                                          ),
                                                        ),Spacer(),
                                                        Text(
                                                          'Rs : ',
                                                          style: TextStyle(
                                                              fontSize: 17.sp,color: Colors.teal
                                                          ),
                                                        ),
                                                        Text(data.amount.toString(),
                                                          style: TextStyle(
                                                              fontSize: 17.sp,color: Colors.green
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 2.0.h),
                                              Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    width: Get.width/1.06,
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                          'Remark            :   ',
                                                          style: TextStyle(
                                                              fontSize: 14.sp,color: Colors.teal
                                                          ),
                                                        ),
                                                        Text(data.remark.toString(),overflow: TextOverflow.ellipsis,
                                                          style: TextStyle(
                                                              fontSize: 14.sp
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 8.0.h),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }),
                      ),
                    )
                  ],
                ) : Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(top: 150.0.h),
              child: const Image(
                  image: AssetImage("assets/images/norecord.png")),
            ),
            ),
          ),
    );
  }
}
