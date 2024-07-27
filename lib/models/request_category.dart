class RequestCategoryModel {
  num? id;
  String? title;
  String? type;
  String? status;

  RequestCategoryModel({this.id, this.title, this.type, this.status});

  factory RequestCategoryModel.fromJson(Map<String, dynamic> json) {
    if (json == null) return RequestCategoryModel();

    return RequestCategoryModel(
        id: (json.containsKey("id")) ? json["id"] : json["id"],
        title: (json.containsKey("title")) ? json["title"] : json["title"],
        type: (json.containsKey("type")) ? json["type"] : json["type"],
        status: (json.containsKey("status")) ? json["status"] : json["status"]);
  }

  Map<String, dynamic> toJson(RequestCategoryModel item) {
    return {};
  }
}
