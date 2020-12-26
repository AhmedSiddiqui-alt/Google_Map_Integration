import 'package:flutter/cupertino.dart';

import '../models/user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserProvider with ChangeNotifier {
  List<User> _userData = [];
  List<User> get userData {
    return [..._userData];
  }

  Future<void> addUsers(
      User newUser, String markerId, String longitude, String latitude) async {
    const url =
        'https://map-integration-a476d-default-rtdb.firebaseio.com/Users.json';
    try {
      final response = await http.post(url,
          body: json.encode({
            'MarkerKey': markerId,
            'FirstName': newUser.firstName,
            'LastName': newUser.lastName,
            'Address': newUser.address,
            'Longitude': longitude,
            'Latitude': latitude
          }));
      notifyListeners();
    } catch (error) {
      throw Exception(error);
    }
  }
}
