import 'dart:convert';
import 'package:AppFlutter/domain/user.dart';
import 'package:http/http.dart' as http;

class UserService {
  String apiURL = 'http://10.0.2.2:3000/api'; // VERIFY IP

  Future<List<User>> getAll() async {
    final response = await http.get(apiURL + '/users');

    if (response.statusCode == 200) {
      final parsed = jsonDecode(response.body).cast<Map<String, dynamic>>();
      return parsed.map<User>((json) => User.fromJson(json)).toList();
    } else {
      throw Exception('Error in: ' + response.body);
    }
  }

  insertUser(User user) async {
    final response = await http.post(
      apiURL + '/users',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(user.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception('Error in: ' + response.body);
    }
  }

  updateUser(User user) async {
    final response = await http.put(
      apiURL + '/users',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(user.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception('Error in: ' + response.body);
    }
  }

  deleteUser(User user) async {
    final response = await http
        .delete(apiURL + '/users/' + user.id, headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    });
    if (response.statusCode != 200) {
      throw Exception('Error in: ' + response.body);
    }
  }
}
