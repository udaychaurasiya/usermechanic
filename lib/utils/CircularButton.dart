// ignore_for_file: file_names

import 'package:flutter/material.dart';

class CircularButton extends StatelessWidget {
  final VoidCallback onPress;

  const CircularButton({Key? key, required this.onPress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Positioned(
            left: 0,
            top: 0,
            child: SizedBox(
                height: 48,
                width: 48,
                child: CircularProgressIndicator(strokeWidth: 1,color: Colors.teal))),
        RawMaterialButton(onPressed: onPress,
          fillColor: Colors.teal,
          padding: const EdgeInsets.all(7),
          shape: const CircleBorder(),
          constraints: const BoxConstraints(maxHeight: 40,maxWidth: 40),
          child: const Icon(Icons.arrow_forward,color: Colors.white,),
        ),
      ],
    );
  }
}
