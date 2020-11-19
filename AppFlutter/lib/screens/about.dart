import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  AboutPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                  'Android application for managing customers, employees and projects.')
            ],
          ),
        ),
      ),
    );
  }
}
