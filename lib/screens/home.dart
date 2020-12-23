import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoder/geocoder.dart';

// import 'package:flutter_google_places/flutter_google_places.dart';
// import 'package:google_maps_webservice/places.dart';
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

double longitude;
double latitude;

class _HomeState extends State<Home> {
  //  Location location = new Location();
  CameraPosition _initialPosition =
      CameraPosition(target: LatLng(24.8607, 67.0011), zoom: 20);
  GoogleMapController _controller;
  final List<Marker> marker = [];
  void add(cordinate) {
    setState(() {
      // int id = Random().nextInt(100);
      longitude = 0;
      latitude = 0;
      marker.add(Marker(position: cordinate, markerId: MarkerId('M1')));
    });
  }

  String srchAdd;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          floatingActionButton: Container(
            height: 260,
            width: 120,
            alignment: Alignment.bottomRight,
            child: Column(
              children: <Widget>[
                FloatingActionButton(
                    child: Icon(Icons.zoom_in),
                    onPressed: () {
                      _controller.animateCamera(CameraUpdate.zoomIn());
                    }),
                FloatingActionButton(
                    child: Icon(Icons.zoom_out),
                    onPressed: () {
                      _controller.animateCamera(CameraUpdate.zoomOut());
                    }),
                FloatingActionButton(
                    child: Icon(Icons.location_off),
                    onPressed: () {
                      setState(() {
                        // longitude = 0;
                        // latitude = 0;
                        marker.removeWhere((mid) => 'M1' == mid.markerId.value);
                      });
                    }),
                FloatingActionButton(
                    child: Icon(Icons.location_on),
                    onPressed: () async {
                      double longitude;
                      double latitude;
                      // var fetchCordinates;
                      //  fetchCordinates=marker.firstWhere((mid) => 'M1'==mid.markerId.value);
                      if (marker.isNotEmpty) {
                        longitude = marker[0].position.longitude;
                        latitude = marker[0].position.latitude;
                        final coordinates =
                            new Coordinates(latitude, longitude);
                        var address = await Geocoder.local
                            .findAddressesFromCoordinates(coordinates);
                        var first = address.first;
                        print(
                            ' ${first.locality}, ${first.adminArea},${first.subLocality}, ${first.subAdminArea},${first.addressLine}, ${first.featureName},${first.thoroughfare}, ${first.subThoroughfare}');
                        print('Longitude' + longitude.toString());
                        print('Latitude' + latitude.toString());
                      } else {
                        print('Null');
                      }
                    }),
                // FloatingActionButton(
                // child: Icon(Icons.location_off),
                // onPressed: () {
                //   marker.remove(Marker(position: )));
                // }),
              ],
            ),
          ),
          appBar: AppBar(
            title: Text('Google Map'),
          ),
          body: Stack(children: <Widget>[
            GoogleMap(
              compassEnabled: true,
              trafficEnabled: true,
              markers: marker.toSet(),
              zoomControlsEnabled: false,
              mapType: MapType.normal,
              initialCameraPosition: _initialPosition,
              onLongPress: (coordinate) {},
              onMapCreated: (controller) {
                setState(() {
                  _controller = controller;
                });
              },
              onTap: (coordinates) {
                _controller.animateCamera(CameraUpdate.newLatLng(coordinates));
                add(coordinates);
              },
            ),
            Positioned(
              child: Container(
                padding: EdgeInsets.all(20),
                height: 120,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: 
                TextField(
                    maxLines: 2,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                          icon: Icon(Icons.search),
                          onPressed: () async {
                            Geolocator()
                                .placemarkFromAddress(srchAdd)
                                .then((value) {
                              _controller.animateCamera(
                                  CameraUpdate.newCameraPosition(CameraPosition(
                                      target: LatLng(value[0].position.latitude,
                                          value[0].position.longitude),
                                      zoom: 10)));
                            });
                          }),
                      hintText: 'Enter Your Address',
                    ),
                    onChanged: (val) {
                      setState(() {
                        srchAdd = val;
                      });
                    }),
              ),
            )
          ])),
    );
  }
}
