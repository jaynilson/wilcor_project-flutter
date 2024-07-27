import 'package:intl/intl.dart';
import 'package:wilcoerp/helpers/helpers.dart';
import 'package:wilcoerp/models/tools.dart';
import 'package:wilcoerp/models/user.dart';
import 'package:wilcoerp/models/fleet.dart';

class CheckOut {
  num? id;
  String? place;
  String? problem_found;
  UserModel? employee;
  FleetModel? fleet;
  ToolModel? tool;
  String? lat;
  String? lng;
  num? odometer_reading;
  String? status;
  String? type;
  num? quantity;
  DateTime? created_at;

  CheckOut(
      {this.id,
      this.place,
      this.problem_found,
      this.employee,
      this.fleet,
      this.tool,
      this.lat,
      this.lng,
      this.odometer_reading,
      this.status,
      this.type,
      this.quantity,
      this.created_at});

  factory CheckOut.fromJson(Map<String, dynamic> json) {
    DateFormat formatter = DateFormat("yyyy-MM-dd h:m:s");
    print("Tool checkout");
    print(json["tool"]);
    return CheckOut(
      id: (json.containsKey("id")) ? json["id"] : null,
      place: (json.containsKey("place")) ? json["place"] : null,
      problem_found:
          (json.containsKey("problem_found")) ? json["problem_found"] : null,
      employee: (json.containsKey("employee"))
          ? UserModel.fromJson(json["employee"])
          : null,
      fleet: (json.containsKey("fleet") && json["fleet"] != null)
          ? FleetModel.fromJson(json["fleet"])
          : null,
      tool: (json.containsKey("tool") && json["tool"] != null)
          ? ToolModel.fromJson(json["tool"])
          : null,
      lat: (json.containsKey("lat")) ? json["lat"].toString() : null,
      lng: (json.containsKey("lng")) ? json["lng"].toString() : null,
      odometer_reading: (json.containsKey("odometer_reading") &&
              checkEmpty(json["odometer_reading"]))
          ? double.parse(json["odometer_reading"].toString())
          : null,
      quantity: (json.containsKey("quantity")) ? json["quantity"] : null,
      status: (json.containsKey("status")) ? json["status"] : null,
      type: (json.containsKey("type")) ? json["type"] : null,
      created_at: (json.containsKey("type"))
          ? formatter.parse(json["created_at"])
          : null,
    );
  }

  Map<String, dynamic> toJson(CheckOut item) {
    return {
      'id': item.id,
      'place': item.place,
      'problem_found': item.problem_found,
      'employee': item.employee,
      'fleet': item.fleet,
      "tool": item.tool,
      'lat': item.lat,
      'lng': item.lng,
      'odometer_reading': item.odometer_reading,
      'status': item.status,
      'type': item.type,
      'quantity': item.quantity,
      'created_at': item.created_at
    };
  }
}
