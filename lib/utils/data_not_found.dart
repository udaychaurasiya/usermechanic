import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:usermechanic/Widget/TextStyle.dart';
import 'package:usermechanic/utils/all_image.dart';

class DataNotFound extends StatelessWidget {
  const DataNotFound({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(AllImage.noDataFound, height: 80.r, width: 200.r, color: Colors.grey.shade300,),
        SizedBox(height: 10.r),
        Text("Records is not found !!",style: robotoMedium.copyWith(color: Colors.black38),),
      ],
    );
  }
}
