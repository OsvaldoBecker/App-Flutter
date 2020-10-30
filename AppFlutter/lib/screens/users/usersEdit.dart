import 'package:AppFlutter/domain/user.dart';
import 'package:AppFlutter/services/userService.dart';
import 'package:flutter/material.dart';

class UsersEditPage extends StatefulWidget {
  UsersEditPage({Key key, this.user}) : super(key: key);

  final User user;
  final UserService userService = new UserService();

  @override
  _UsersEditPageState createState() => _UsersEditPageState();
}

class _UsersEditPageState extends State<UsersEditPage> {
  final _formKey = GlobalKey<FormState>();

  User user;

  @override
  void initState() {
    super.initState();
    setState(() {
      user = widget.user;
    });
  }

  void _save() {
    widget.userService
        .updateUser(user)
        .then((value) => {Navigator.pop(context, 'Saved')})
        .catchError((err) => {print(err)});
  }

  void _cancel() {
    Navigator.pop(context, 'Canceled');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Editing'),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                  keyboardType: TextInputType.text,
                  maxLength: 50,
                  decoration: InputDecoration(
                    icon: Icon(Icons.person),
                    border: OutlineInputBorder(),
                    labelText: 'Type the name',
                  ),
                  initialValue: user.name,
                  onChanged: (text) {
                    user.name = text;
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Name is required!';
                    }
                    return null;
                  }),
              TextFormField(
                  keyboardType: TextInputType.text,
                  maxLength: 50,
                  decoration: InputDecoration(
                    icon: Icon(Icons.person),
                    border: OutlineInputBorder(),
                    labelText: 'Type the cellphone',
                  ),
                  initialValue: user.cellphone,
                  onChanged: (text) {
                    user.cellphone = text;
                  },
                  validator: (value) {
                    return null;
                  }),
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
