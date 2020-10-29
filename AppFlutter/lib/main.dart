import 'package:AppFlutter/screens/home.dart';
import 'package:AppFlutter/screens/imc.dart';
import 'package:AppFlutter/screens/press.dart';
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
          '/imc': (context) => ImcPage(
                title: "IMC calculator",
              ),
          '/press': (context) => PressPage(
                title: "Press counter",
              ),
          '/about': (context) => AboutPage(
                title: "About",
              ),
        });
  }
}
