import 'package:AppFlutter/domain/client.dart';
import 'package:AppFlutter/domain/employee.dart';
import 'package:AppFlutter/domain/project.dart';
import 'package:AppFlutter/services/clientService.dart';
import 'package:AppFlutter/services/employeeService.dart';
import 'package:AppFlutter/services/projectService.dart';
import 'package:AppFlutter/util/toastDialog.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProjectCreatePage extends StatefulWidget {
  ProjectCreatePage({Key key}) : super(key: key);

  final ClientService clientService = new ClientService();
  final EmployeeService employeeService = new EmployeeService();
  final ProjectService projectService = new ProjectService();

  @override
  _ProjectCreatePageState createState() => _ProjectCreatePageState();
}

class _ProjectCreatePageState extends State<ProjectCreatePage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController beginDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  TextEditingController clientController = TextEditingController();
  TextEditingController responsibleController = TextEditingController();

  List clients;
  List employees;
  Project project;
  List<Project> projects = new List();

  @override
  void initState() {
    super.initState();
    setState(() {
      clients = new List();
      employees = new List();
      project = new Project();
      _getClients();
      _getEmployees();
      _getProjects();
    });
  }

  void _getClients() {
    widget.clientService.getAll().then((value) => {
          setState(() {
            clients = value;
          })
        });
  }

  void _getEmployees() {
    widget.employeeService.getAll().then((value) => {
          setState(() {
            employees = value;
          })
        });
  }

  void _getProjects() {
    widget.projectService.getAll().then((value) => {
          setState(() {
            projects = value;
          })
        });
  }

  Future<void> _selectClient() async {
    switch (await showDialog<Client>(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
              title: const Text('Select the client'),
              children: clients
                  .map((data) => SimpleDialogOption(
                        onPressed: () {
                          project.client = data;
                          clientController.text = data.name;
                          Navigator.pop(context, data);
                        },
                        child: Text(data.name),
                      ))
                  .toList());
        })) {
    }
  }

  Future<void> _selectResponsible() async {
    switch (await showDialog<Employee>(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
              title: const Text('Select the responsible'),
              children: employees
                  .map((data) => SimpleDialogOption(
                        onPressed: () {
                          project.responsible = data;
                          responsibleController.text = data.name;
                          Navigator.pop(context, data);
                        },
                        child: Text(data.name),
                      ))
                  .toList());
        })) {
    }
  }

  void _save() {
    if (_canUseCurrentTitle(project)) {
      widget.projectService
          .insertProject(project)
          .then((value) =>
              {ToastDialog.show('Saved!'), Navigator.pop(context, 'Saved')})
          .catchError((err) => {print(err)});
    } else {
      ToastDialog.show('There is already a projects with that title!');
    }
  }

  void _cancel() {
    ToastDialog.show('Canceled!');
    Navigator.pop(context, 'Canceled');
  }

  bool _canUseCurrentTitle(Project project) {
    for (var other in projects) {
      if (other.title == project.title) return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Project Creating'),
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
                    icon: Icon(Icons.title),
                    border: OutlineInputBorder(),
                    labelText: 'Type the title',
                  ),
                  onChanged: (text) {
                    project.title = text;
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Title is required!';
                    }
                    return null;
                  }),
              SizedBox(height: 15),
              TextFormField(
                  keyboardType: TextInputType.text,
                  maxLength: 35,
                  decoration: InputDecoration(
                    icon: Icon(Icons.description),
                    border: OutlineInputBorder(),
                    labelText: 'Type the description',
                  ),
                  onChanged: (text) {
                    project.description = text;
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Description is required!';
                    }
                    return null;
                  }),
              SizedBox(height: 15),
              TextFormField(
                  controller: beginDateController,
                  onTap: () {
                    showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime(2050))
                        .then((date) {
                      if (project.endDate != null) {
                        if (date.isBefore(project.endDate)) {
                          beginDateController.text =
                              new DateFormat("yyyy-MM-dd").format(date);
                          project.beginDate = date.toUtc();
                        } else {
                          ToastDialog.show(
                              'The begin date must be before the end date!');
                        }
                      } else {
                        beginDateController.text =
                            new DateFormat("yyyy-MM-dd").format(date);
                        project.beginDate = date.toUtc();
                      }
                    });
                  },
                  readOnly: true,
                  maxLength: 35,
                  decoration: InputDecoration(
                    icon: Icon(Icons.date_range),
                    border: OutlineInputBorder(),
                    labelText: 'Select the begin date',
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Begin date is required!';
                    }
                    return null;
                  }),
              SizedBox(height: 15),
              TextFormField(
                  controller: endDateController,
                  onTap: () {
                    showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime(2050))
                        .then((date) {
                      if (project.beginDate == null) {
                        ToastDialog.show('Select the begin date first!');
                      } else if (date.isAfter(project.beginDate)) {
                        endDateController.text =
                            new DateFormat("yyyy-MM-dd").format(date);
                        project.endDate = date.toUtc();
                      } else {
                        ToastDialog.show(
                            'The end date must be after the begin date!');
                      }
                    });
                  },
                  readOnly: true,
                  maxLength: 35,
                  decoration: InputDecoration(
                    icon: Icon(Icons.date_range),
                    border: OutlineInputBorder(),
                    labelText: 'Select the end date',
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'End date is required!';
                    }
                    return null;
                  }),
              SizedBox(height: 15),
              TextFormField(
                  controller: clientController,
                  onTap: _selectClient,
                  readOnly: true,
                  maxLength: 35,
                  decoration: InputDecoration(
                    icon: Icon(Icons.person),
                    border: OutlineInputBorder(),
                    labelText: 'Select the client',
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Client is required!';
                    }
                    return null;
                  }),
              SizedBox(height: 15),
              TextFormField(
                  controller: responsibleController,
                  onTap: _selectResponsible,
                  readOnly: true,
                  maxLength: 35,
                  decoration: InputDecoration(
                    icon: Icon(Icons.person),
                    border: OutlineInputBorder(),
                    labelText: 'Select the responsible',
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Responsible is required!';
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
