import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';

class LatLng_to_Address extends StatefulWidget {
  const LatLng_to_Address({Key? key}) : super(key: key);

  @override
  State<LatLng_to_Address> createState() => _LatLng_to_AddressState();
}

class _LatLng_to_AddressState extends State<LatLng_to_Address> {
  String staddress = '', stAdd = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Google Map'),),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 100,
            width: 300,
            child: Center(child: Text(staddress,
              style: TextStyle(fontSize: 20, color: Colors.purple),),),),
          Container(
            height: 100,
            width: 300,
            child: Center(child: Text(stAdd,
              style: TextStyle(fontSize: 20, color: Colors.purple),),),),
          Center(child: FlatButton(
            onPressed: () async {
              List<Location> _location = await locationFromAddress("Islamabad, Pakistan");
              List<Placemark> _placemark = await placemarkFromCoordinates(33.6844, 73.0479);

              setState((){
                staddress ="Longitude : "+ _location.last.longitude.toString()+ "\nLatitude : " + _location.last.latitude.toString();
                stAdd ="Country : "+ _placemark.reversed.last.country.toString()+"\n Street : "+_placemark.reversed.last.subAdministrativeArea.toString();
              });
            },
            height: 50,
            minWidth: 300,
            color: Colors.greenAccent,
            child: Text("Convert"),),)
          // Center(child:
          // ignore: deprecated_member_use
          // FlatButton(
          //   color: Colors.greenAccent,
          //   minWidth: 200,
          //   height: 50,
          //   onPressed: ()async{
          //     final _coordinates = new Coordinates(24.8532, 67.0167);
          //     var address = await Geocoder.local.findAddressesFromCoordinates(_coordinates);
          //     var first = address.first;
          //
          //     print('address'+first.featureName.toString()+first.addressLine.toString());
          //
          //     setState((){
          //       staddress = first.featureName.toString()+first.addressLine.toString();
          //     });
          //   },
          //   child: Text('Convert'),
          // )),
        ],
      ),
    );
  }
}
