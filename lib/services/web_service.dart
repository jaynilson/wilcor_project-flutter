import 'dart:convert';
// import 'dart:html';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wilcoerp/constants/globals.dart';
import 'package:wilcoerp/helpers/helpers.dart';
import 'package:wilcoerp/models/asset.dart';
import 'package:wilcoerp/models/checkout.dart';
import 'package:wilcoerp/models/failure_report.dart';
import 'package:wilcoerp/models/fleet.dart';
import 'package:wilcoerp/models/interface.dart';
import 'package:wilcoerp/models/place.dart';
import 'package:wilcoerp/models/tools.dart';
import 'package:wilcoerp/models/user.dart';
import 'package:wilcoerp/providers/app.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../models/request_category.dart';

class WebService {
  Dio dio = Dio();
  BuildContext context;
  WebService(this.context) {
    dio = Dio();
  }

  Future<List<Place>> reverseGeocode(String lat, String lng) async {
    final String baseURL = 'https://maps.googleapis.com/maps/api/geocode/json';
    String PLACES_API_KEY = googleApiKey;
    String request = '';

    request = '$baseURL?latlng=$lat, $lng&language=es&key=$PLACES_API_KEY';

    try {
      final response = await dio.get(request);

      List<Place> list = [];
      if (response.data["status"] == "OK") {
        list = response.data["results"]
            .map<Place>((json) => Place.fromJson(json))
            .toList();
      }

      return list;
    } catch (e) {
      print(e);
      return Future.error(['Ocurrió un error desconocido, intenté de nuevo.']);
    }
  }

  Future<UserModel> signIn(String email, String password) async {
    dio.options.headers["Content-type"] = "application/json";
    dio.options.headers["Accept"] = "application/json";
    String baseURL =
        apiUrl + "login"; // Ensure this matches your backend endpoint

    try {
      dynamic response = await dio.post(
        baseURL,
        data: jsonEncode({
          "email": email,
          "password": password,
        }),
      );

      if (response.statusCode == 200) {
        dynamic userJson = response.data["user"];
        userJson["token"] = response.data["access_token"];
        userJson["loginTimestamp"] = DateTime.now().millisecondsSinceEpoch;

        // Store the login timestamp
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setInt('loginTimestamp', userJson["loginTimestamp"]);

        return UserModel.fromJson(userJson);
      } else {
        return Future.error(checkErrors(response.data));
      }
    } catch (e) {
      print("error signIn");
      print(e);
      if (e is DioError) {
        return Future.error(checkErrors((e as DioError).response));
      }
      return Future.error(['An unknown error occurred, please try again.']);
    }
  }

  Future<bool> isLoginExpired() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? loginTimestamp = prefs.getInt('loginTimestamp');
    if (loginTimestamp == null) return true;

    int currentTimestamp = DateTime.now().millisecondsSinceEpoch;

    // Set the expiration time (e.g., 24 hours)
    int expirationTime = 24 * 60 * 60 * 1000; // 24 hours in milliseconds

