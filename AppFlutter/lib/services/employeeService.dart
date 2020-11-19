import 'dart:convert';
import 'package:AppFlutter/domain/employee.dart';
import 'package:http/http.dart' as http;

class EmployeeService {
  String apiURL = 'http://10.0.2.2:3000/api'; // VERIFY IP

  Future<List<Employee>> getAll() async {
    final response = await http.get(apiURL + '/employees');

    if (response.statusCode == 200) {
      final parsed = jsonDecode(response.body).cast<Map<String, dynamic>>();
      return parsed.map<Employee>((json) => Employee.fromJson(json)).toList();
    } else {
      throw Exception('Error in: ' + response.body);
    }
  }

  insertEmployee(Employee employee) async {
    final response = await http.post(
      apiURL + '/employees',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(employee.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception('Error in: ' + response.body);
    }
  }

  updateEmployee(Employee employee) async {
    final response = await http.put(
      apiURL + '/employees',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(employee.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception('Error in: ' + response.body);
    }
  }

  deleteEmployee(Employee employee) async {
    final response = await http
        .delete(apiURL + '/employees/' + employee.id, headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    });
    if (response.statusCode != 200) {
      throw Exception('Error in: ' + response.body);
    }
  }
}
