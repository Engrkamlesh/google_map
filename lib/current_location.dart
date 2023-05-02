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

 final Completer<GoogleMapController> _controller = Completer();
 CameraPosition _kgoogle = CameraPosition(target: LatLng(25.4570, 68.7215),zoom: 14);

 List<Marker> _list = [];
 List<Marker> _marker =<Marker>[
   Marker(
     markerId: MarkerId('1'),
     position: LatLng(25.5276,69.01255),
     infoWindow: InfoWindow(title: 'Mirpurkhas')
   ),
   Marker(
       markerId: MarkerId('2'),
       position: LatLng(25.39242,68.37366),
       infoWindow: InfoWindow(title: 'Hyderabad')
   ),
   Marker(
       markerId: MarkerId('3'),
       position: LatLng(25.43608,68.28017),
       infoWindow: InfoWindow(title: 'Jamshoro')
   ),
   Marker(
       markerId: MarkerId('4'),
       position: LatLng(25.76818000,68.66196000),
       infoWindow: InfoWindow(title: 'Tando Adam')
   ),
   Marker(
       markerId: MarkerId('5'),
       position: LatLng(25.36329000,69.74184000),
       infoWindow: InfoWindow(title: 'Umar Kot')
   ),
 ];

 Future<Position> _getUserLocation () async{
   await Geolocator.requestPermission().then((value) async{
   }).onError((error, stackTrace) async {
    await Geolocator.getCurrentPosition();
     print('Error'+error.toString());
   });
   return Geolocator.getCurrentPosition();
 }
Future<Position> _getLocation() async{
   await Geolocator.requestPermission().then((value){

   }).onError((error, stackTrace)async {
     await Geolocator.requestPermission();
     print("Error"+error.toString());
   });
   return Geolocator.getCurrentPosition();
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: GoogleMap(
            initialCameraPosition: _kgoogle,
            markers: Set<Marker>.of(_marker),
            onMapCreated: (GoogleMapController controller){
              _controller.complete(controller);
          }
          )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.my_location),
        onPressed: ()async{
          _getLocation().then((value)async {
            print('Current Location');
            print(value.latitude.toString()+""+value.longitude.toString());


            CameraPosition _camera =CameraPosition(target: LatLng(25.5276,69.01255),zoom: 14);
            final GoogleMapController Controller = await _controller.future;
            Controller.animateCamera(CameraUpdate.newCameraPosition(_camera));
            setState((){

            });
          });
        },
      ),
    );
  }
}
