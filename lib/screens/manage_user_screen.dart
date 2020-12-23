import 'package:flutter/material.dart';
import '../models/user.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoder/geocoder.dart';

class ManageUserScreen extends StatefulWidget {
  @override
  _ManageUserScreenState createState() => _ManageUserScreenState();
}

class _ManageUserScreenState extends State<ManageUserScreen> {
  GoogleMapController _controller;
// _controller.setMapStyle('assets/dark.json');

  double lng;
  double lt;
  double longitude;
  double latitude;
  var manageData = User(
      id: null,
      markerId: null,
      firstName: null,
      lastName: null,
      address: null,
      markerInfoWindow: null,
      longitude: null,
      latitude: null);
  final Formkey = GlobalKey<FormState>();
  List<Marker> marker = [];
  void addMarker(var coordinate) {
    setState(() {
      longitude = 0;
      latitude = 0;
      marker.add(Marker(position: coordinate, markerId: MarkerId('M1')));
    });
  }

  @override
  Widget build(BuildContext context) {
    CameraPosition _initialPosition =
        CameraPosition(target: LatLng(24.8607, 67.0011), zoom: 20);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Manage Data'),
        backgroundColor: Colors.pink[500],
      ),
      body: SingleChildScrollView(
          child: Container(
        margin: EdgeInsets.all(20),
        height: 850,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: []),
        child: Form(
            key: Formkey,
            child: Column(
              children: [
                Card(
                  elevation: 5,
                  child: Container(
                      color: Colors.white,
                      margin: EdgeInsets.all(20),
                      child: TextFormField(
                        decoration: InputDecoration(labelText: 'First Name'),
                        onSaved: (val) {
                          manageData = User(
                              id: manageData.id,
                              markerId: manageData.markerId,
                              firstName: val,
                              lastName: manageData.lastName,
                              address: manageData.address,
                              markerInfoWindow: manageData.markerInfoWindow,
                              longitude: manageData.longitude,
                              latitude: manageData.latitude);
                        },
                      )),
                ),
                Card(
                  elevation: 5,
                  child: Container(
                      color: Colors.white,
                      margin: EdgeInsets.all(20),
                      child: TextFormField(
                        decoration: InputDecoration(labelText: 'Last Name'),
                        onSaved: (val) {
                          manageData = User(
                              id: manageData.id,
                              markerId: manageData.markerId,
                              firstName: manageData.firstName,
                              lastName: val,
                              address: manageData.address,
                              markerInfoWindow: manageData.markerInfoWindow,
                              longitude: manageData.longitude,
                              latitude: manageData.latitude);
                        },
                      )),
                ),
                Container(
                    margin: EdgeInsets.all(5),
                    child: Card(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              width: 100,
                              child: TextField(
                                decoration:
                                    InputDecoration(labelText: 'Longitude'),
                                onChanged: (val) {
                                  setState(() {
                                    lng = double.parse(val);
                                  });
                                },
                              ),
                            ),
                          ),
                          Expanded(
                              child: Container(
                            width: 100,
                            child: TextField(
                              decoration:
                                  InputDecoration(labelText: 'Latitude'),
                              onChanged: (val) {
                                setState(() {
                                  lt = double.parse(val);
                                });
                              },
                            ),
                          )),
                        ],
                      ),
                    ))
                // Card(
                //   elevation: 6,
                //   child: Container(
                //     margin: EdgeInsets.all(10),
                //     child: TextField(
                //         maxLines: 2,
                //         decoration: InputDecoration(
                //           labelText: 'Search Polling Station',
                //           suffixIcon: IconButton(
                //               icon: Icon(Icons.search),
                // onPressed: () async {
                //   Geolocator()
                //       .placemarkFromCoordinates()
                //       .then((value) {
                //     _controller.animateCamera(
                //         CameraUpdate.newCameraPosition(
                //             CameraPosition(
                //                 target: LatLng(
                //                     value[0].position.latitude,
                //                     value[0].position.longitude),
                //                 zoom: 10)));
                //   });
                // }),
                //           hintText: 'Enter Your Address',
                //         ),
                //         onChanged: (val) {
                //           setState(() {
                //             searchAddress = val;
                //           });
                //         }),
                //   ),
                // ),
                ,
                Stack(
                  children: <Widget>[
                    Card(
                        elevation: 6,
                        child: Container(
                            margin: EdgeInsets.all(10),
                            height: 400,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: GoogleMap(
                                mapType: MapType.normal,
                                markers: marker.toSet(),
                                trafficEnabled: true,
                                onMapCreated: (controller) {
                                  // controller.setMapStyle('assets/dark.json');
                                  setState(() {
                                    _controller = controller;
                                  });
                                },
                                onTap: (coordinates) {
                                  _controller.animateCamera(
                                      CameraUpdate.newLatLng(coordinates));
                                  addMarker(coordinates);
                                },
                                compassEnabled: true,
                                initialCameraPosition: _initialPosition,
                              ),
                            ))),
                    Positioned(
                        bottom: 20,
                        left: 160,
                        child: Container(
                            decoration: BoxDecoration(
                                color: Colors.pink[500],
                                borderRadius: BorderRadius.circular(40)),
                            child: IconButton(
                                iconSize: 30,
                                icon: Icon(Icons.location_off),
                                onPressed: () {
                                  setState(() {
                                    marker.removeWhere((element) =>
                                        'M1' == element.markerId.value);
                                    // longitude = 0;
                                    // latitude = 0;
                                  });
                                }))),
                    Positioned(
                        bottom: 20,
                        left: 90,
                        child: Container(
                            decoration: BoxDecoration(
                                color: Colors.pink[500],
                                borderRadius: BorderRadius.circular(40)),
                            child: IconButton(
                                iconSize: 30,
                                icon: Icon(Icons.location_on),
                                onPressed: () async {
                                  if (marker.isNotEmpty) {
                                    longitude = marker[0].position.longitude;
                                    latitude = marker[0].position.latitude;
                                    print(marker[0].position.longitude);
                                    final coordinates =
                                        new Coordinates(latitude, longitude);
                                    var address = await Geocoder.local
                                        .findAddressesFromCoordinates(
                                            coordinates);
                                    print('Longitude' + longitude.toString());
                                    print('Latitude' + latitude.toString());
                                    showDialog(
                                        context: context,
                                        builder: (ctx) {
                                          return AlertDialog(
                                            content: Text('${address.first.locality}' +
                                                '\n' +
                                                '${address.first.adminArea}'
                                                    '${address.first.subLocality}' +
                                                '\n' +
                                                '${address.first.subAdminArea}'
                                                    '${address.first.addressLine}' +
                                                '\n' +
                                                '${address.first.featureName}'
                                                    '${address.first.thoroughfare}' +
                                                '\n' +
                                                '${address.first.subThoroughfare}'),
                                          );
                                        });
                                    // var first = address.first;
                                    // print('Locality' + first.locality);
                                    // print('Admin Area ' + first.adminArea);
                                    // print('SubLocality' + first.subLocality);
                                    // print('SubAdminArea' + first.subAdminArea);
                                    // print('AddressLine' + first.addressLine);
                                    // print('FeautureName' + first.featureName);
                                    // print('Through Fare' + first.thoroughfare);
                                    // print('Sub Through Fare' +
                                    //     first.subThoroughfare);

                                    // print(
                                    //     ' ${first.locality}, ${first.adminArea},${first.subLocality}, ${first.subAdminArea},${first.addressLine}, ${first.featureName},${first.thoroughfare}, ${first.subThoroughfare}');

                                  } else {
                                    print('Null');
                                  }
                                })))
                  ],
                ),
                Container(
                  margin: EdgeInsets.all(5),
                  height: 80,
                  decoration: BoxDecoration(
                      color: Colors.pink[500],
                      borderRadius: BorderRadius.circular(45)),
                  child: FlatButton(
                      child: Text('Search My Location',
                          style: TextStyle(color: Colors.white, fontSize: 15)),
                      onPressed: () async {
                        Geolocator()
                            .placemarkFromCoordinates(lng, lt)
                            .then((value) {
                          _controller.animateCamera(
                              CameraUpdate.newCameraPosition(CameraPosition(
                                  target: LatLng(value[0].position.latitude,
                                      value[0].position.longitude),
                                  zoom: 17)));
                        });
                      }),
                )
              ],
            )),
      )),
    );
  }
}