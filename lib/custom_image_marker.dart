import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Image_Marker extends StatefulWidget {
  const Image_Marker({Key? key}) : super(key: key);

  @override
  State<Image_Marker> createState() => _Image_MarkerState();
}

class _Image_MarkerState extends State<Image_Marker> {


  final Completer<GoogleMapController> _controller = Completer();

  static const CameraPosition _Kgoogle = CameraPosition(
      target: LatLng(25.508004296050956, 69.0108387676061),
      zoom: 14);

  List<Marker> _marker = [];

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
   loadData();

  }

  void loadData() async{
    for (int i = 0; i < _latlong.length; i++) 
    {
      Uint8List? image = await loadNetworkImage('images/elonp.jpg');
      final ui.Codec markerImagecodec = await ui.instantiateImageCodec(
        image.buffer.asUint8List(),
        targetHeight: 100,
        targetWidth: 100
      );

      final ui.FrameInfo imageFrameInfo = await markerImagecodec.getNextFrame();
      final ByteData? byteData = await imageFrameInfo.image.toByteData(
        format: ui.ImageByteFormat.png
      );

      final Uint8List resized = byteData!.buffer.asUint8List();

      _marker.add(
          Marker(markerId: MarkerId('1'),
              position: _latlong[i],
              icon: BitmapDescriptor.fromBytes(resized),
              infoWindow: InfoWindow(
                  title: 'Current Location', snippet: '5 Star')
          ));
      setState(() {

      });
    }
  }

  Future<Uint8List> loadNetworkImage(String imgpath)async{
  final completer =Completer<ImageInfo>();
  var image = AssetImage(imgpath);
  
  image.resolve(ImageConfiguration()).addListener(
    ImageStreamListener((info,_) =>completer.complete(info))
  );


  final imageinfo = await completer.future;
  final byteData = await imageinfo.image.toByteData(format: ui.ImageByteFormat.png);

  return byteData!.buffer.asUint8List();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GoogleMap(
          initialCameraPosition: _Kgoogle,
          mapType: MapType.normal,
          markers:Set<Marker>.of(_marker),

        ),
      ),
    );
  }
}




