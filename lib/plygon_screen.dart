import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Polygon_Screen extends StatefulWidget {
  const Polygon_Screen({Key? key}) : super(key: key);

  @override
  State<Polygon_Screen> createState() => _Polygon_ScreenState();
}

class _Polygon_ScreenState extends State<Polygon_Screen> {
  final Completer<GoogleMapController> _controller = Completer();

  static const CameraPosition _kGoogle = CameraPosition(
      target: LatLng(25.508004296050956, 69.0108387676061), zoom: 14);

  final Set<Polygon> _polygon = HashSet<Polygon>();

  List<LatLng> _point = [
    LatLng(25.48631391659306, 69.01271874873699),
    LatLng(25.511885080485285, 68.94097634437597),
    LatLng(25.536981489809044, 68.97788511805263),
    LatLng(25.553241820396043, 69.01085891300743),
    LatLng(25.533860365196034, 69.04708380374451),
    LatLng(25.492339361959306, 69.0444794525274),
    LatLng(25.48631391659306, 69.01271874873699),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _polygon.add(Polygon(
      polygonId: PolygonId('1'),
      points: _point,
      fillColor: Colors.green.withOpacity(0.4),
      geodesic: true,
      strokeWidth: 4,
      strokeColor: Colors.red
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: _kGoogle,
          myLocationEnabled: false,
          myLocationButtonEnabled: true,
          polygons: _polygon,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ),
      ),
    );
  }
}
