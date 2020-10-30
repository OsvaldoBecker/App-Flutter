import 'package:AppFlutter/domain/user.dart';
import 'package:AppFlutter/screens/users/usersEdit.dart';
import 'package:AppFlutter/services/userService.dart';
import 'package:flutter/material.dart';

class UsersListPage extends StatefulWidget {
  UsersListPage({Key key, this.title}) : super(key: key);

  final String title;
  final UserService userService = new UserService();

  @override
  _UsersListPageState createState() => _UsersListPageState();
}

class _UsersListPageState extends State<UsersListPage> {
  List<User> users = new List();

  @override
  void initState() {
    super.initState();
    _getUsers();

    print(users.length);
  }

  void _getUsers() {
    widget.userService.getAll().then((value) => {
          setState(() {
            users = value;
          })
        });
  }

  void _includeUser() {
    setState(() {});
  }

  void _editUser(User user) async {
    await Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => UsersEditPage(user: user)),
    );
    _getUsers();
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
                    onTap: () => _editUser(data),
                  ))
              .toList(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _includeUser,
        tooltip: 'Include user',
        child: Icon(Icons.add),
      ),
    );
  }
}
