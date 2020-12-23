import 'package:flutter/cupertino.dart';

import '../models/user.dart';

class UserProvider with ChangeNotifier {
  List<User> _userData = [];
  List<User> get userData {
    return [..._userData];
  }
}
