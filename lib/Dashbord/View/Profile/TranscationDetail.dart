// ignore_for_file: deprecated_member_use

import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:share_plus/share_plus.dart';
import 'package:usermechanic/AppConstant/APIConstant.dart';
import 'package:usermechanic/Dashbord/Controller/dashbordcontroller.dart';
import 'package:usermechanic/Dashbord/Model/TranscationModel.dart';
import 'package:usermechanic/Widget/styles.dart';
import 'package:pdf/widgets.dart' as pw;

class TranscationDeatil extends StatefulWidget {
  final String id;
  const TranscationDeatil(this.id,{Key? key}) : super(key: key);

  @override
  State<TranscationDeatil> createState() => _TranscationDeatilState();
}

class _TranscationDeatilState extends State<TranscationDeatil> {
  HomePageController controller=Get.put(HomePageController());
  List<DataDetails> Transctions=[];
  DataDetails data=DataDetails();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
      print("${data}jiuhuigg");
    // data=controller.Transction;
    controller.getTransctionDetails(widget.id);
    controller.getContactUsNetworkApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 40.r,
        backgroundColor: Colors.teal,
        leadingWidth: 20.r,
        title: Text("Transaction Details",style: TextStyle(fontSize: 14.r)),
        actions: [
          Padding(
            padding:  EdgeInsets.only(right: 8.r),
            child: IconButton(onPressed: ()async{
            }, icon: Icon(Icons.share,size: 25.r,)),
          )
        ],
      ),
      body:
         Obx(()=>controller.bookingservicedetails.value.data!=null?
            SingleChildScrollView(
              child: Column(
              children: List.generate(1, (index){
                return SizedBox(
                  width: Get.width,
                  child: Padding(
                    padding:  EdgeInsets.all(8.r),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: Get.width/2.1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(controller.bookingservicedetails.value.data!.username.toString(),style: TextStyle(fontSize: 14.r),),
                                  Text(controller.bookingservicedetails.value.data!.mobileNo.toString(),style: TextStyle(fontSize: 14.r)),
                                  Text(controller.bookingservicedetails.value.data!.bookingAddress.toString(),style: TextStyle(fontSize: 14.r)),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: Get.width/2.1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text("Booking No: ",style: TextStyle(fontSize: 14.r)),
                                      Text(controller.bookingservicedetails.value.data!.bookingNo.toString(),style: TextStyle(fontSize: 14.r)),
                                    ],
                                  ),
                                  Text(controller.bookingservicedetails.value.data!.serviceDate.toString(),style: TextStyle(fontSize: 14.r)),
                                  Text("Amount : "+controller.bookingservicedetails.value.data!.payableAmount.toString(),textAlign: TextAlign.end,style: TextStyle(fontSize: 14.r)),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 50.h,),
                        Column(
                          children: [
                            Column(
                              children: [
                                Table(
                                  columnWidths: {
                                    0: FlexColumnWidth(2),
                                    1: FlexColumnWidth(2),
                                  },
                                  border: TableBorder.all(width: .5),
                                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                                  children: [
                                    TableRow(
                                      children: [
                                        TableCell(
                                          child: Padding(
                                            padding:EdgeInsets.only(top:10.h,bottom: 10.h),
                                            child: Center(child: Text("Item",textAlign:TextAlign.center,style: TextStyle(fontSize: 14.sp,fontWeight: FontWeight.bold),)),
                                          ),
                                        ),
                                        TableCell(
                                          child: Padding(
                                            padding:  EdgeInsets.only(top:5.h,bottom: 5.h),
                                            child: Center(child: Text("Price(Rs)",textAlign:TextAlign.center,style: TextStyle(fontSize: 14.sp,fontWeight: FontWeight.bold))),
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
                                  // DateTime parsedDate2 = DateTime.parse(data.addDate.toString());
                                  // String Date2 =DateFormat('dd-MMM-yyyy').format(data.addDate);
                                  return
                                    Column(
                                      children: [
                                        Table(
                                          columnWidths: {
                                            0: FlexColumnWidth(2),
                                            1: FlexColumnWidth(2),
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
                            Column(
                              children: [
                                Table(
                                  columnWidths: {
                                    0: FlexColumnWidth(2),
                                    1: FlexColumnWidth(2),
                                  },
                                  border: TableBorder.all(width: .5),
                                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                                  children: [
                                    TableRow(
                                      children: [
                                        TableCell(
                                          child: Padding(
                                            padding:  EdgeInsets.only(top:10.h,bottom: 10.h),
                                            child: Center(child: Text("Total",textAlign:TextAlign.center,style: TextStyle(fontSize: 14.sp,fontWeight: FontWeight.bold),)),
                                          ),
                                        ),
                                        TableCell(
                                          child: Padding(
                                            padding:  EdgeInsets.only(top:5.h,bottom: 5.h),
                                            child: Center(child: Text("Rs : "+controller.bookingservicedetails.value.data!.payableAmount.toString()+".00",textAlign:TextAlign.center,style: TextStyle(fontSize: 14.sp,color:Colors.green,fontWeight: FontWeight.bold))),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
                            SizedBox(height: 5.h,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Note:- ",style: TextStyle(color: Colors.black,fontSize: 15.sp,fontWeight: FontWeight.bold),),
                                Expanded(child: Text("All constellations are visible from any point on Earth, so star maps are divided "
                                    "between the northern and southern hemispheres. Moreover, the constellations can "
                                    "change according to the season and the place on Earth where you are",style: bodybold3Style.copyWith(color:Colors.teal,fontWeight: FontWeight.w100),)),
                              ],
                            )
                          ],
                        ),
                        SizedBox(height: 40.h,),
                        Obx(()=>controller.contactUs.value.data!=null?
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width:Get.width/2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(controller.contactUs.value.data!.title.toString(),style: bodybold3Style.copyWith(color: Colors.black,fontSize: 14.sp),),
                                  Text(controller.contactUs.value.data!.mobile.toString(),style: bodybold3Style.copyWith(color: Colors.black),),
                                  Text(controller.contactUs.value.data!.email.toString(),style: bodybold3Style.copyWith(color: Colors.black),),
                                  Text(controller.contactUs.value.data!.address.toString(),style: bodybold3Style.copyWith(color: Colors.black),),
                                ],
                              ),
                            ),
                             Spacer(),
                             SizedBox(
                              width: 140.w,
                              child: Column(
                                children: [
                                  Image.network(BASE_URL+controller.contactUs.value.data!.feviconIcon.toString(),color: Color(
                                      0xffff0000),),
                                  Text("Bike Mechanic",style: bodybold3Style.copyWith(fontSize:19.sp,color: Color(
                                      0xff09856e)),)
                                ],
                              ),
                            ),
                          ],
                        ):Container()
                        ),
                        SizedBox(height: 40.h,),
                      ],
                    ),
                  ),
                );
              }),
         ),
            ):Container()
         ),
    );
  }
  Future<Uint8List> fetchImageFromApi(String imageUrl) async {
    final response = await http.get(Uri.parse(imageUrl));
    if (response.statusCode == 200) {
      return response.bodyBytes;
    } else {
      throw Exception('Failed to fetch image from API');
    }
  }
  Future<void> generatePDF() async {

    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        build: (context) {
          return pw.ListView.builder(
            itemBuilder: (context, index) {
              return pw.Container(
                  child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      mainAxisAlignment: pw.MainAxisAlignment.start,
                      children: [
                        pw.Row(
                            crossAxisAlignment: pw.CrossAxisAlignment.end,
                            mainAxisAlignment: pw.MainAxisAlignment.end,
                            children: [
                             pw. Container(
                                child: pw.Column(
                                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                                  mainAxisAlignment: pw.MainAxisAlignment.start,
                                  children: [
                                    pw.Text(controller.bookingservicedetails.value.data!.username.toString()),
                                    pw.Text(controller.bookingservicedetails.value.data!.mobileNo.toString()),
                                    pw.Text(controller.bookingservicedetails.value.data!.bookingAddress.toString()),
                                  ],
                                ),
                              ),
                              pw.Spacer(),
                              pw.Container(
                                child: pw.Column(
                                  crossAxisAlignment: pw.CrossAxisAlignment.end,
                                  mainAxisAlignment: pw.MainAxisAlignment.end,
                                  children: [
                                    pw.Row(
                                      crossAxisAlignment: pw.CrossAxisAlignment.end,
                                      mainAxisAlignment: pw.MainAxisAlignment.end,
                                      children: [
                                        pw.Text("Booking No: "),
                                        pw.Text(controller.bookingservicedetails.value.data!.bookingNo.toString()),
                                      ],
                                    ),
                                    pw.Text(controller.bookingservicedetails.value.data!.serviceDate.toString()),
                                    pw.Text(controller.bookingservicedetails.value.data!.bookingAddress.toString()),
                                  ],
                                ),
                              ),
                            ]
                        ),
                        pw.SizedBox(height: 30.h),
                        pw.Column(
                          children: [
                            pw.Column(
                              children: [
                                pw.Table(
                                  columnWidths: {
                                    0: pw.FlexColumnWidth(2),
                                    1: pw.FlexColumnWidth(2),
                                  },
                                  border: pw.TableBorder.all(width: .5),
                                  defaultVerticalAlignment: pw.TableCellVerticalAlignment.middle,
                                  children: [
                                    pw.TableRow(
                                      children: [
                                        pw.Container(
                                          child: pw.Padding(
                                            padding:  pw.EdgeInsets.only(top:10.h,bottom: 10.h),
                                            child: pw.Center(child: pw.Text("Item",textAlign:pw.TextAlign.center,style: pw.TextStyle(fontSize: 14.sp,fontWeight: pw.FontWeight.bold),)),
                                          ),
                                        ),
                                        pw.Container(
                                          child: pw.Padding(
                                            padding:  pw.EdgeInsets.only(top:5.h,bottom: 5.h),
                                            child: pw.Center(child: pw.Text("Price(Rs)",textAlign:pw.TextAlign.center,style: pw.TextStyle(fontSize: 14.sp,fontWeight: pw.FontWeight.bold))),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
                            pw.Container(
                              child: pw.ListView.builder(
                                itemCount: controller.bookingservicedetails.value.data!.partsList!.length,
                                itemBuilder: ( context, int index) {
                                  final data=controller.bookingservicedetails.value.data!.partsList![index];
                                  // DateTime parsedDate2 = DateTime.parse(data.addDate.toString());
                                  // String Date2 =DateFormat('dd-MMM-yyyy').format(data.addDate);
                                  return
                                    pw.Column(
                                      children: [
                                        pw.Table(
                                          columnWidths: {
                                            0: pw.FlexColumnWidth(2),
                                            1: pw.FlexColumnWidth(2),
                                          },
                                          border: pw.TableBorder.all(width: .5),
                                          defaultVerticalAlignment: pw.TableCellVerticalAlignment.middle,
                                          children: [
                                            pw.TableRow(
                                              children: [
                                                pw.Container(
                                                  child: pw.Padding(
                                                    padding:  pw.EdgeInsets.only(top:5.h,bottom: 5.h),
                                                    child: pw.Center(child: pw.Text(data.parts.toString(),textAlign:pw.TextAlign.center,style: pw.TextStyle(fontSize: 12.sp),)),
                                                  ),
                                                ),
                                                pw.Container(
                                                  child: pw.Padding(
                                                    padding:  pw.EdgeInsets.only(top:5.h,bottom: 5.h),
                                                    child: pw.Center(child: pw.Text(data.amount.toString()+".00",textAlign:pw.TextAlign.center,style: pw.TextStyle(fontSize: 12.sp))),
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
                            pw.Column(
                              children: [
                                pw.Table(
                                  columnWidths: {
                                    0: pw.FlexColumnWidth(2),
                                    1: pw.FlexColumnWidth(2),
                                  },
                                  border: pw.TableBorder.all(width: .5),
                                  defaultVerticalAlignment: pw.TableCellVerticalAlignment.middle,
                                  children: [
                                    pw.TableRow(
                                      children: [
                                        pw.Container(
                                          child: pw.Padding(
                                            padding:  pw.EdgeInsets.only(top:10.h,bottom: 10.h),
                                            child: pw.Center(child: pw.Text("Total",textAlign:pw.TextAlign.center,style: pw.TextStyle(fontSize: 14.sp,fontWeight: pw.FontWeight.bold),)),
                                          ),
                                        ),
                                        pw.Container(
                                          child: pw.Padding(
                                            padding:  pw.EdgeInsets.only(top:5.h,bottom: 5.h),
                                            child: pw.Center(child: pw.Text("Rs : "+controller.bookingservicedetails.value.data!.payableAmount.toString()+".00",textAlign:pw.TextAlign.center,style: pw.TextStyle(fontSize: 14.sp,color:PdfColors.green,fontWeight: pw.FontWeight.bold))),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
                            pw.SizedBox(height: 20.h,),

                          ],
                        ),
                        pw.SizedBox(height: 20.h),
                        pw.Row(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          mainAxisAlignment: pw.MainAxisAlignment.start,
                          children: [
                            pw.Container(
                              child: pw.Column(
                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                mainAxisAlignment: pw.MainAxisAlignment.start,
                                children: [
                                  pw.Text(controller.contactUs.value.data!.title.toString(),style: pw.TextStyle(color: PdfColors.black,fontSize: 14.sp),),
                                  pw.Text(controller.contactUs.value.data!.mobile.toString(),style: pw.TextStyle(color: PdfColors.black),),
                                  pw.Text(controller.contactUs.value.data!.email.toString(),style: pw.TextStyle(color: PdfColors.black),),
                                  pw.Text(controller.contactUs.value.data!.address.toString(),style: pw.TextStyle(color: PdfColors.black),),
                                ],
                              ),
                            ),
                            pw.Spacer(),
                            pw.Container(
                              width: 140.w,
                              child: pw.Column(
                                children: [
                                  // pw.Container(
                                  //   height: 100.h,
                                  //   width: 200.w,
                                  //   child:  pw.Image(pw.MemoryImage(byteList), fit: pw.BoxFit.fitHeight,),
                                  // ),
                                  pw.Text("Bike Mechanic",style: pw.TextStyle(fontSize:20.sp,color: PdfColors.red),)
                                ],
                              ),
                            ),
                          ],
                        ),
                        pw.SizedBox(height: 20.h),
                        pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.start,
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Text("Note:- ",style: pw.TextStyle(color: PdfColors.black,fontSize: 15.sp,fontWeight: pw.FontWeight.bold),),
                            pw.Expanded(child: pw.Text("All constellations are visible from any point on Earth, so star maps are divided "
                                "between the northern and southern hemispheres. Moreover, the constellations can "
                                "change according to the season and the place on Earth where you are",textAlign:pw.TextAlign.justify,style: pw.TextStyle(color:PdfColors.teal,),)),
                          ],
                        )
                      ]
                  )
              );
            },
            itemCount:1,
          );
        },
      ),
    );
    final output = await getTemporaryDirectory();
    final file = File('${output.path}/Transcation Report.pdf');
    await file.writeAsBytes(await pdf.save());
    Share.shareFiles([file.path], text: 'Sharing PDF');
  }

}
