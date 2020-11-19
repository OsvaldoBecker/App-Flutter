import 'package:AppFlutter/screens/clients/clients.dart';
import 'package:AppFlutter/screens/employees/employees.dart';
import 'package:AppFlutter/screens/projects/projects.dart';
import 'package:AppFlutter/screens/home.dart';
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
        home: HomePage(title: 'Company Management'),
        routes: {
          '/clients': (context) => ClientsPage(
                title: "Clients",
              ),
          '/employees': (context) => EmployeesPage(
                title: "Employees",
              ),
          '/projects': (context) => ProjectsPage(
                title: "Projects",
              ),
          '/about': (context) => AboutPage(
                title: "About",
              ),
        });
  }
}
