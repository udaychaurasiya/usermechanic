// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:usermechanic/Dashbord/Controller/dashbordcontroller.dart';
// import 'package:usermechanic/Dashbord/Model/TranscationModel.dart';
// import 'package:usermechanic/Widget/styles.dart';
// class TranscationDeatils extends StatefulWidget {
//   final String id;
//   const TranscationDeatils(this.id,{Key? key}) : super(key: key);
//
//   @override
//   State<TranscationDeatils> createState() => _TranscationDeatilsState();
// }
//
// class _TranscationDeatilsState extends State<TranscationDeatils> {
//   HomePageController controller=Get.put(HomePageController());
//   List<Uday> Transctions=[];
//   Uday data=Uday();
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//       print("${data}jiuhuigg");
//     data=controller.Transction;
//   }
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.teal,
//         leadingWidth: 20.w,
//         title: Text("Transcation Deatils"),
//       ),
//       body: Column(
//         // crossAxisAlignment: CrossAxisAlignment.center,
//         // mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Container(
//             height:250.h,
//             width: Get.width,
//             child: Center(
//               child: Image.asset(
//                 'assets/images/check2.gif',
//               ),
//             ),
//           ),
//           Text("Payment Successful",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22.sp,color: Colors.green),),
//           SizedBox(height: 10.h,),
//           Text("Your Payment has been processed !",style: smallTextStyle.copyWith(fontSize: 14.sp,color: Colors.grey),),
//           SizedBox(height: 5.h,),
//           Text("Details of transaction are included below",style: smallTextStyle.copyWith(fontSize: 14.sp,color: Colors.grey),),
//         ],
//       ),
//     );
//   }
// }
