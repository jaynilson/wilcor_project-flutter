library wilcoerp.globals;

import 'package:flutter/foundation.dart';
import 'package:wilcoerp/models/interface.dart';
import 'package:wilcoerp/pages/odometer_reading_page.dart';

String urlTest =
    "https://wilcoerp.com"; //http://192.168.8.5:8000 https://wilcoerp.com

String apiUrl = "${urlTest}/api/";
String apiSocket = urlTest;
String imagesUrlProfiles = "${urlTest}/storage/images/profiles/";
String imagesUrlFleet = "${urlTest}/storage/images/fleet/";
String imagesUrlTool = "${urlTest}/storage/images/tools/";
String imagesUrlInterfaces = "${urlTest}/storage/images/interface/";

String oneSignalAppIdAndroid = "6802c48a-c0e0-4058-af8f-cd96baeec07a";
String oneSignalAppIdIos = "ed9df184-86d7-4fbb-816d-08f7647252f5";

String googleApiKey = "AIzaSyDcAXbQ_jb-cajBb4MN27gEhP7spqsZPgk";
dynamic contextDialogLocation = null;

List<InterfaceModel> checksTrucks = [];

List<InterfaceModel> checksTrailers = [];

dynamic checkout_fleet = null;
dynamic checkout_odometer_reading = null;
dynamic checkout_problem_found = null;
dynamic place = null;
dynamic lat = null;
dynamic lng = null;

dynamic global_category = null;
dynamic global_description = null;
dynamic global_audio_record = null;
/*
dynamic checksTrucks = [
  {
    "order": 0,
    "image": "odometro.png",
    "title": "ODOMETER READING",
    "type": "OdometerReadingPage",
    "status": "",
    "data": "",
    "description": ""
  },
  {
    "order": 1,
    "image": "clutch.png",
    "title": "CLUTCH",
    "type": "check",
    "page_widget": null,
    "status": "",
    "data": "",
    "description": ""
  },
  {
    "order": 2,
    "image": "break.png",
    "title": "BRAKE PARKING",
    "type": "check",
    "page_widget": null,
    "status": "",
    "data": "",
    "description": ""
  },
  {
    "order": 3,
    "image": "compressor.png",
    "title": "AIR COMPRESSOR",
    "type": "check",
    "page_widget": null,
    "status": "",
    "data": "",
    "description": ""
  },
  {
    "order": 4,
    "image": "battery.png",
    "title": "BATTERY",
    "type": "check",
    "page_widget": null,
    "status": "",
    "data": "",
    "description": ""
  }
];


*/
/*
  {
    "order": 0,
    "image": "brake-connection.png",
    "title": "BRAKE CONNECTIONS",
    "type": "check",
    "status": "",
    "data": "",
    "description": ""
  },
  {
    "order": 1,
    "image": "clutch.png",
    "title": "BRAKES",
    "type": "check",
    "page_widget": null,
    "status": "",
    "data": "",
    "description": ""
  },
  {
    "order": 2,
    "image": "coupling-devices.png",
    "title": "COUPLING DEVICES",
    "type": "check",
    "page_widget": null,
    "status": "",
    "data": "",
    "description": ""
  },
  {
    "order": 3,
    "image": "coupling-king-pin.png",
    "title": "COUPLING (KING) PIN",
    "type": "check",
    "page_widget": null,
    "status": "",
    "data": "",
    "description": ""
  },
  {
    "order": 4,
    "image": "doors.png",
    "title": "DOORS",
    "type": "check",
    "page_widget": null,
    "status": "",
    "data": "",
    "description": ""
  }


*/

List<dynamic> report_employee_incident = [];
List<dynamic> report_utility_damage = [];
String id_fleet_report_auto_incident = "";
List<dynamic> report_auto_incident = [];

String id_report_auto_incident = "";

List<dynamic> report_witness_incident_injury = [];

dynamic checkout_tool_selected = null;
dynamic checkout_tool = null;

dynamic interfacesToRegister = [];
