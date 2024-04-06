import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:usermechanic/Widget/TextStyle.dart';
import 'package:usermechanic/Widget/styles.dart';
class EditTextWidget extends StatelessWidget {
  final TextEditingController ?controller;
  final String? labelText;
  final TextInputType ?type;
  final FormFieldValidator? validator;
  final int ?length;
  final bool ?isRead;
  const EditTextWidget({Key? key,  this.controller, this.validator,
    this.type=TextInputType.text, this.length=null, this.isRead=false, required this.labelText,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller:controller,

        readOnly: isRead!,
        decoration:  InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width:.5,color: Color(0xffc2bfbf)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(width:.5,color: Color(0xffc2bfbf)),
          ),
          errorBorder:OutlineInputBorder(
            borderSide: BorderSide(width:.5,color: Color(0xffc2bfbf)),
          ),
          border:OutlineInputBorder(
            borderSide: BorderSide(width:.5,color: Color(0xffc2bfbf)),
          ),
          focusedErrorBorder:OutlineInputBorder(
            borderSide: BorderSide(width:.5,color: Color(0xffc2bfbf)),
          ),
          isDense: true,
          counter: Offstage(),
          labelText: labelText,
          labelStyle: robotoRegular.copyWith(color: Color(0xff049486)),
          contentPadding:EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        ),
        keyboardType: type,
        validator:validator ,
        maxLength: length,
        style: smallTextStyle.copyWith(color: Colors.black));
  }
}
