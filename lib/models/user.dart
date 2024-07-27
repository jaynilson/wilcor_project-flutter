import 'package:intl/date_symbols.dart';

class UserModel {
  num? id;
  String? email;
  String? name;
  String? last_name;
  String? pin;
  String? picture;
  String? tel;
  String? status;
  num? id_rol;
  String? token;

  double? lat;
  double? long;

  String? created_at;
  String? updated_at;

  UserModel({
    this.id,
    this.email,
    this.name,
    this.last_name,
    this.pin,
    this.picture,
    this.tel,
    this.status,
    this.id_rol,
    this.token,
    this.lat,
    this.long,
    this.created_at,
    this.updated_at,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    if (json == null) return UserModel();

    return UserModel(
        id: (json.containsKey("id")) ? json["id"] : json["id"],
        email: json["email"],
        name: json["name"],
        last_name: json["last_name"],
        pin: json["pin"],
        picture: json["picture"],
        tel: json["tel"],
        status: json["status"],
        id_rol: json["id_rol"],
        token: json["token"],
        lat: (json.containsKey("lat")) ? json["lat"] : null,
        long: (json.containsKey("long")) ? json["long"] : null,
        created_at: json["created_at"],
        updated_at: json["updated_at"]);
  }

  Map<String, dynamic> toJson(UserModel item) {
    return {
      'id': item.id,
      'email': item.email,
      'name': item.name,
      'last_name': item.last_name,
      'pin': item.pin,
      'picture': item.picture,
      'tel': item.tel,
      'status': item.status,
      'id_rol': item.id_rol,
      'token': item.token,
      'lat': item.lat,
      'long': item.long,
      'created_at': item.created_at,
      'updated_at': item.updated_at,
    };
  }
}
