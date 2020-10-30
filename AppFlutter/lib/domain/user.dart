class User {
  String id;
  String name;
  String email;
  String cellphone;
  String password;

  User();
  User.create(this.id, this.name, this.email, this.cellphone, this.password);

  factory User.fromJson(Map<String, dynamic> json) {
    return User.create(json['_id'], json['name'], json['email'],
        json['cellphone'], json['password']);
  }

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'email': email,
        'cellphone': cellphone,
        'password': password
      };

  @override
  toString() {
    return name;
  }
}
