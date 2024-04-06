//
// import 'dart:io';
//
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:google_ml_kit/google_ml_kit.dart';
// import 'package:image_picker/image_picker.dart';
// class FaceLoginScreen extends StatefulWidget {
//   @override
//   _FaceLoginScreenState createState() => _FaceLoginScreenState();
// }
//
// class _FaceLoginScreenState extends State<FaceLoginScreen> {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FaceDetector _faceDetector = GoogleMlKit.vision.faceDetector();
//
//   Future<void> _loginWithFace() async {
//     final imagePicker = ImagePicker();
//     final pickedImage = await imagePicker.getImage(source: ImageSource.camera);
//     if (pickedImage == null) return;
//
//     final inputImage = InputImage.fromFile(File(pickedImage.path));
//     final faces = await _faceDetector.processImage(inputImage);
//
//     if (faces.isNotEmpty) {
//       final userCredential = await _auth.signInAnonymously();
//       if (userCredential.user != null) {
//         print('Login successful');
//       } else {
//         print('Login failed');
//       }
//     } else {
//       print('No face detected');
//     }
//   }
//
//   @override
//   void dispose() {
//     _faceDetector.close();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Face Login'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             ElevatedButton(
//               onPressed: _loginWithFace,
//               child: Text('Login with Face'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }