import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_webservice/places.dart';
import './screens/home.dart';
import './screens/manage_user_screen.dart';
import './screens/show_userdata_screen.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  CameraPosition _initialPosition =
      CameraPosition(target: LatLng(24.8607, 67.0011), zoom: 20);
  GoogleMapController _controller;
  final List<Marker> marker = [];
  void add(cordinate) {
    setState(() {
      int id = Random().nextInt(100);
      marker
          .add(Marker(position: cordinate, markerId: MarkerId(id.toString())));
    });
  }

  String srchAdd;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    home: ManageUserScreen(),
    
    );
  }
}
