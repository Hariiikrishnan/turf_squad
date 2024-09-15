import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:turf_project/constants.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController mapController;
  // final Completer<GoogleMapController> _controller =
  // Completer<GoogleMapController>();

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    // _controller.complete(controller);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: scaffoldColor,
        foregroundColor: textColor,
        title: Text(
          "Turf Location",
          style: TextStyle(
            color: textColor,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            mapController.animateCamera(CameraUpdate.newCameraPosition(
                CameraPosition(
                    target: LatLng(10.757703, 79.112254)!, zoom: 17.4746)));
          });
        },
        child: const Icon(
          Icons.center_focus_strong,
          color: scaffoldColor,
        ),
      ),
      body: GoogleMap(
        myLocationButtonEnabled: false,
        zoomControlsEnabled: false,
        // myLocationEnabled: true,
        // markers: marker,

        // polylines: polyline,
        markers: {
          Marker(
            markerId: MarkerId("Current_Place"),
            position: LatLng(10.757703, 79.112254),
            // icon: customIcon,
          ),
        },
        onMapCreated: _onMapCreated,
        mapType: MapType.terrain,
        initialCameraPosition: CameraPosition(
            target: LatLng(10.757703, 79.112254)!, zoom: 17.4746),
      ),
    );
  }
}
