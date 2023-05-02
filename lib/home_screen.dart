import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Home_Screen extends StatefulWidget {
  const Home_Screen({Key? key}) : super(key: key);

  @override
  State<Home_Screen> createState() => _Home_ScreenState();
}

class _Home_ScreenState extends State<Home_Screen> {
  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  List<Marker> _marker = [];
  List<Marker> _list = [
    Marker(
        markerId: MarkerId('1'),
        position: LatLng(25.5065, 69.0136),
        infoWindow: InfoWindow(title: 'Mirpurkhas')),
    Marker(
        markerId: MarkerId('2'),
        position: LatLng(33.6844, 73.0479),
        infoWindow: InfoWindow(title: 'Islamabad')),
    Marker(
        markerId: MarkerId('3'),
        position: LatLng(40.7128, 74.0060),
        infoWindow: InfoWindow(title: 'New York')),
    Marker(
        markerId: MarkerId('4'),
        position: LatLng(20.5937, 78.9629),
        infoWindow: InfoWindow(title: 'India')),
    Marker(
        markerId: MarkerId('5'),
        position: LatLng(35.6762, 139.6503),
        infoWindow: InfoWindow(title: 'Tokyo Japan'))
  ];
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    _marker.addAll(_list);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: GoogleMap(
        initialCameraPosition: _kGooglePlex,
        markers: Set<Marker>.of(_marker),
        // mapType: MapType.terrain,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          GoogleMapController controller = await _controller.future;
          controller.animateCamera(CameraUpdate.newCameraPosition(
              CameraPosition(target: LatLng(25.5065, 69.0136), zoom: 14)));
          setState(() {});
        },

        child: Icon(
          Icons.location_disabled_rounded,
        ),
      ),
    );
  }
}
