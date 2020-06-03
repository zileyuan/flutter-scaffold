class UserModel {
  int id;
  String name;
  String password;
  String phone;
  String token;

  UserModel.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        name = json["name"],
        password = json["password"],
        phone = json["phone"],
        token = json["token"];

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'password': password,
        'phone': phone,
        'token': token,
      };
}
