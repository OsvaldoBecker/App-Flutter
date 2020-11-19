import 'package:AppFlutter/domain/employee.dart';
import 'package:AppFlutter/screens/employees/employeeCreate.dart';
import 'package:AppFlutter/screens/employees/employeeDetail.dart';
import 'package:AppFlutter/screens/employees/employeeEdit.dart';
import 'package:AppFlutter/services/employeeService.dart';
import 'package:AppFlutter/util/confirmDialog.dart';
import 'package:flutter/material.dart';

class EmployeesPage extends StatefulWidget {
  EmployeesPage({Key key, this.title}) : super(key: key);

  final String title;
  final EmployeeService employeeService = new EmployeeService();

  @override
  _EmployeesPageState createState() => _EmployeesPageState();
}

class _EmployeesPageState extends State<EmployeesPage> {
  List<Employee> employees = new List();

  @override
  void initState() {
    super.initState();
    _getEmployees();
  }

  void _getEmployees() {
    widget.employeeService.getAll().then((value) => {
          setState(() {
            employees = value;
          })
        });
  }

  void _detailEmployee(Employee employee) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
          builder: (context) => EmployeeDetailPage(employee: employee)),
    );
    _getEmployees();
  }

  void _createEmployee() async {
    await Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => EmployeeCreatePage()),
    );
    _getEmployees();
  }

  void _editEmployee(Employee employee) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
          builder: (context) => EmployeeEditPage(employee: employee)),
    );
    _getEmployees();
  }

  void _deleteEmployee(Employee employee) {
    ConfirmDialog.show(
      context,
      'Are you sure you want to delete?',
      () => ({
        widget.employeeService
            .deleteEmployee(employee)
            .then((value) => {_getEmployees()})
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
          children: employees
              .map((data) => ListTile(
                    leading: Icon(Icons.person),
                    title: Row(children: <Widget>[Text(data.name)]),
                    trailing: PopupMenuButton(
                      onSelected: (option) {
                        if (option == 'detail') {
                          _detailEmployee(data);
                        } else if (option == 'edit') {
                          _editEmployee(data);
                        } else {
                          _deleteEmployee(data);
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
        onPressed: _createEmployee,
        tooltip: 'Create employee',
        child: Icon(Icons.add),
      ),
    );
  }
}
