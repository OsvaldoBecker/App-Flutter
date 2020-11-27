import 'package:AppFlutter/domain/client.dart';
import 'package:AppFlutter/domain/employee.dart';

class Project {
  String id;
  String title;
  String description;
  DateTime beginDate;
  DateTime endDate;
  Client client;
  Employee responsible;

  Project();
  Project.create(this.id, this.title, this.description, this.beginDate,
      this.endDate, this.client, this.responsible);

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project.create(
        json['_id'],
        json['title'],
        json['description'],
        DateTime.parse(json['beginDate']).toLocal(),
        DateTime.parse(json['endDate']).toLocal(),
        Client.fromJson(json['client']),
        Employee.fromJson(json['responsible']));
  }

  Map<String, dynamic> toJson() => {
        '_id': id,
        'title': title,
        'description': description,
        'beginDate': beginDate.toString(),
        'endDate': endDate.toString(),
        'client': client == null ? null : client.toJson(),
        'responsible': responsible == null ? null : responsible.toJson()
      };

  @override
  toString() {
    return title;
  }
}
