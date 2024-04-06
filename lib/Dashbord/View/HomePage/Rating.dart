import 'dart:async';
import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:usermechanic/Dashbord/Controller/dashbordcontroller.dart';
import 'package:usermechanic/Dashbord/View/Dashbord.dart';
import '../../../Widget/styles.dart';
import '../../../utils/CircularButton.dart';
class RateUsApp extends StatefulWidget {
  RateUsApp(String string, {Key? key}) : super(key: key);
  @override
  State<RateUsApp> createState() => _RateUsAppState();
}

class _RateUsAppState extends State<RateUsApp> {
  TextEditingController etmessage = TextEditingController();
  HomePageController controller=Get.put(HomePageController());
  late String ratingvalue;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        leadingWidth: 30.w,
        title: Text("Rate Us"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 2.h),
          child: Column(
            children:[
              Image(image: AssetImage("assets/images/bike2.jpg",),height: 200.h,fit: BoxFit.fitWidth,),
              Container(child: Text("Like Using This Mechanic, Show some Love",
                style: titleStyle.copyWith(fontSize: 14.sp,
                    fontWeight: FontWeight.w900),),),
              SizedBox(height: 30,),
              RatingBar.builder(
                initialRating: 0,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: false,
                unratedColor: Colors.grey,
                itemCount: 5,
                itemPadding: EdgeInsets.symmetric(horizontal: 8.0),
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating)
                {
                  ratingvalue=rating.toString();
                  print("safsffg"+rating.toString());
                },
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                      padding: EdgeInsets.only(
                        top: 30.h,),
                      child: Container(
                          padding: EdgeInsets.all(5),
                          child: Container(
                            padding: EdgeInsets.zero,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(8.r)),
                            ),
                            width: double.infinity,
                            child: Column(
                              children: [
                                TextFormField(
                                  maxLines: null,
                                  minLines: 5,
                                  controller: etmessage,
                                  keyboardType: TextInputType.multiline,
                                  style: smallTextStyle,
                                  decoration: InputDecoration(
                                    alignLabelWithHint: true,
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                        borderSide: BorderSide(
                                            color:Colors.teal
                                        )
                                    ),

                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                        borderSide: BorderSide(
                                            color:Colors.teal
                                        )
                                    ),
                                    errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                        borderSide: BorderSide(
                                            color:Colors.teal
                                        )
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                        borderSide: BorderSide(
                                            width: 1,color:Colors.teal
                                        )
                                    ),

                                    labelText: "Write Here.....",
                                    labelStyle: smallTextStyle.copyWith(color: Colors.teal),
                                  ),
                                )

                              ],
                            ),
                          )
                      )
                  ),
                  SizedBox(height: 10.h,),
                  Row(
                    mainAxisAlignment:
                    MainAxisAlignment.end,
                    children: [
                      CircularButton(
                          onPress: ()
                          {
                            if(etmessage.text.isEmpty)
                            {
                              Fluttertoast.showToast(msg: "Please Enter your comments",

                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.yellow  );
                            }
                            else if (ratingvalue.isEmpty)
                            {
                              Fluttertoast.showToast(msg: "please select rating",

                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.yellow  );
                            }
                            else {
                              controller.postFeedbackRatingNetworkApi(etmessage.text, ratingvalue,);
                              Timer(Duration(seconds: 2), () {
                                Get.offAll(()=>Dashbord());
                              });
                            }
                          }
                      ),
                    ],
                  )
                ],
              )

            ],
          ),
        ),
      ),
    );
  }




}