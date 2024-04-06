import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:usermechanic/Dashbord/Controller/dashbordcontroller.dart';
class ProfileHelp extends StatefulWidget {
  const ProfileHelp({Key? key}) : super(key: key);

  @override
  State<ProfileHelp> createState() => _ProfileHelpState();
}

class _ProfileHelpState extends State<ProfileHelp> {
  HomePageController controller=Get.put(HomePageController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.getFaqNetworkApi();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Color(0xff049486),
        title: Text("Help"),
      ),
      body:Obx(()=> controller.faqModel.value.data!= null
          ?
       FadeInUp(
        delay: Duration(milliseconds: 50),
        child: SingleChildScrollView(
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
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: ExpansionTile(
                            backgroundColor: Color(0x3fcacccc),
                            textColor: Color(0xff049486),
                            iconColor: Color(0xff049486),
                            collapsedTextColor: Colors.black,

                            title: Text(data.title.toString()),
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
      ):Container()
      ),
    );
  }
}
