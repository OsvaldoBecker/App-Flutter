import 'dart:convert';
import 'package:AppFlutter/domain/client.dart';
import 'package:http/http.dart' as http;

class ClientService {
  String apiURL = 'http://10.0.2.2:3000/api'; // VERIFY IP

  Future<List<Client>> getAll() async {
    final response = await http.get(apiURL + '/clients');

    if (response.statusCode == 200) {
      final parsed = jsonDecode(response.body).cast<Map<String, dynamic>>();
      return parsed.map<Client>((json) => Client.fromJson(json)).toList();
    } else {
      throw Exception('Error in: ' + response.body);
    }
  }

  insertClient(Client client) async {
    final response = await http.post(
      apiURL + '/clients',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(client.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception('Error in: ' + response.body);
    }
  }

  updateClient(Client client) async {
    final response = await http.put(
      apiURL + '/clients',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(client.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception('Error in: ' + response.body);
    }
  }

  deleteClient(Client client) async {
    final response = await http
        .delete(apiURL + '/clients/' + client.id, headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    });
    if (response.statusCode != 200) {
      throw Exception('Error in: ' + response.body);
    }
  }
}
