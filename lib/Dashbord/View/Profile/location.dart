import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({Key? key}) : super(key: key);

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  TextEditingController _locationController = TextEditingController();
  LatLng _selectedLocation = LatLng(26.8001308, 80.897502); // Initial location

  GoogleMapController? _mapController;

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      _mapController = controller;
    });
  }

  void _onMapTap(LatLng location) {
    setState(() {
      _selectedLocation = location;
      _locationController.text =
      '${_selectedLocation.latitude}, ${_selectedLocation.longitude}';
    });
  }

  void _searchAndNavigate(String searchTerm) async {
    try {
      List<Location> locations = await locationFromAddress(searchTerm);
      if (locations.isNotEmpty) {
        setState(() {
          _selectedLocation = LatLng(
            locations.first.latitude,
            locations.first.longitude,
          );
          _locationController.text =
          '${_selectedLocation.latitude}, ${_selectedLocation.longitude}';
        });
        _moveCameraToLocation();
      } else {
        // Handle case when no locations are found
        print('No locations found for $searchTerm');
      }
    } catch (e) {
      print('Error searching location: $e');
    }
  }

  void _moveCameraToLocation() {
    if (_mapController != null) {
      _mapController!.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
          target: _selectedLocation,
          zoom: 8.0,
        ),
      ));
    }
  }

  void _showMap() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  onChanged: (value) {
                    _searchAndNavigate(value);
                  },
                  decoration: InputDecoration(
                    labelText: 'Search Location',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Expanded(
                child: GoogleMap(
                  onMapCreated: _onMapCreated,
                  initialCameraPosition: CameraPosition(
                    target: _selectedLocation,
                    zoom: 8.0,
                  ),
                  onTap: _onMapTap,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Choose Location"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              flex: 5,
              child: TextFormField(
                controller: _locationController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: TextFormField(
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: _showMap,
                    icon: Icon(Icons.my_location, color: Colors.blue),
                  ),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
