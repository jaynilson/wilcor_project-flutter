import 'package:intl/date_symbols.dart';

class FleetModel {
  num? id;
  String? n;
  String? model;
  String? licence_plate;
  String? year;
  String? yard_location;
  String? department;
  String? status;
  String? type;
  String? picture;
  String? created_at;
  String? updated_at;

  FleetModel({
    this.id,
    this.n,
    this.model,
    this.licence_plate,
    this.year,
    this.yard_location,
    this.department,
    this.status,
    this.type,
    this.picture,
    this.created_at,
    this.updated_at,
  });

  factory FleetModel.fromJson(Map<String, dynamic> json) {
    if (json == null) return FleetModel();

    return FleetModel(
        id: (json.containsKey("id")) ? json["id"] : json["id"],
        n: json["n"],
        model: json["model"],
        licence_plate: json["licence_plate"],
        year: json["year"],
        yard_location: json["yard_location"],
        department: json["department"],
        status: json["status"],
        type: json["type"],
        picture: json["picture"],
        created_at: json["created_at"],
        updated_at: json["updated_at"]);
  }

  Map<String, dynamic> toJson(FleetModel item) {
    return {
      'id': item.id,
      'n': item.n,
      'model': item.model,
      'licence_plate': item.licence_plate,
      'year': item.year,
      'yard_location': item.yard_location,
      'department': item.department,
      'status': item.status,
      'type': item.type,
      'picture': item.picture,
      'created_at': item.created_at,
      'updated_at': item.updated_at,
    };
  }
}
