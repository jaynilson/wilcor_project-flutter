import 'package:intl/date_symbols.dart';

class ToolModel {
  num? id;
  String? n;
  String? title;
  num? stock;
  num? available_stock;
  String? status;
  String? type;
  String? picture;
  num? required_return;
  String? created_at;
  String? updated_at;

  ToolModel({
    this.id,
    this.n,
    this.title,
    this.stock,
    this.available_stock,
    this.status,
    this.type,
    this.required_return,
    this.picture,
    this.created_at,
    this.updated_at,
  });

  factory ToolModel.fromJson(Map<String, dynamic> json) {
    if (json == null) return ToolModel();

    return ToolModel(
        id: (json.containsKey("id")) ? json["id"] : json["id"],
        n: json["n"],
        title: json["title"],
        stock: json["stock"],
        available_stock: json["available_stock"],
        status: json["status"],
        type: json["type"],
        required_return: json["required_return"],
        picture: json["picture"],
        created_at: json["created_at"],
        updated_at: json["updated_at"]);
  }

  Map<String, dynamic> toJson(ToolModel item) {
    return {
      'id': item.id,
      'n': item.n,
      'title': item.title,
      'stock': item.stock,
      'available_stock': item.available_stock,
      'status': item.status,
      'type': item.type,
      'required_return': item.required_return,
      'picture': item.picture,
      'created_at': item.created_at,
      'updated_at': item.updated_at,
    };
  }
}
