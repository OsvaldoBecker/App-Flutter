import 'package:AppFlutter/domain/client.dart';
import 'package:AppFlutter/services/clientService.dart';
import 'package:AppFlutter/util/toastDialog.dart';
import 'package:flutter/material.dart';

class ClientCreatePage extends StatefulWidget {
  ClientCreatePage({Key key}) : super(key: key);

  final ClientService clientService = new ClientService();

  @override
  _ClientCreatePageState createState() => _ClientCreatePageState();
}

class _ClientCreatePageState extends State<ClientCreatePage> {
  final _formKey = GlobalKey<FormState>();

  Client client;
  List<Client> clients = new List();

  @override
  void initState() {
    super.initState();
    _getClients();
    setState(() {
      client = new Client();
    });
  }

  void _getClients() {
    widget.clientService.getAll().then((value) => {
          setState(() {
            clients = value;
          })
        });
  }

  void _save() {
    if (_canUseCurrentEmail(client)) {
      widget.clientService
          .insertClient(client)
          .then((value) =>
              {ToastDialog.show('Saved!'), Navigator.pop(context, 'Saved')})
          .catchError((err) => {print(err)});
    } else {
      ToastDialog.show('There is already a client with that email!');
    }
  }

  void _cancel() {
    ToastDialog.show('Canceled!');
    Navigator.pop(context, 'Canceled');
  }

  bool _canUseCurrentEmail(Client client) {
    for (var other in clients) {
      if (other.email == client.email) return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Client Creating'),
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
                  keyboardType: TextInputType.text,
                  maxLength: 35,
                  decoration: InputDecoration(
                    icon: Icon(Icons.person),
                    border: OutlineInputBorder(),
                    labelText: 'Type the name',
                  ),
                  onChanged: (text) {
                    client.name = text;
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Name is required!';
                    }
                    return null;
                  }),
              SizedBox(height: 15),
              TextFormField(
                  keyboardType: TextInputType.text,
                  maxLength: 35,
                  decoration: InputDecoration(
                    icon: Icon(Icons.email),
                    border: OutlineInputBorder(),
                    labelText: 'Type the email',
                  ),
                  onChanged: (text) {
                    client.email = text;
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Email is required!';
                    }
                    return null;
                  }),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    icon: Icon(Icons.save),
                    label: Text('Save'),
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        _save();
                      }
                    },
                  ),
                  SizedBox(width: 20),
                  ElevatedButton.icon(
                    icon: Icon(Icons.cancel),
                    label: Text('Cancel'),
                    onPressed: () {
                      _cancel();
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
