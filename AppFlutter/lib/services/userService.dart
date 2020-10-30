import 'dart:convert';
import 'package:AppFlutter/domain/user.dart';
import 'package:http/http.dart' as http;

class UserService {
  String apiURL = 'http://192.168.0.109:3000/api'; // 192.168.0.109

  Future<List<User>> getAll() async {
    final response = await http.get(apiURL + '/users');

    if (response.statusCode == 200) {
      final parsed = jsonDecode(response.body).cast<Map<String, dynamic>>();
      return parsed.map<User>((json) => User.fromJson(json)).toList();
    } else {
      throw Exception('Error in: ' + response.body);
    }
  }

  Future<User> updateUser(User user) async {
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
}
