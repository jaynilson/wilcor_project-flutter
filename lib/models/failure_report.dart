import 'package:intl/intl.dart';
import 'package:wilcoerp/helpers/helpers.dart';
import 'package:wilcoerp/models/user.dart';
import 'package:wilcoerp/models/fleet.dart';

class FailureReportModel {
  num? id;
  String? type;
  String? status;
  String? description;
  dynamic id_fleet;
  dynamic id_employee;
  String? created_at;

  FailureReportModel(
      {this.id,
      this.type,
      this.status,
      this.description,
      this.id_fleet,
      this.id_employee,
      this.created_at});

  factory FailureReportModel.fromJson(Map<String, dynamic> json) {
    return FailureReportModel(
      id: (json.containsKey("id")) ? json["id"] : null,
      type: json["type"],
      status: json["status"],
      description: json["description"],
      id_fleet: json["id_fleet"],
      created_at: json["created_at"],
    );
  }

  Map<String, dynamic> toJson(FailureReportModel item) {
    return {
      'id': item.id,
      'place': item.type,
      'problem_found': item.status,
      'employee': item.description,
      'fleet': item.id_fleet,
      'lat': item.id_employee,
      'lng': item.created_at
    };
  }
}
