import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class Button3 extends StatelessWidget {
  final VoidCallback onPress;
  final String text;
  const Button3({Key? key, required this.onPress, required this.text, }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: new Text("Alert!!"),
      content: new Text("You are awesome!"),
      actions: <Widget>[
         TextButton(
          child: new Text("OK"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
