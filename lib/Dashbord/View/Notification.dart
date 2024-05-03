import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:usermechanic/Dashbord/Controller/dashbordcontroller.dart';
import 'package:usermechanic/Widget/styles.dart';
import 'package:usermechanic/utils/data_not_found.dart';

class AllNotifications extends StatefulWidget {
  const AllNotifications({Key? key}) : super(key: key);

  @override
  State<AllNotifications> createState() => _AllNotificationsState();
}

class _AllNotificationsState extends State<AllNotifications> {
 final HomePageController controller=Get.put(HomePageController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.getNotificationNetworkApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xff049486),
        leadingWidth: 30.w,
        title: const Text('Notifications'),
      ),
        body: RefreshIndicator(
          color: const Color(0xff049486),
          onRefresh: (){
            return Future.delayed(Duration.zero, () {
              controller.getNotificationNetworkApi();
            });
          },
          child: Obx(()=>controller.notificationModel.value.data!=null?
             FadeInUp(
              delay: const Duration(milliseconds: 450),
              child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20.h,),
                      const Padding(
                        padding: EdgeInsets.only(left: 18.0),
                        /* child: Text("24 April 2023",style: bodyText4Style.copyWith(color: Colors.blue,
                          fontWeight: FontWeight.bold,fontSize: 19.sp),)*/
                      ),
                      ListView.builder(
                          itemCount:controller.notificationModel.value.data!.length,
                          shrinkWrap: true,
                          physics: const ScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context,index){
                            final data=controller.notificationModel.value.data![index];
                            var dateTime=data.addDate!=null?data.addDate.toString():DateTime.now();
                            DateTime parsedDate = DateTime.parse(dateTime.toString());
                            String Date =DateFormat('dd-MMM-yyyy').format(parsedDate);

                            var dateTime2=data.addDate!=null?data.addDate.toString():DateTime.now();
                            DateTime parsedDate2 = DateTime.parse(dateTime2.toString());
                            String Date2 =DateFormat('HH:mm a').format(parsedDate2);
                            print(Date2);
                            return Container(
                              margin: const EdgeInsets.all(5),
                              width: Get.width,
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        height: 40.h,
                                        width: 40.w,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            width: 1.w,),
                                        ),
                                        child: const Icon(Icons.notification_add)
                                      ),
                                      SizedBox(width: 8.w,),
                                      SizedBox(
                                        width:MediaQuery.of(context).size.width/1.3,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  width:200.w,
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      // Text("Notification Massage",style: smallTextStyle.copyWith(fontSize: 14.sp,color: Colors.black),),
                                                      Text(data.mesage.toString(),style: smallTextStyle.copyWith(fontSize: 12.sp,color: const Color(
                                                          0xff484747)),),
                                                    ],
                                                  ),
                                                ),
                                                const Spacer(),
                                                Column(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.end,
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.only(top: 1.0),
                                                      child: Column(
                                                        children: [
                                                          Text(Date.toString(),style: smallTextStyle.copyWith(fontSize: 9.sp,color: Colors.teal),),],
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                      const Spacer(),
                                    ],
                                  ),
                                  const Divider()
                                ],
                              ),
                            );
                          }),
                    ],
                  )
                  )
              ): const Center(
                child: DataNotFound(),
              )
          ),
        ),
        );
  }
}