import 'dart:async';
import 'dart:ui' as ui;
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Multi_Marker extends StatefulWidget {
  const Multi_Marker({Key? key}) : super(key: key);

  @override
  State<Multi_Marker> createState() => _Multi_MarkerState();
}

class _Multi_MarkerState extends State<Multi_Marker> {

  final Completer<GoogleMapController> _controller = Completer();

  Uint8List? markerimage;

  List<String> images = [
    'images/ambulance.png',
    'images/bank.png',
    'images/bycicle.png',
    'images/smartphone.png',
    'images/sport-car.png',
    'images/store.png'
  ];
  final List<Marker> _marker = <Marker>[];
  final List<LatLng> _latlng = <LatLng>[
    LatLng(25.52760000, 69.01255000),
    LatLng(25.30981000, 69.05019000),
    LatLng(26.23939000, 68.40369000),
    LatLng(24.73701000, 69.79707000),
    LatLng(26.04694000, 68.94917000),
    LatLng(25.46050000,	68.71745000),
  ];

  static const CameraPosition _kGoogle =
      CameraPosition(target: LatLng(25.52760000, 69.01255000), zoom: 14);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  void loadData() async{
    for (int i = 0; i < images.length; i++) {
      final Uint8List markericon = await _getBytefromAssest(images[i], 100);
      _marker.add(
          Marker(
          markerId: MarkerId(i.toString()),
          position: _latlng[i],
          icon: BitmapDescriptor.fromBytes(markericon),
          infoWindow: InfoWindow(
            title: 'Title Marker' + i.toString(),
          )));
      setState(() {});
    }
  }

  Future<Uint8List> _getBytefromAssest(String imapath, int imgwidth)async{
    ByteData data = await rootBundle.load(imapath);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),targetHeight: imgwidth);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (
      await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: GoogleMap(
        initialCameraPosition: _kGoogle,
        mapType: MapType.normal ,
        markers: Set<Marker>.of(_marker),
        myLocationButtonEnabled: true,
        myLocationEnabled: true,
        onMapCreated: (GoogleMapController controllers) {
          _controller.complete(controllers);
        },
      )),
    );
  }
}
