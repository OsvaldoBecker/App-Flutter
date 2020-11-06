class User {
  String id;
  String name;
  String email;
  String cellphone;

  User();
  User.create(this.id, this.name, this.email, this.cellphone);

  factory User.fromJson(Map<String, dynamic> json) {
    return User.create(
        json['_id'], json['name'], json['email'], json['cellphone']);
  }

  Map<String, dynamic> toJson() =>
      {'_id': id, 'name': name, 'email': email, 'cellphone': cellphone};

  @override
  toString() {
    return name;
  }
}
