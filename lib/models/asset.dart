class AssetModel {
  num? id;
  String? picture;
  String? type;
  dynamic id_reference;
  String? created_at;

  AssetModel({
    this.id,
    this.picture,
    this.type,
    this.id_reference,
    this.created_at,
  });

  factory AssetModel.fromJson(Map<String, dynamic> json) {
    if (json == null) return AssetModel();
    return AssetModel(
        id: json["id"],
        picture: json["name"],
        type: json["type"],
        id_reference: json["id_reference"],
        created_at: json["created_at"]);
  }

  Map<String, dynamic> toJson(AssetModel item) {
    return {
      'id': item.id,
      'name': item.picture,
      'type': item.type,
      'id_reference': item.id_reference,
      'created_at': item.created_at,
    };
  }
}
