import 'dart:convert';
import 'package:AppFlutter/domain/project.dart';
import 'package:http/http.dart' as http;

class ProjectService {
  String apiURL = 'http://10.0.2.2:3000/api'; // VERIFY IP

  Future<List<Project>> getAll() async {
    final response = await http.get(apiURL + '/projects');

    if (response.statusCode == 200) {
      final parsed = jsonDecode(response.body).cast<Map<String, dynamic>>();
      return parsed.map<Project>((json) => Project.fromJson(json)).toList();
    } else {
      throw Exception('Error in: ' + response.body);
    }
  }

  insertProject(Project project) async {
    final response = await http.post(
      apiURL + '/projects',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(project.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception('Error in: ' + response.body);
    }
  }

  updateProject(Project project) async {
    final response = await http.put(
      apiURL + '/projects',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(project.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception('Error in: ' + response.body);
    }
  }

  deleteProject(Project project) async {
    final response = await http
        .delete(apiURL + '/projects/' + project.id, headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    });
    if (response.statusCode != 200) {
      throw Exception('Error in: ' + response.body);
    }
  }
}
