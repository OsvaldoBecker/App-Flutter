import 'package:flutter/material.dart';

class ImcPage extends StatefulWidget {
  ImcPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ImcPageState createState() => _ImcPageState();
}

TextEditingController heightController = new TextEditingController();
TextEditingController weightController = new TextEditingController();

class _ImcPageState extends State<ImcPage> {
  int _imc = 0;

  void _calculateIMC() {
    setState(() {
      double height = double.parse(heightController.text);
      double weight = double.parse(weightController.text);
      double imc = weight / (height * height);
      _imc = imc.toInt();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                'Height in meters',
                style: Theme.of(context).textTheme.headline5,
              ),
              SizedBox(height: 10),
              TextField(
                controller: heightController,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), hintText: 'Enter the height'),
              ),
              SizedBox(height: 20),
              Text(
                'Weight in kilograms',
                style: Theme.of(context).textTheme.headline5,
              ),
              SizedBox(height: 10),
              TextField(
                controller: weightController,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), hintText: 'Enter the weight'),
              ),
              SizedBox(height: 20),
              Text(
                'Your IMC: $_imc',
                style: Theme.of(context).textTheme.headline4,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _calculateIMC,
        tooltip: 'Calculate',
        child: Icon(Icons.calculate),
      ),
    );
  }
}
