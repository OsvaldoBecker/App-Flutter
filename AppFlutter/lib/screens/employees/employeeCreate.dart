import 'package:AppFlutter/domain/employee.dart';
import 'package:AppFlutter/services/employeeService.dart';
import 'package:AppFlutter/util/toastDialog.dart';
import 'package:flutter/material.dart';

class EmployeeCreatePage extends StatefulWidget {
  EmployeeCreatePage({Key key}) : super(key: key);

  final EmployeeService employeeService = new EmployeeService();

  @override
  _EmployeeCreatePageState createState() => _EmployeeCreatePageState();
}

class _EmployeeCreatePageState extends State<EmployeeCreatePage> {
  final _formKey = GlobalKey<FormState>();

  Employee employee;
  List<Employee> employees = new List();

  @override
  void initState() {
    super.initState();
    _getEmployees();
    setState(() {
      employee = new Employee();
    });
  }

  void _getEmployees() {
    widget.employeeService.getAll().then((value) => {
          setState(() {
            employees = value;
          })
        });
  }

  void _save() {
    if (_canUseCurrentEmail(employee)) {
      widget.employeeService
          .insertEmployee(employee)
          .then((value) =>
              {ToastDialog.show('Saved!'), Navigator.pop(context, 'Saved')})
          .catchError((err) => {print(err)});
    } else {
      ToastDialog.show('There is already a employee with that email!');
    }
  }

  void _cancel() {
    ToastDialog.show('Saved!');
    Navigator.pop(context, 'Canceled');
  }

  bool _canUseCurrentEmail(Employee employee) {
    for (var other in employees) {
      if (other.email == employee.email) return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Employee Creating'),
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
                    employee.name = text;
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
                    employee.email = text;
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Email is required!';
                    }
                    return null;
                  }),
              SizedBox(height: 15),
              TextFormField(
                  keyboardType: TextInputType.text,
                  maxLength: 35,
                  decoration: InputDecoration(
                    icon: Icon(Icons.handyman),
                    border: OutlineInputBorder(),
                    labelText: 'Type the skills',
                  ),
                  onChanged: (text) {
                    employee.skills = text;
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Skills is required!';
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
