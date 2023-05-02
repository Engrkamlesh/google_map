import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Map_Style_Mode extends StatefulWidget {
  const Map_Style_Mode({Key? key}) : super(key: key);

  @override
  State<Map_Style_Mode> createState() => _Map_Style_ModeState();
}

class _Map_Style_ModeState extends State<Map_Style_Mode> {

  final Completer<GoogleMapController> _controller = Completer();

  static const CameraPosition _Kgoogle = CameraPosition(
      target: LatLng(25.508004296050956, 69.0108387676061),
      zoom: 14);
  String maptheme = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DefaultAssetBundle.of(context).loadString('Asset/night_theme.json').then((value){
      maptheme = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Style_Map'),
      actions: [
        PopupMenuButton(itemBuilder: (context) =>[
          PopupMenuItem(
            onTap: (){
              _controller.future.then((value) {
                DefaultAssetBundle.of(context).loadString('Asset/sliver_theme.json').then((string){
                  value.setMapStyle(string);
                });
              });
            },
            child: Text('Sliver Mode'),
          ),
          PopupMenuItem(
            onTap: (){
              _controller.future.then((value) {
                DefaultAssetBundle.of(context).loadString('Asset/night_theme.json').then((string){
                  value.setMapStyle(string);
                });
              });
            },
            child: Text('Night Mode'),
          ),
          PopupMenuItem(
            onTap: (){
              _controller.future.then((value) {
                DefaultAssetBundle.of(context).loadString('Asset/retro_theme.json').then((string){
                  value.setMapStyle(string);
                });
              });
            },
            child: Text('retro Mode'),
          )
        ]
        )
      ],),
      body: SafeArea(
        child: GoogleMap(
          initialCameraPosition: _Kgoogle,
          myLocationButtonEnabled: true,
          onMapCreated: (GoogleMapController controller){
            controller.setMapStyle(maptheme);
            _controller.complete(controller);
          },


        ),
      ),
    );
  }
}
