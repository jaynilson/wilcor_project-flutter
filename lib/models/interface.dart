import 'package:intl/date_symbols.dart';

class InterfaceModel {
  num? id;
  num? order;
  String? picture;
  String? title;
  String? type;
  String? widget;
  bool? critical;

  InterfaceModel(
      {this.id,
      this.order,
      this.picture,
      this.title,
      this.type,
      this.widget,
      this.critical});

  factory InterfaceModel.fromJson(Map<String, dynamic> json) {
    if (json == null) return InterfaceModel();

    return InterfaceModel(
        id: (json.containsKey("id")) ? json["id"] : json["id"],
        order: (json.containsKey("id")) ? json["id"] : json["id"],
        picture: json["picture"],
        title: json["title"],
        type: json["type"],
        critical: json["critical"] == "true" ? true : false,
        widget: "check");
  }

  Map<String, dynamic> toJson(InterfaceModel item) {
    return {};
  }
}
