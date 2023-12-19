class Admin {
  String? id;
  String? name;
  String? phone;
  String? token;

  Admin({this.id, this.name, this.phone, this.token});

  Admin.fromJson(Map<String, dynamic> json) {
    final admin = json['admin'];

    id = admin['_id'];
    name = admin['name'];
    phone = admin['phone'];

    token = json['token'];
  }
}
