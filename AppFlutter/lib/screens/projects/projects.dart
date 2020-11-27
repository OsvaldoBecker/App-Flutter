import 'package:AppFlutter/domain/project.dart';
import 'package:AppFlutter/screens/projects/projectCreate.dart';
import 'package:AppFlutter/screens/projects/projectDetail.dart';
import 'package:AppFlutter/screens/projects/projectEdit.dart';
import 'package:AppFlutter/services/projectService.dart';
import 'package:AppFlutter/util/confirmDialog.dart';
import 'package:AppFlutter/util/toastDialog.dart';
import 'package:flutter/material.dart';

class ProjectsPage extends StatefulWidget {
  ProjectsPage({Key key, this.title}) : super(key: key);

  final String title;
  final ProjectService projectService = new ProjectService();

  @override
  _ProjectsPageState createState() => _ProjectsPageState();
}

class _ProjectsPageState extends State<ProjectsPage> {
  List<Project> projects = new List();

  @override
  void initState() {
    super.initState();
    _getProjects();
  }

  void _getProjects() {
    widget.projectService.getAll().then((value) => {
          setState(() {
            projects = value;
          })
        });
  }

  void _detailProject(Project project) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
          builder: (context) => ProjectDetailPage(project: project)),
    );
    _getProjects();
  }

  void _createProject() async {
    await Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => ProjectCreatePage()),
    );
    _getProjects();
  }

  void _editProject(Project project) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
          builder: (context) => ProjectEditPage(project: project)),
    );
    _getProjects();
  }

  void _deleteProject(Project project) {
    ConfirmDialog.show(
      context,
      'Are you sure you want to delete?',
      () => ({
        widget.projectService
            .deleteProject(project)
            .then((value) => {ToastDialog.show('Deleted!'), _getProjects()})
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
          children: projects
              .map((data) => ListTile(
                    leading: Icon(Icons.table_view),
                    title: Row(children: <Widget>[Text(data.title)]),
                    trailing: PopupMenuButton(
                      onSelected: (option) {
                        if (option == 'detail') {
                          _detailProject(data);
                        } else if (option == 'edit') {
                          _editProject(data);
                        } else {
                          _deleteProject(data);
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
        onPressed: _createProject,
        tooltip: 'Create project',
        child: Icon(Icons.add),
      ),
    );
  }
}
