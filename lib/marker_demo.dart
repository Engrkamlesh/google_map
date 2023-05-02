import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Marker_Demo extends StatefulWidget {
  const Marker_Demo({Key? key}) : super(key: key);

  @override
  State<Marker_Demo> createState() => _Marker_DemoState();
}

class _Marker_DemoState extends State<Marker_Demo> {


  final Completer<GoogleMapController> _controller = Completer();

  Uint8List? markerimage;

  static const CameraPosition _kgoogle =
  CameraPosition(target: LatLng(25.52760000, 69.01255000), zoom: 14);

Future<Uint8List> _getLocationIcon(String impath , int imwidth)async{
  ByteData data =await rootBundle.load(impath);
  ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),targetHeight: imwidth);
  ui.FrameInfo fi = await codec.getNextFrame();
  return(await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
}

  List<String> images = [
    'images/ambulance.png',
    'images/bank.png',
    'images/bycicle.png',
    'images/smartphone.png',
    'images/sport-car.png',
    'images/store.png'
  ];
  List<Marker> _marker = <Marker>[];
  List<LatLng> _latlong = <LatLng>[
    LatLng(25.52760000, 69.01255000),
    LatLng(25.30981000, 69.05019000),
    LatLng(26.23939000, 68.40369000),
    LatLng(24.73701000, 69.79707000),
    LatLng(26.04694000, 68.94917000),
    LatLng(25.46050000, 68.71745000),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    LoadData();
  }

  void LoadData() async{
    for (int i = 0; i < images.length; i++){
      final Uint8List imageicon = await _getLocationIcon(images[i], 100);
      _marker.add(
          Marker(markerId: MarkerId(i.toString()),
          icon: BitmapDescriptor.fromBytes(imageicon),
          position: _latlong[i],
            infoWindow: InfoWindow(title: 'Marker Location'+i.toString())
          )
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GoogleMap(
          initialCameraPosition: _kgoogle,
          myLocationButtonEnabled: true,
          myLocationEnabled: true,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
          markers: Set<Marker>.of(_marker),
        ),
      ),
    );
  }
}
