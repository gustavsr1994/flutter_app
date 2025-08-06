import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_app/maps_controller.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class MapsPage extends StatefulWidget {
  const MapsPage({super.key});

  @override
  State<MapsPage> createState() => _MapsPageState();
}

class _MapsPageState extends State<MapsPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<MapsController>().fetchCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Consumer<MapsController>(
          builder: (context, state, _) {
            if (state.isLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return GoogleMap(
                initialCameraPosition: CameraPosition(
                    target: LatLng(-6.223915808939789, 106.80601597641456),
                    zoom: 15),
                //CameraPosition(target: state.currentPosition!, zoom: 15),
                markers: {
                  // Marker(
                  //     markerId: MarkerId('Location-1'),
                  //     position: state.currentPosition!,
                  //     icon: BitmapDescriptor.defaultMarker,
                  //     infoWindow: InfoWindow(title: "Location 1")),
                  Marker(
                      markerId: MarkerId('Location-1'),
                      position: LatLng(-6.228571029158414, 106.80001402330308),
                      icon: BitmapDescriptor.defaultMarkerWithHue(
                          BitmapDescriptor.hueBlue),
                      infoWindow: InfoWindow(title: "Location 1")),
                  Marker(
                      markerId: MarkerId('Location-2'),
                      position: LatLng(-6.223915808939789, 106.80601597641456),
                      icon: BitmapDescriptor.defaultMarkerWithHue(
                          BitmapDescriptor.hueBlue),
                      infoWindow: InfoWindow(title: "Location 2")),
                  Marker(
                      markerId: MarkerId('Location-3'),
                      position: LatLng(-6.21949556870162, 106.81198876459247),
                      icon: BitmapDescriptor.defaultMarkerWithHue(
                          BitmapDescriptor.hueBlue),
                      infoWindow: InfoWindow(title: "Location 3"))
                },
                polylines: {
                  Polyline(polylineId: PolylineId('Lines-1'), 
                  color: Colors.red,
                  points: [
                    LatLng(-6.228571029158414, 106.80001402330308),
                    LatLng(-6.223915808939789, 106.80601597641456),
                    LatLng(-6.21949556870162, 106.81198876459247)
                  ])
                },
              );
            }
          },
        ),
      ),
    );
  }
}
