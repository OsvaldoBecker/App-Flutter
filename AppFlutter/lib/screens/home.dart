import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child:
                  Text('Header', style: Theme.of(context).textTheme.headline4),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Users'),
              onTap: () {
                Navigator.of(context).pushNamed('/users');
              },
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: Text('About'),
              onTap: () {
                Navigator.of(context).pushNamed('/about');
              },
            ),
          ],
        ),
      ),
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
            ],
          ),
        ),
      ),
    );
  }
}
