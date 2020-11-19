class Client {
  String id;
  String name;
  String email;

  Client();
  Client.create(this.id, this.name, this.email);

  factory Client.fromJson(Map<String, dynamic> json) {
    return Client.create(json['_id'], json['name'], json['email']);
  }

  Map<String, dynamic> toJson() => {'_id': id, 'name': name, 'email': email};

  @override
  toString() {
    return name;
  }
}
