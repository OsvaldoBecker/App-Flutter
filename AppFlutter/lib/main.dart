import 'package:AppFlutter/screens/home.dart';
import 'package:AppFlutter/screens/users/users.dart';
import 'package:AppFlutter/screens/about.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: HomePage(title: 'My Application'),
        routes: {
          '/home': (context) => HomePage(
                title: "Home",
              ),
          '/users': (context) => UsersPage(
                title: "Users",
              ),
          '/about': (context) => AboutPage(
                title: "About",
              ),
        });
  }
}
