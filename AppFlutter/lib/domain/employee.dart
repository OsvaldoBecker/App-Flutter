class Employee {
  String id;
  String name;
  String email;
  String skills;

  Employee();
  Employee.create(this.id, this.name, this.email, this.skills);

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee.create(
        json['_id'], json['name'], json['email'], json['skills']);
  }

  Map<String, dynamic> toJson() =>
      {'_id': id, 'name': name, 'email': email, 'skills': skills};

  @override
  toString() {
    return name;
  }
}