    return (currentTimestamp - loginTimestamp) > expirationTime;
  }

  Future<bool> resendPin(String email) async {
    dio.options.headers["Content-type"] = "application/json";
    dio.options.headers["Accept"] = "application/json";
    String baseURL = apiUrl + "resend_pin";

    try {
      dynamic response =
          await dio.post(baseURL, data: jsonEncode({"email": email}));

      if (response.statusCode == 200) {
        return true;
      } else {
        return Future.error(checkErrors(response.data));
      }
    } catch (e) {
      print("error resendPin");
      print(e);

      if (e is DioError)
        return Future.error(checkErrors((e as DioError).response));

      return Future.error(['Ocurrió un error desconocido, intenté de nuevo.']);
    }
  }

  Future<List<FleetModel>> getFleets(num limit, num skip, String type,
      String location, BuildContext context, String token,
      {String search = ""}) async {
    dio.options.headers["Accept"] = "application/json";
    dio.options.headers["Authorization"] = "$token";
    String baseURL = apiUrl + "fleet";

    try {
      final response = await dio.get(baseURL, queryParameters: {
        "limit": limit,
        "skip": skip,
        "type": type,
        "location": location,
        "search": search
      });

      if (response.statusCode == 200) {
        final provider = Provider.of<AppProvider>(context, listen: false);

        return response.data["fleets"].map<FleetModel>((item) {
          return FleetModel.fromJson(item);
        }).toList();
      } else {
        return Future.error(checkErrors(response.data));
      }
    } catch (e) {
      print("error en getFleets ");
      print(e);
      print((e as DioError).response);
      if (e is DioError)
        return Future.error(checkErrors((e as DioError).response));
      return Future.error(['Ocurrió un error desconocido, intenté de nuevo.']);
    }
  }

  Future<List<ToolModel>> getTools(
      num limit, num skip, String type, BuildContext context, String token,
      {String search = ""}) async {
    dio.options.headers["Accept"] = "application/json";
    dio.options.headers["Authorization"] = "$token";
    String baseURL = apiUrl + "tool";

    try {
      final response = await dio.get(baseURL, queryParameters: {
        "limit": limit,
        "skip": skip,
        "type": type,
        "search": search
      });

      if (response.statusCode == 200) {
        final provider = Provider.of<AppProvider>(context, listen: false);

        return response.data["tools"].map<ToolModel>((item) {
          return ToolModel.fromJson(item);
        }).toList();
      } else {
        return Future.error(checkErrors(response.data));
      }
    } catch (e) {
      print("error en getFleets ");
      print(e);
      print((e as DioError).response);
      if (e is DioError)
        return Future.error(checkErrors((e as DioError).response));
      return Future.error(['Ocurrió un error desconocido, intenté de nuevo.']);
    }
  }

  Future<List<InterfaceModel>> getInterfaces(String type, String token) async {
    dio.options.headers["Accept"] = "application/json";
    dio.options.headers["Authorization"] = "$token";
    String baseURL = apiUrl + "interfaces";

    try {
      final response = await dio.get(baseURL, queryParameters: {"type": type});

      if (response.statusCode == 200) {
        return response.data["interfaces"].map<InterfaceModel>((item) {
          return InterfaceModel.fromJson(item);
        }).toList();
      } else {
        return Future.error(checkErrors(response.data));
      }
    } catch (e) {
      print("error en getInterfaces ");
      print(e);
      print((e as DioError).response);
      if (e is DioError)
        return Future.error(checkErrors((e as DioError).response));
      return Future.error(['Ocurrió un error desconocido, intenté de nuevo.']);
    }
  }

  Future<CheckOut?> getCheckout(String token, num user_id) async {
    dio.options.headers["Accept"] = "application/json";
    dio.options.headers["Authorization"] = "$token";
    String baseURL = apiUrl + "check_out";

    try {
      final response =
          await dio.get(baseURL, queryParameters: {"user_id": user_id});

      if (response.statusCode == 200) {
        if (response.data["checkout"] != null) {
          response.data["checkout"]["fleet"] = response.data["fleet"];
          response.data["checkout"]["employee"] = response.data["employee"];
          return CheckOut.fromJson(response.data["checkout"]);
        } else {
          return null;
        }
      } else {
        return Future.error(checkErrors(response.data));
      }
    } catch (e) {
      print("error en getCheckout ");
      print(e);
      print((e as DioError).response);
      if (e is DioError)
        return Future.error(checkErrors((e as DioError).response));
      return Future.error(['Ocurrió un error desconocido, intenté de nuevo.']);
    }
  }

  Future<List<CheckOut>> getCheckoutTool(String token, num user_id) async {
    dio.options.headers["Accept"] = "application/json";
    dio.options.headers["Authorization"] = "$token";
    String baseURL = apiUrl + "check_out_tool";

    try {
      final response =
          await dio.get(baseURL, queryParameters: {"user_id": user_id});

      if (response.statusCode == 200) {
        if (response.data["checkouts"] != null) {
          return response.data["checkouts"].map<CheckOut>((item) {
            dynamic itemTmp = item["checkout"];
            itemTmp["tool"] = item["tool"];
            itemTmp["employee"] = item["employee"];
            return CheckOut.fromJson(itemTmp);
          }).toList();
        } else {
          return [];
        }
      } else {
        return Future.error(checkErrors(response.data));
      }
    } catch (e) {
      print("error en getCheckoutTool ");
      print(e);
      print((e as DioError).response);
      if (e is DioError)
        return Future.error(checkErrors((e as DioError).response));
      return Future.error(['Ocurrió un error desconocido, intenté de nuevo.']);
    }
  }

  Future<List<RequestCategoryModel>> getRequestCategory(
      String type, String token) async {
    dio.options.headers["Accept"] = "application/json";
    dio.options.headers["Authorization"] = "$token";
    String baseURL = apiUrl + "request_category";

    try {
      final response = await dio.get(baseURL, queryParameters: {"type": type});

      if (response.statusCode == 200) {
        return response.data.map<RequestCategoryModel>((item) {
          return RequestCategoryModel.fromJson(item);
        }).toList();
      } else {
        return Future.error(checkErrors(response.data));
      }
    } catch (e) {
      print("error en getRequestCategory ");
      print(e);
      print((e as DioError).response);
      if (e is DioError)
        return Future.error(checkErrors((e as DioError).response));
      return Future.error(['Ocurrió un error desconocido, intenté de nuevo.']);
    }
  }

  Future<CheckOut> checkoutFleet(String place, String problem_found,
      String id_employee, String id_fleet, String token,
      {dynamic lat = null,
      dynamic lng = null,
      dynamic odometer_reading = null}) async {
    dio.options.headers["Accept"] = "application/json";
    dio.options.headers["Authorization"] = "$token";

    String baseURL = apiUrl + "check_out_employee_fleet";

    try {
      dynamic response = await dio.post(baseURL,
          data: jsonEncode({
            "place": place,
            "problem_found":
                (!checkEmpty(problem_found)) ? "false" : problem_found,
            "id_employee": id_employee,
            "id_fleet": id_fleet,
            "lat": lat,
            "lng": lng,
            "odometer_reading": odometer_reading
          }));

      if (response.statusCode == 200) {
        response.data["checkout"]["fleet"] = response.data["fleet"];
        response.data["checkout"]["employee"] = response.data["employee"];

        return CheckOut.fromJson(response.data["checkout"]);
      } else {
        return Future.error(checkErrors(response.data));
      }
    } catch (e) {
      print("error checkoutFleet");
      print((e as DioError).response);

      if (e is DioError)
        return Future.error(checkErrors((e as DioError).response));

      return Future.error(['Ocurrió un error desconocido, intenté de nuevo.']);
    }
  }

  Future<dynamic> addCheck(String id_check, String status, String is_critical,
      String type, String id_reference, String token) async {
    dio.options.headers["Accept"] = "application/json";
    dio.options.headers["Authorization"] = "$token";

    String baseURL = apiUrl + "dot_report";

    try {
      dynamic response = await dio.post(baseURL,
          data: jsonEncode({
            "id_check": id_check,
            "status": status,
            "is_critical": is_critical,
            "type": type,
            "id_reference": id_reference
          }));

      if (response.statusCode == 200) {
        return true;
      } else {
        return Future.error(checkErrors(response.data));
      }
    } catch (e) {
      print("error checkoutFleet");
      print((e as DioError).response);

      if (e is DioError)
        return Future.error(checkErrors((e as DioError).response));

      return Future.error(['Ocurrió un error desconocido, intenté de nuevo.']);
    }
  }

  Future<dynamic> checkInFleet(String place, String id_employee,
      String id_fleet, String token, String id_check_out,
      {dynamic lat = null,
      dynamic lng = null,
      dynamic odometer_reading = null}) async {
    dio.options.headers["Accept"] = "application/json";
    dio.options.headers["Authorization"] = "$token";

    String baseURL = apiUrl + "check_in_employee_fleet";

    try {
      dynamic response = await dio.post(baseURL,
          data: jsonEncode({
            "place": place,
            "id_employee": id_employee,
            "id_fleet": id_fleet,
            "lat": lat,
            "lng": lng,
            "odometer_reading": odometer_reading,
            "id_check_out": id_check_out
          }));

      if (response.statusCode == 200) {
        return response.data["checkin"];
      } else {
        return Future.error(checkErrors(response.data));
      }
    } catch (e) {
      print("error checkInFleet");
      print(e);

      if (e is DioError)
        return Future.error(checkErrors((e as DioError).response));

      return Future.error(['Ocurrió un error desconocido, intenté de nuevo.']);
    }
  }

  Future<FailureReportModel> employeeFailureReportFleetInsert(String id_fleet,
      String id_employee, String type, String description, String token) async {
    dio.options.headers["Accept"] = "application/json";
    dio.options.headers["Authorization"] = "$token";

    String baseURL = apiUrl + "employee_failure_report_fleet";

    try {
      dynamic response = await dio.post(baseURL,
          data: jsonEncode({
            "id_fleet": id_fleet,
            "id_employee": id_employee,
            "type": type,
            "description": description
          }));

      if (response.statusCode == 200) {
        return FailureReportModel.fromJson(response.data["failureReport"]);
      } else {
        return Future.error(checkErrors(response.data));
      }
    } catch (e) {
      print("error employeeFailureReportFleetInsert");
      print(e);

      if (e is DioError)
        return Future.error(checkErrors((e as DioError).response));

      return Future.error(['Ocurrió un error desconocido, intenté de nuevo.']);
    }
  }

  Future<AssetModel> uploadAsset(
      String type, String id_reference, dynamic asset, String token) async {
    dio.options.headers["Accept"] = "application/json";
    dio.options.headers["Authorization"] = "$token";
    String baseURL = apiUrl + "asset";

    try {
      FormData formData =
          new FormData.fromMap({"type": type, "id_reference": id_reference});

      formData.files.add(MapEntry(
          "asset",
          await MultipartFile.fromFile(asset.path,
              filename: asset.path.split('/').last)));

      dio.options.extra = {"path_file": asset.path};

      final response = await dio.post(baseURL, data: formData);

      if (response.statusCode == 200) {
        return AssetModel.fromJson(response.data["asset"]);
      } else {
        return Future.error(checkErrors(response.data));
      }
    } catch (e) {
      print(e);
      if (e is DioError)
        return Future.error(checkErrors((e as DioError).response));
      return Future.error(['Ocurrió un error desconocido, intenté de nuevo.']);
    }
  }

  Future<String> reportProblemFleet(
      String place,
      String description,
      String id_employee,
      String id_fleet,
      String id_request_category,
      String token,
      {dynamic lat = null,
      dynamic lng = null,
      dynamic audio = null}) async {
    dio.options.headers["Accept"] = "application/json";
    dio.options.headers["Authorization"] = "$token";

    String baseURL = apiUrl + "employee_report_problem_fleet";

    print(id_request_category);
    print(id_employee);
    print(id_fleet);
    print(description);
    print(place);
    try {
      FormData formData = new FormData.fromMap({
        "place": place,
        "description": description,
        "id_employee": id_employee,
        "id_fleet": id_fleet,
        "id_request_category": id_request_category,
        "lat": lat,
        "lng": lng,
      });

      if (audio != null) {
        formData.files.add(MapEntry(
            "audio",
            await MultipartFile.fromFile(audio.path,
                filename: audio.path.split('/').last)));

        dio.options.extra = {"path_file": audio.path};
      }

      final response = await dio.post(baseURL, data: formData);

      if (response.statusCode == 200) {
        return response.data["id"].toString();
      } else {
        return Future.error(checkErrors(response.data));
      }
    } catch (e) {
      print("error reportProblemFleet");
      print((e as DioError).response);

      if (e is DioError)
        return Future.error(checkErrors((e as DioError).response));

      return Future.error(['Ocurrió un error desconocido, intenté de nuevo.']);
    }
  }

  Future<dynamic> accidentReport(String type, String id_employee, String token,
      {String id_fleet = "", String id_tool = ""}) async {
    dio.options.headers["Accept"] = "application/json";
    dio.options.headers["Authorization"] = "$token";

    String baseURL = apiUrl + "accident_report";

    try {
      dynamic response = await dio.post(baseURL,
          data: jsonEncode({"type": type, "id_employee": id_employee}));

      if (response.statusCode == 200) {
        return response.data["report"];
      } else {
        return Future.error(checkErrors(response.data));
      }
    } catch (e) {
      print("error accidentReport");
      print((e as DioError).response);

      if (e is DioError)
        return Future.error(checkErrors((e as DioError).response));

      return Future.error(['Ocurrió un error desconocido, intenté de nuevo.']);
    }
  }

  Future<dynamic> accidentReportAnswer(String type, String question_text,
      String position, String content, String id_report, String token) async {
    dio.options.headers["Accept"] = "application/json";
    dio.options.headers["Authorization"] = "$token";

    String baseURL = apiUrl + "accident_report_answer";

    try {
      dynamic response = await dio.post(baseURL,
          data: jsonEncode({
            "type": type,
            "question_text": question_text,
            "position": position,
            "content": content,
            "id_report": id_report
          }));

      if (response.statusCode == 200) {
        return response.data["answer"];
      } else {
        return Future.error(checkErrors(response.data));
      }
    } catch (e) {
      print("error accidentReportAnswer");
      print((e as DioError).response);

      if (e is DioError)
        return Future.error(checkErrors((e as DioError).response));

      return Future.error(['Ocurrió un error desconocido, intenté de nuevo.']);
    }
  }

  Future<dynamic> accidentReportLinked(
      String id_report, String id_report_linked, String token) async {
    dio.options.headers["Accept"] = "application/json";
    dio.options.headers["Authorization"] = "$token";

    String baseURL = apiUrl + "accident_report_linked";

    try {
      dynamic response = await dio.post(baseURL,
          data: jsonEncode(
              {"id_report": id_report, "id_report_linked": id_report_linked}));

      if (response.statusCode == 200) {
        return response.data["report"];
      } else {
        return Future.error(checkErrors(response.data));
      }
    } catch (e) {
      print("error accidentReportLinked");
      print((e as DioError).response);

      if (e is DioError)
        return Future.error(checkErrors((e as DioError).response));

      return Future.error(['Ocurrió un error desconocido, intenté de nuevo.']);
    }
  }

  Future<CheckOut> checkoutTool(num quantity, String return_date,
      String id_employee, String id_tool, String token) async {
    dio.options.headers["Accept"] = "application/json";
    dio.options.headers["Authorization"] = "$token";

    String baseURL = apiUrl + "check_out_employee_tool";

    try {
      dynamic response = await dio.post(baseURL,
          data: jsonEncode({
            "quantity": quantity,
            "return_date": return_date,
            "id_employee": id_employee,
            "id_tool": id_tool
          }));

      if (response.statusCode == 200) {
        response.data["checkout"]["tool"] = response.data["tool"];
        response.data["checkout"]["employee"] = response.data["employee"];

        return CheckOut.fromJson(response.data["checkout"]);
      } else {
        return Future.error(checkErrors(response.data));
      }
    } catch (e) {
      print("error checkoutFleet");
      print((e as DioError).response);

      if (e is DioError)
        return Future.error(checkErrors((e as DioError).response));

      return Future.error(['Ocurrió un error desconocido, intenté de nuevo.']);
    }
  }

  Future<dynamic> checkInTool(
    String id_employee,
    String id_tool,
    String id_check_out,
    String token,
  ) async {
    dio.options.headers["Accept"] = "application/json";
    dio.options.headers["Authorization"] = "$token";

    String baseURL = apiUrl + "check_in_employee_tool";

    try {
      dynamic response = await dio.post(baseURL,
          data: jsonEncode({
            "id_employee": id_employee,
            "id_tool": id_tool,
            "id_check_out": id_check_out
          }));

      if (response.statusCode == 200) {
        return response.data["checkin"];
      } else {
        return Future.error(checkErrors(response.data));
      }
    } catch (e) {
      print("error checkInTool");
      print(e);

      if (e is DioError)
        return Future.error(checkErrors((e as DioError).response));

      return Future.error(['Ocurrió un error desconocido, intenté de nuevo.']);
    }
  }

  Future<dynamic> requestTool(
    String id_employee,
    String id_tool,
    String date_needed,
    num cant,
    String token,
  ) async {
    dio.options.headers["Accept"] = "application/json";
    dio.options.headers["Authorization"] = "$token";

    String baseURL = apiUrl + "request_employee_tool";

    try {
      dynamic response = await dio.post(baseURL,
          data: jsonEncode({
            "id_employee": id_employee,
            "id_tool": id_tool,
            "date_needed": date_needed,
            "cant": cant
          }));

      if (response.statusCode == 200) {
        return response.data["request"];
      } else {
        return Future.error(checkErrors(response.data));
      }
    } catch (e) {
      print("error requestTool");
      print(e);

      if (e is DioError)
        return Future.error(checkErrors((e as DioError).response));

      return Future.error(['Ocurrió un error desconocido, intenté de nuevo.']);
    }
  }

  Future<dynamic> requestFleet(
    String id_employee,
    String id_fleet,
    String date_needed,
    num cant,
    String token,
  ) async {
    dio.options.headers["Accept"] = "application/json";
    dio.options.headers["Authorization"] = "$token";

    String baseURL = apiUrl + "request_employee_fleet";

    try {
      dynamic response = await dio.post(baseURL,
          data: jsonEncode({
            "id_employee": id_employee,
            "id_fleet": id_fleet,
            "date_needed": date_needed,
            "cant": cant
          }));

      if (response.statusCode == 200) {
        return response.data["request"];
      } else {
        return Future.error(checkErrors(response.data));
      }
    } catch (e) {
      print("error requestTool");
      print(e);

      if (e is DioError)
        return Future.error(checkErrors((e as DioError).response));

      return Future.error(['Ocurrió un error desconocido, intenté de nuevo.']);
    }
  }

  Future<dynamic> damage(
    String id_employee,
    String type,
    String id_checkout,
    String explanation,
    String id_tool,
    String id_fleet,
    String token,
  ) async {
    dio.options.headers["Accept"] = "application/json";
    dio.options.headers["Authorization"] = "$token";

    String baseURL = apiUrl + "damage";

    try {
      dynamic response = await dio.post(baseURL,
          data: jsonEncode({
            "id_employee": id_employee,
            "type": type,
            "id_checkout": id_checkout,
            "explanation": explanation,
            "id_tool": id_tool,
            "id_fleet": id_fleet
          }));

      if (response.statusCode == 200) {
        return response.data["damage"];
      } else {
        return Future.error(checkErrors(response.data));
      }
    } catch (e) {
      print("error damage");
      print(e);

      if (e is DioError)
        return Future.error(checkErrors((e as DioError).response));

      return Future.error(['Ocurrió un error desconocido, intenté de nuevo.']);
    }
  }

  Future<dynamic> lost(
    String lost,
    String stolen,
    String details,
    String last_seen,
    String ampm,
    String time,
    String date_incident,
    String id_employee,
    String id_tool,
    String id_checkout,
    String token,
  ) async {
    dio.options.headers["Accept"] = "application/json";
    dio.options.headers["Authorization"] = "$token";

    String baseURL = apiUrl + "lost";

    try {
      dynamic response = await dio.post(baseURL,
          data: jsonEncode({
            "lost": lost,
            "stolen": stolen,
            "details": details,
            "last_seen": last_seen,
            "ampm": ampm,
            "time": time,
            "date_incident": date_incident,
            "id_employee": id_employee,
            "id_tool": id_tool,
            "id_checkout": id_checkout
          }));

      if (response.statusCode == 200) {
        return response.data["lost"];
      } else {
        return Future.error(checkErrors(response.data));
      }
    } catch (e) {
      print("error lost");
      print(e);

      if (e is DioError)
        return Future.error(checkErrors((e as DioError).response));

      return Future.error(['Ocurrió un error desconocido, intenté de nuevo.']);
    }
  }

  Future<UserModel> updateProfileEmployee(String id_employee, String name,
      String last_name, String email, dynamic asset, String token) async {
    dio.options.headers["Accept"] = "application/json";
    dio.options.headers["Authorization"] = "$token";
    String baseURL = apiUrl + "update_profile_employee";

    try {
      FormData formData = new FormData.fromMap({
        "id": id_employee,
        "name": name,
        "last_name": last_name,
        "email": email
      });

      if (asset != null) {
        formData.files.add(MapEntry(
            "picture_upload",
            await MultipartFile.fromFile(asset.path,
                filename: asset.path.split('/').last)));

        dio.options.extra = {"path_file": asset.path};
      }

      final response = await dio.post(baseURL, data: formData);

      if (response.statusCode == 200) {
        dynamic userJson = response.data["user"];
        userJson["token"] = response.data["access_token"];

        return UserModel.fromJson(userJson);
      } else {
        return Future.error(checkErrors(response.data));
      }
    } catch (e) {
      print("error updateProfileEmployee");

      if (e is DioError) {
        print((e as DioError).response);
        return Future.error(checkErrors((e as DioError).response));
      }

      return Future.error(['Ocurrió un error desconocido, intenté de nuevo.']);
    }
  }

  Future<List<String>> getLocations(String token) async {
    dio.options.headers["Accept"] = "application/json";
    dio.options.headers["Authorization"] = "$token";
    String baseURL = apiUrl + "getLocations";
    try {
      final response = await dio.post(baseURL, queryParameters: {});
      if (response.statusCode == 200) {
        final data = List<String>.from(response.data);
        return data;
      } else {
        return Future.error(checkErrors(response.data));
      }
    } catch (e) {
      print("error en getLocations");
      print(e);
      print((e as DioError).response);
      if (e is DioError)
        return Future.error(checkErrors((e as DioError).response));
      return Future.error(['Ocurrió un error desconocido, intenté de nuevo.']);
    }
  }
}
