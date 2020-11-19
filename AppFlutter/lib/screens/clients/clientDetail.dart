import 'package:AppFlutter/domain/client.dart';
import 'package:flutter/material.dart';

class ClientDetailPage extends StatefulWidget {
  ClientDetailPage({Key key, this.client}) : super(key: key);

  final Client client;

  @override
  _ClientDetailPageState createState() => _ClientDetailPageState();
}

class _ClientDetailPageState extends State<ClientDetailPage> {
  final _formKey = GlobalKey<FormState>();

  Client client;

  @override
  void initState() {
    super.initState();
    setState(() {
      client = widget.client;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Client Details'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 10),
              TextFormField(
                  enabled: false,
                  decoration: InputDecoration(
                    icon: Icon(Icons.person),
                    border: OutlineInputBorder(),
                    labelText: 'Name',
                  ),
                  initialValue: client.name),
              SizedBox(height: 15),
              TextFormField(
                  enabled: false,
                  decoration: InputDecoration(
                    icon: Icon(Icons.email),
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                  ),
                  initialValue: client.email)
            ],
          ),
        ),
      ),
    );
  }
}
