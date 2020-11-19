import 'package:AppFlutter/domain/client.dart';
import 'package:AppFlutter/screens/clients/clientCreate.dart';
import 'package:AppFlutter/screens/clients/clientDetail.dart';
import 'package:AppFlutter/screens/clients/clientEdit.dart';
import 'package:AppFlutter/services/clientService.dart';
import 'package:AppFlutter/util/confirmDialog.dart';
import 'package:flutter/material.dart';

class ClientsPage extends StatefulWidget {
  ClientsPage({Key key, this.title}) : super(key: key);

  final String title;
  final ClientService clientService = new ClientService();

  @override
  _ClientsPageState createState() => _ClientsPageState();
}

class _ClientsPageState extends State<ClientsPage> {
  List<Client> clients = new List();

  @override
  void initState() {
    super.initState();
    _getClients();
  }

  void _getClients() {
    widget.clientService.getAll().then((value) => {
          setState(() {
            clients = value;
          })
        });
  }

  void _detailClient(Client client) async {
    await Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => ClientDetailPage(client: client)),
    );
    _getClients();
  }

  void _createClient() async {
    await Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => ClientCreatePage()),
    );
    _getClients();
  }

  void _editClient(Client client) async {
    await Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => ClientEditPage(client: client)),
    );
    _getClients();
  }

  void _deleteClient(Client client) {
    ConfirmDialog.show(
      context,
      'Are you sure you want to delete?',
      () => ({
        widget.clientService
            .deleteClient(client)
            .then((value) => {_getClients()})
            .catchError((e) => {print(e.toString())})
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: ListView(
          padding: EdgeInsets.all(10.0),
          scrollDirection: Axis.vertical,
          children: clients
              .map((data) => ListTile(
                    leading: Icon(Icons.person),
                    title: Row(children: <Widget>[Text(data.name)]),
                    trailing: PopupMenuButton(
                      onSelected: (option) {
                        if (option == 'detail') {
                          _detailClient(data);
                        } else if (option == 'edit') {
                          _editClient(data);
                        } else {
                          _deleteClient(data);
                        }
                      },
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          value: 'detail',
                          child: Row(children: [
                            Icon(Icons.info),
                            SizedBox(width: 10),
                            Text('Detail'),
                          ]),
                        ),
                        PopupMenuItem(
                          value: 'edit',
                          child: Row(children: [
                            Icon(Icons.edit),
                            SizedBox(width: 10),
                            Text('Edit'),
                          ]),
                        ),
                        PopupMenuItem(
                          value: 'delete',
                          child: Row(children: [
                            Icon(Icons.delete),
                            SizedBox(width: 10),
                            Text('Delete'),
                          ]),
                        ),
                      ],
                    ),
                  ))
              .toList(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _createClient,
        tooltip: 'Create client',
        child: Icon(Icons.add),
      ),
    );
  }
}
