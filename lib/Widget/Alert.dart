import 'package:flutter/material.dart';

class Button3 extends StatelessWidget {
  final VoidCallback onPress;
  final String text;
  const Button3({Key? key, required this.onPress, required this.text, }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Alert!!"),
      content: const Text("You are awesome!"),
      actions: <Widget>[
         TextButton(
          child: const Text("OK"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
