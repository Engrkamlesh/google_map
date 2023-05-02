import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class Current_Location extends StatefulWidget {
  const Current_Location({Key? key}) : super(key: key);

  @override
  State<Current_Location> createState() => _Current_LocationState();
}

class _Current_LocationState extends State<Current_Location> {
  Completer<GoogleMapController> _controller = Completer();

  static const CameraPosition _kGoogle =
  CameraPosition(target: LatLng(25.4570, 68.7215), zoom: 14);

  List<Marker> _marker = [
    Marker(
        markerId: MarkerId('1'),
        position: LatLng(25.4570, 68.7215),
        infoWindow: InfoWindow(title: 'Tando Allahyar'))
  ];

  Future<Position> _getUserLocation() async{
    await Geolocator.requestPermission().then((value){

    }).onError((error, stackTrace) async{
      await Geolocator.requestPermission();
      print('Error'+error.toString());
    });
    return Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GoogleMap(
          initialCameraPosition: _kGoogle,
          markers: Set<Marker>.of(_marker),
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.my_location_rounded),
          onPressed: () async {
            _getUserLocation().then((value) async {
              print('Current Location');
              print(
                  value.latitude.toString() + "" + value.longitude.toString());

              _marker.add(Marker(
                  markerId: MarkerId('2'),
                  position: LatLng(25.5065, 69.0136),
                  infoWindow: InfoWindow(title: 'Mirpurkhas')));
            });
            CameraPosition _cameraP =
            CameraPosition(target: LatLng(25.5065, 69.0136), zoom: 14);
            final GoogleMapController controller = await _controller.future;
            controller.animateCamera(CameraUpdate.newCameraPosition(_cameraP));
            setState(() {});
          }),
    );
  }
}
