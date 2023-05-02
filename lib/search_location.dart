import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

class Search_Location extends StatefulWidget {
  const Search_Location({Key? key}) : super(key: key);

  @override
  State<Search_Location> createState() => _Search_LocationState();
}

class _Search_LocationState extends State<Search_Location> {
  TextEditingController _controllers = TextEditingController();
  var uid = Uuid();
  String _sessionToken = '12345';
  List<dynamic> _playlist = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controllers.addListener(() {
      onChange();
    });
  }

  void onChange(){
    if(_sessionToken == null){
      setState((){
        _sessionToken = uid.v4();
      });
    }
    getSuggestion(_controllers.text);
  }

  void getSuggestion(String input) async{
    String _kplace = "AIzaSyBDOlxO975iqixQcWW2zkNdvx05x7V_DXU";
    String baseUrl = "https://maps.googleapis.com/maps/api/place/autocomplete/json";
    String request = "$baseUrl?input=$input&key=$_kplace&sessiontoken=$_sessionToken";

    var response = await http.get(Uri.parse(request));
    // var data = response.body.toString();
    // print('data');
    print(response.body.toString());

    if(response.statusCode == 200){
      setState((){
        _playlist = jsonDecode(response.body.toString())['predictions'];
      });
    }else{
      throw Exception('Failed to load data');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Search Location'),),
      body:Padding(padding: EdgeInsets.symmetric(horizontal: 10,vertical: 20),
        child: Column(
        children: [
          TextFormField(
            controller: _controllers,
            decoration: InputDecoration(
              hintText: 'Search with Name',
              label: Text('Search with Name'),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))
            ),
          ),
          // Expanded(child: ListView.builder(
          //     itemCount: _playlist.length,
          //     itemBuilder: (context ,index){
          //   return ListTile(
          //     title: Text(_playlist[index]['description']),
          //   );
          // }))
        ],
      ),)
    );
  }
}
