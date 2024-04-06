// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:location_platform_interface/location_platform_interface.dart';
// class mapscre extends StatefulWidget {
//   final LocationData? location;
//   const mapscre({Key? key, required this.location,}) : super(key: key);
//
//   @override
//   _mapscreState createState() => _mapscreState();
// }
//
// class _mapscreState extends State<mapscre> {
//   late GoogleMapController _mapController;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Select Location"),
//       ),
//       body: GoogleMap(
//         onMapCreated: (controller) {
//           setState(() {
//             _mapController = controller;
//           });
//         },
//         initialCameraPosition: CameraPosition(
//           target: LatLng(
//             widget.initialLocation.latitude,
//             widget.initialLocation.longitude,
//           ),
//           zoom: 15.0,
//         ),
//         onTap: (position) {
//           Navigator.of(context).pop(position);
//         },
//       ),
//     );
//   }
// }