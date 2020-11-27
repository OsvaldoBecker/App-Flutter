import 'package:AppFlutter/domain/project.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProjectDetailPage extends StatefulWidget {
  ProjectDetailPage({Key key, this.project}) : super(key: key);

  final Project project;

  @override
  _ProjectDetailPageState createState() => _ProjectDetailPageState();
}

class _ProjectDetailPageState extends State<ProjectDetailPage> {
  final _formKey = GlobalKey<FormState>();

  Project project;

  @override
  void initState() {
    super.initState();
    setState(() {
      project = widget.project;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Project Details'),
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
                    icon: Icon(Icons.title),
                    border: OutlineInputBorder(),
                    labelText: 'Title',
                  ),
                  initialValue: project.title),
              SizedBox(height: 15),
              TextFormField(
                  enabled: false,
                  decoration: InputDecoration(
                    icon: Icon(Icons.description),
                    border: OutlineInputBorder(),
                    labelText: 'Description',
                  ),
                  initialValue: project.description),
              SizedBox(height: 15),
              TextFormField(
                  enabled: false,
                  decoration: InputDecoration(
                    icon: Icon(Icons.date_range),
                    border: OutlineInputBorder(),
                    labelText: 'Begin date',
                  ),
                  initialValue:
                      new DateFormat("yyyy-MM-dd").format(project.beginDate)),
              SizedBox(height: 15),
              TextFormField(
                  enabled: false,
                  decoration: InputDecoration(
                    icon: Icon(Icons.date_range),
                    border: OutlineInputBorder(),
                    labelText: 'End date',
                  ),
                  initialValue:
                      new DateFormat("yyyy-MM-dd").format(project.endDate)),
              SizedBox(height: 15),
              TextFormField(
                  enabled: false,
                  decoration: InputDecoration(
                    icon: Icon(Icons.person),
                    border: OutlineInputBorder(),
                    labelText: 'Client',
                  ),
                  initialValue: project.client.name),
              SizedBox(height: 15),
              TextFormField(
                  enabled: false,
                  decoration: InputDecoration(
                    icon: Icon(Icons.person),
                    border: OutlineInputBorder(),
                    labelText: 'Responsible',
                  ),
                  initialValue: project.responsible.name),
            ],
          ),
        ),
      ),
    );
  }
}
