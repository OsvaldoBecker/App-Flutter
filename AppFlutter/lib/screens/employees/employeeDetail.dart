import 'package:AppFlutter/domain/employee.dart';
import 'package:flutter/material.dart';

class EmployeeDetailPage extends StatefulWidget {
  EmployeeDetailPage({Key key, this.employee}) : super(key: key);

  final Employee employee;

  @override
  _EmployeeDetailPageState createState() => _EmployeeDetailPageState();
}

class _EmployeeDetailPageState extends State<EmployeeDetailPage> {
  final _formKey = GlobalKey<FormState>();

  Employee employee;

  @override
  void initState() {
    super.initState();
    setState(() {
      employee = widget.employee;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Employee Details'),
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
                  initialValue: employee.name),
              SizedBox(height: 15),
              TextFormField(
                  enabled: false,
                  decoration: InputDecoration(
                    icon: Icon(Icons.email),
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                  ),
                  initialValue: employee.email),
              SizedBox(height: 15),
              TextFormField(
                  enabled: false,
                  decoration: InputDecoration(
                    icon: Icon(Icons.handyman),
                    border: OutlineInputBorder(),
                    labelText: 'Skills',
                  ),
                  initialValue: employee.skills),
            ],
          ),
        ),
      ),
    );
  }
}
