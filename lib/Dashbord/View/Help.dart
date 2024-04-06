import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:usermechanic/Dashbord/Controller/dashbordcontroller.dart';
class Help extends StatefulWidget {
  const Help({Key? key}) : super(key: key);
  @override
  State<Help> createState() => _HelpState();
}
class _HelpState extends State<Help> {
 final HomePageController controller=Get.put(HomePageController());
  @override
  void initState() {
    super.initState();
    controller.getFaqNetworkApi();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      body:RefreshIndicator(
        onRefresh: () {
          return controller.getFaqNetworkApi();
        },
        child: Obx(()=> controller.faqModel.value.data!= null
            ?
         FadeInUp(
          delay: Duration(milliseconds: 350),
          child: SingleChildScrollView(
            child: Padding(
              padding:  EdgeInsets.only(left:4.w,right: 4.w),
              child: Column(
                children: [
                  ListView.builder(
                      itemCount: controller.faqModel.value.data!.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder:
                          (context,index){
                        final data=controller.faqModel.value.data![index];
                        return Card(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 1.0,right: 1,),
                            child: Container(
                              margin: EdgeInsets.only(top: 3.h),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.r)
                              ),
                              child: ExpansionTile(
                                backgroundColor: Color(0x3fcacccc),
                                textColor: Color(0xff049486),
                                iconColor: Color(0xff049486),
                                collapsedTextColor: Colors.black,

                                title: Text(data.title.toString(),style: TextStyle(
                                  color: Color(0xff049486),fontSize: 14.r
                                ),),
                                children: [
                                  Container(
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 15, right: 15,bottom: 10),
                                      child: Html(data:data.description.toString(),style: {
                                        "body":Style(fontSize:FontSize(14.sp))
                                      },
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      })
                ],
              ),
            ),
          ),
        ):Container()
        ),
      ),
    );
  }
}
