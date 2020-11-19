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
              child: Text('Options'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Clients'),
              onTap: () {
                Navigator.of(context).pushNamed('/clients');
              },
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Employees'),
              onTap: () {
                Navigator.of(context).pushNamed('/employees');
              },
            ),
            ListTile(
              leading: Icon(Icons.table_view),
              title: Text('Projects'),
              onTap: () {
                Navigator.of(context).pushNamed('/projects');
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
          padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text('Click the button to open the options',
                  style: Theme.of(context).textTheme.headline4),
            ],
          ),
        ),
      ),
    );
  }
}
