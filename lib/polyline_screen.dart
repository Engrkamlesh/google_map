import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Polyline_Screen extends StatefulWidget {
  const Polyline_Screen({Key? key}) : super(key: key);

  @override
  State<Polyline_Screen> createState() => _Polyline_ScreenState();
}

class _Polyline_ScreenState extends State<Polyline_Screen> {

  final Completer<GoogleMapController> _controller = Completer();

  static const CameraPosition _Kgoogle = CameraPosition(
      target: LatLng(25.508004296050956, 69.0108387676061),
      zoom: 14);

  Set<Marker> _marker = {};
  Set<Polyline> _polyline = {};

  List<LatLng> _latlong = [
    LatLng(25.48631391659306, 69.01271874873699),
    LatLng(25.511885080485285, 68.94097634437597),
    LatLng(25.536981489809044, 68.97788511805263),
    LatLng(25.553241820396043, 69.01085891300743),
    LatLng(25.533860365196034, 69.04708380374451),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for (int i = 0; i < _latlong.length;
    i++) {
      _marker.add(
          Marker(markerId: MarkerId('1'),
              position: _latlong[i],
              infoWindow: InfoWindow(
                  title: 'Current Location', snippet: '5 Star')
          ));
      setState(() {

      });
    }
    _polyline.add(
        Polyline(
            polylineId: PolylineId('1'),
            points: _latlong,
            color: Colors.deepOrangeAccent
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GoogleMap(
          initialCameraPosition: _Kgoogle,
          mapType: MapType.normal,
          markers: _marker,
          polylines: _polyline,

        ),
      ),
    );
  }
}
