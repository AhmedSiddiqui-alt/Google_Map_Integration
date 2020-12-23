import 'package:flutter/foundation.dart';

class User {
  final String id;
  final String markerId;
  final String firstName;
  final String lastName;
  final String address;
  final String markerInfoWindow;
  final double longitude;
  final double latitude;
  User(
      {@required this.id,
      @required this.markerId,
      @required this.firstName,
      @required this.lastName,
      @required this.address,
      @required this.markerInfoWindow,
      @required this.longitude,
      @required this.latitude});
}
