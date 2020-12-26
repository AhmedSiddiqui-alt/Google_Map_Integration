import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import './screens/home.dart';
import './screens/manage_user_screen.dart';
import './provider/user_provider.dart';
import './screens/show_userdata_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String srchAdd;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider.value(value: UserProvider())],
      child: MaterialApp(
        home: ManageUserScreen(),
      ),
    );
  }
}
