import 'package:flutter/material.dart';

class PressPage extends StatefulWidget {
  PressPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _PressPageState createState() => _PressPageState();
}

class _PressPageState extends State<PressPage> {
  int _pressed = 0;

  void _incrementPressed() {
    setState(() {
      _pressed++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Pressed times: $_pressed',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementPressed,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
