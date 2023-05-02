import 'package:flutter/material.dart';
import 'package:google_map/add_marker.dart';
import 'package:google_map/current_location.dart';
import 'package:google_map/custom_image_marker.dart';
import 'package:google_map/home_screen.dart';
import 'package:google_map/latlng_to_address.dart';
import 'package:google_map/map_style.dart';
import 'package:google_map/marker_demo.dart';
import 'package:google_map/plygon_screen.dart';
import 'package:google_map/polyline_screen.dart';
import 'package:google_map/search_location.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Map_Style_Mode(),
    );
  }
}
