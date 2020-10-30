import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text('Home', style: Theme.of(context).textTheme.headline4),
              SizedBox(height: 20),
              RaisedButton(
                child: Text('Users'),
                onPressed: () {
                  Navigator.of(context).pushNamed('/users');
                },
              ),
              RaisedButton(
                child: Text('About'),
                onPressed: () {
                  Navigator.of(context).pushNamed('/about');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
