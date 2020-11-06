import 'package:AppFlutter/domain/user.dart';
import 'package:AppFlutter/screens/users/userCreate.dart';
import 'package:AppFlutter/screens/users/userEdit.dart';
import 'package:AppFlutter/services/userService.dart';
import 'package:AppFlutter/util/confirmDialog.dart';
import 'package:flutter/material.dart';

class UsersPage extends StatefulWidget {
  UsersPage({Key key, this.title}) : super(key: key);

  final String title;
  final UserService userService = new UserService();

  @override
  _UsersPageState createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  List<User> users = new List();

  @override
  void initState() {
    super.initState();
    _getUsers();
  }

  void _getUsers() {
    widget.userService.getAll().then((value) => {
          setState(() {
            users = value;
          })
        });
  }

  void _createUser() async {
    await Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => UserCreatePage()),
    );
    _getUsers();
  }

  void _editUser(User user) async {
    await Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => UserEditPage(user: user)),
    );
    _getUsers();
  }

  void _deleteUser(User user) {
    ConfirmDialog.show(
      context,
      'Are you sure you want to delete?',
      () => ({
        widget.userService
            .deleteUser(user)
            .then((value) => {_getUsers()})
            .catchError((e) => {
                  //Dialog.showAlertDialog(context, e.toString())
                })
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
          children: users
              .map((data) => ListTile(
                    leading: Icon(Icons.person),
                    title: Row(children: <Widget>[
                      Text(data.name.toString()),
                      Spacer(),
                      Text(data.cellphone.toString()),
                    ]),
                    trailing: PopupMenuButton(
                      onSelected: (option) {
                        if (option == 'edit') {
                          _editUser(data);
                        } else {
                          _deleteUser(data);
                        }
                      },
                      itemBuilder: (context) => [
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
        onPressed: _createUser,
        tooltip: 'Create user',
        child: Icon(Icons.add),
      ),
    );
  }
}
