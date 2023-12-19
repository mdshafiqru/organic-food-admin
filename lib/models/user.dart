class User {
  String? id;
  String? name;
  String? phone;

  User({this.id, this.name, this.phone});

  User.fromJson(Map<String, dynamic> json) {
    final user = json['user'];

    id = user['_id'];
    name = user['name'];
    phone = user['phone'];
  }
}
