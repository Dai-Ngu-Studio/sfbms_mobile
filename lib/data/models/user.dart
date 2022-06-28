class User {
  String? id;
  String? email;
  String? password;
  String? name;
  int? isAdmin;

  User({this.id, this.email, this.password, this.name, this.isAdmin});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    password = json['password'];
    name = json['name'];
    isAdmin = json['isAdmin'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['email'] = email;
    data['password'] = password;
    data['name'] = name;
    data['isAdmin'] = isAdmin;
    return data;
  }
}
