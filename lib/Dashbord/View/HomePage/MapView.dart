// ignore_for_file: avoid_print

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:location/location.dart' as loc;
import 'package:location/location.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:math' show cos, sqrt, asin;

import 'package:usermechanic/auth/logincontroller.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}
LoginController controller = Get.put(LoginController());

class _MapScreenState extends State<MapScreen> {
  final Completer<GoogleMapController?> _controller = Completer();
  final String apiKey = "AIzaSyDL6vmveLaK3zRSY3cFAk2qFyLoOs_o9D4";
  final double lat = controller.lat.value;
  final double lng = controller.longitude.value;

  Map<PolylineId, Polyline> polylines = {};
  PolylinePoints polylinePoints = PolylinePoints();
  Location location = Location();
  Marker? sourcePosition, destinationPosition;
  loc.LocationData? _currentPosition;
  LatLng curLocation = LatLng(double.parse(controller.latitude.toString()), double.parse(controller.longitude.toString()));
  StreamSubscription<loc.LocationData>? locationSubscription;

  @override
  void initState() {
    super.initState();
    getNavigation();
    addMarker();
  }

  @override
  void dispose() {
    locationSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: sourcePosition == null
          ? const Center(child: CircularProgressIndicator())
          : Stack(
        children: [
          GoogleMap(
            zoomControlsEnabled: true,
            polylines: Set<Polyline>.of(polylines.values),
            initialCameraPosition: CameraPosition(
              target: curLocation,
              zoom: 50,
            ),
            markers: {sourcePosition!, destinationPosition!},
            onTap: (latLng) {
              print(latLng);
            },
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          ),
          Positioned(
            top: 30,
            left: 15,
            child: GestureDetector(
              onTap: () => Get.back(),
              child: const Icon(Icons.arrow_back),
            ),
          ),
          Positioned(
              bottom: 10,
              right: 150,
              child: Container(
                width: 60,
                height: 60,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Colors.blue),
                child: Center(
                  child: IconButton(
                    icon: const Icon(
                      Icons.navigation_outlined,
                      color: Colors.white,
                    ),
                    onPressed: () async {
                      await launchUrl(Uri.parse(
                          'google.navigation:q=$lat, $lng&key=$apiKey'));
                    },
                  ),
                ),
              ))
        ],
      ),
    );
  }

  getNavigation() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;
    final GoogleMapController? controller = await _controller.future;
    location.changeSettings(accuracy: loc.LocationAccuracy.high);
    serviceEnabled = await location.serviceEnabled();

    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    if (permissionGranted == loc.PermissionStatus.granted) {
      _currentPosition = await location.getLocation();
      curLocation =
          LatLng(_currentPosition!.latitude!, _currentPosition!.longitude!);
      locationSubscription =
          location.onLocationChanged.listen((LocationData currentLocation) {
            controller?.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
              target: LatLng(currentLocation.latitude!, currentLocation.longitude!),
              zoom: 12.0,
            )));
            if (mounted) {
              controller
                  ?.showMarkerInfoWindow(MarkerId(sourcePosition!.markerId.value));
              setState(() {
                curLocation =
                    LatLng(currentLocation.latitude!, currentLocation.longitude!);
                sourcePosition = Marker(
                  markerId: MarkerId(currentLocation.toString()),
                  icon: BitmapDescriptor.defaultMarkerWithHue(
                      BitmapDescriptor.hueBlue),
                  position:
                  LatLng(currentLocation.latitude!, currentLocation.longitude!),
                  infoWindow: InfoWindow(
                      onTap: () => getDistance(LatLng(lat, lng)),
                      title: '${double.parse((getDistance(LatLng(lat, lng)).toStringAsFixed(2)))} km'),
                  onTap: () {
                    print('market tapped');
                  },
                );
              });
              getDirections(LatLng(lat, lng));
            }
          });
    }
  }

  getDirections(LatLng dst) async {
    List<LatLng> polylineCoordinates = [];
    List<dynamic> points = [];
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        apiKey,
        PointLatLng(curLocation.latitude, curLocation.longitude),
        PointLatLng(dst.latitude, dst.longitude),
        travelMode: TravelMode.driving);
    if (result.points.isNotEmpty) {
      for (var point in result.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
        points.add({'lat': point.latitude, 'lng': point.longitude});
      }
    } else {
      print(result.errorMessage);
    }
    addPolyLine(polylineCoordinates);
  }

  addPolyLine(List<LatLng> polylineCoordinates) {
    PolylineId id = const PolylineId('poly');
    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.blue,
      points: polylineCoordinates,
      width: 5,
    );
    polylines[id] = polyline;
    setState(() {});
  }

  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  double getDistance(LatLng destposition) {
    return calculateDistance(curLocation.latitude, curLocation.longitude,
        destposition.latitude, destposition.longitude);
  }

  addMarker() {
    setState(() {
      sourcePosition = Marker(
        markerId: const MarkerId('Source'),
        position: curLocation,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
      );
      destinationPosition = Marker(
        markerId: const MarkerId('Destination'),
        position: LatLng(lat, lng),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan),
      );
    });
  }
}
