import 'package:AppFlutter/domain/user.dart';
import 'package:AppFlutter/services/userService.dart';
import 'package:flutter/material.dart';

class UserCreatePage extends StatefulWidget {
  UserCreatePage({Key key}) : super(key: key);

  final UserService userService = new UserService();

  @override
  _UserCreatePageState createState() => _UserCreatePageState();
}

class _UserCreatePageState extends State<UserCreatePage> {
  final _formKey = GlobalKey<FormState>();

  User user;

  @override
  void initState() {
    super.initState();
    setState(() {
      user = new User();
    });
  }

  void _save() {
    widget.userService
        .insertUser(user)
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
        title: Text('User Creating'),
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
                  onChanged: (text) {
                    user.name = text;
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Name is required!';
                    }
                    return null;
                  }),
              SizedBox(height: 10),
              TextFormField(
                  keyboardType: TextInputType.text,
                  maxLength: 50,
                  decoration: InputDecoration(
                    icon: Icon(Icons.email),
                    border: OutlineInputBorder(),
                    labelText: 'Type the email',
                  ),
                  onChanged: (text) {
                    user.email = text;
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Email is required!';
                    }
                    return null;
                  }),
              SizedBox(height: 10),
              TextFormField(
                  keyboardType: TextInputType.text,
                  maxLength: 13,
                  decoration: InputDecoration(
                    icon: Icon(Icons.call),
                    border: OutlineInputBorder(),
                    labelText: 'Type the cellphone',
                  ),
                  onChanged: (text) {
                    user.cellphone = text;
                  },
                  validator: (value) {
                    return null;
                  }),
              SizedBox(height: 10),
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
