import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'package:flutter_page_transition/flutter_page_transition.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:wilcoerp/components/custom_dialog.dart';
import 'package:wilcoerp/components/override_date_picker.dart';
import 'package:wilcoerp/constants/colors.dart';
import 'package:wilcoerp/constants/globals.dart';
import 'package:wilcoerp/models/asset.dart';
import 'package:wilcoerp/models/fleet.dart';
import 'package:wilcoerp/models/interface.dart';
import 'package:wilcoerp/models/user.dart';
import 'package:wilcoerp/pages/home_page.dart';
import 'package:wilcoerp/pages/login_page.dart';
import 'package:wilcoerp/pages/profile_user_page.dart';
import 'package:wilcoerp/providers/app.dart';
import 'package:wilcoerp/services/web_service.dart';

dynamic validatePin(String value, BuildContext context) {
  if (value.isEmpty) // The form is empty
    return "Ingrese el pin";
  return null;
}

simpleLoading(BuildContext context, Function callback, {String text = ""}) {
  try {
    FocusScope.of(context).requestFocus(FocusNode());
  } catch (e) {}
  BuildContext contextLoadingDialog = context;
  late StateSetter _setState;
  showDialog<void>(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext contextd) {
      contextLoadingDialog = contextd;
      return StatefulBuilder(builder: (context, setState) {
        _setState = setState;
        return WillPopScope(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Visibility(
                      visible: text != "",
                      child: Flexible(
                          child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(text,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                            )),
                      ))),
                  Container(
                    color: Colors.transparent,
                    child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                            CustomColors.primary)),
                  )
                ],
              ),
            ),
            onWillPop: () async {
              return false;
            });
      });
    },
  );
  callback(contextLoadingDialog);
}

List<dynamic> checkErrors(dynamic responseData) {
  try {
    dynamic json = jsonDecode(responseData.toString());
    if (json.containsKey("errors")) {
      if (json["errors"] is List) {
        return json["errors"];
      } else {
        return [json["errors"]];
      }
    } else {
      return ['Ocurrió un error desconocido, intenté de nuevo.'];
    }
  } catch (e) {
    print(e);
    return ['Ocurrió un error desconocido, intenté de nuevo.'];
  }
}

String formatFirstUpper(String value, {bool cutName = false}) {
  try {
    String name = "";

    if (value == null) return "";
    value = value.toLowerCase();
    if (value != null) {
      name = value.toLowerCase().split(' ').map((word) {
        if (word.trim() != "") {
          return word[0].toUpperCase() + word.substring(1);
        } else {
          return "";
        }
      }).join(' ');
    } else {
      return "";
    }

    final pattern = RegExp('\\s+');
    name = name.replaceAll(pattern, " ");

    if (!cutName) return name;

    var nameParts = name.split(' ');
    print("nameParts:" + nameParts.toString());
    if (nameParts.length >= 4) {
      name = nameParts[0] + " " + nameParts[2][0] + ".";
    } else if (nameParts.length == 3) {
      name = nameParts[0] + " " + nameParts[2][0] + ".";
    } else if (nameParts.length == 2) {
      name = nameParts[0] + " " + nameParts[1][0] + ".";
    } else if (nameParts.length == 1) {
      name = nameParts[0];
    }
    return name;
  } catch (e) {
    return value;
  }
}

String getDateTimeFromStringFormat(String dateS) {
  if (dateS.trim() == "") return "";
  DateTime date = DateTime.parse(dateS).toUtc();
  DateTime dateLocal = date.toLocal();

  return DateFormat('dd-MM-yyyy hh:mm a', "en_US").format(dateLocal);
}

PreferredSizeWidget getAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: CustomColors.primary,
    title: Text("",
        style: TextStyle(
          color: CustomColors.primary,
          fontSize: 20.0,
        )),
    elevation: 0,
    centerTitle: true,
    leading: new IconButton(
      icon: new Icon(
        Icons.menu,
        size: 25,
        color: Colors.white,
      ),
      onPressed: () {
        Navigator.pushAndRemoveUntil(
            context,
            PageTransition(
                child: HomePage(),
                type: PageTransitionType.slideInUp,
                duration: Duration(milliseconds: 250)),
            (Route<dynamic> route) => false);
      },
    ),
    actions: [
      new IconButton(
        icon: new Icon(
          FontAwesomeIcons.solidUserCircle,
          size: 25,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.push(
              context,
              PageTransition(
                  child: ProfileUserPage(),
                  type: PageTransitionType.slideInUp,
                  duration: Duration(milliseconds: 500)));
        },
      ),
    ],
    flexibleSpace: Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 26.0),
        child: Image.asset(
          'assets/images/logo_white.png',
          height: 50,
        ),
      ),
    ),
  );
}

bool checkEmpty(data) {
  if (data == null || data == "") {
    return false;
  } else {
    return true;
  }
}

dynamic validateMiles(String value, BuildContext context) {
  if (value.isEmpty) // The form is empty
    return "Enter the miles";
  return null;
}

dynamic validateAny(String value, BuildContext context) {
  if (value.isEmpty) // The form is empty
    return "Complete the field";
  return null;
}

dynamic validateEmail(String value, BuildContext context) {
  if (value.isEmpty) {
    // The form is empty
    return "This field is required";
  }
  // This is just a regular expression for email addresses
  String p = "[a-zA-Z0-9\+\.\_\%\-\+]{1,256}" +
      "\\@" +
      "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}" +
      "(" +
      "\\." +
      "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25}" +
      ")+";
  RegExp regExp = new RegExp(p);

  if (regExp.hasMatch(value)) {
    // So, the email is valid
    return null;
  } else {
    return "The email is not valid";
  }
}

registerLocation(BuildContext context, {dynamic contextDialog = null}) async {
  try {
    if (contextDialogLocation != null &&
        contextDialogLocation is BuildContext) {
      Navigator.pop(contextDialogLocation);
    }
  } catch (e) {}
  final provider = Provider.of<AppProvider>(context, listen: false);
  bool serviceEnabled = false;
  LocationPermission permission;
  serviceEnabled = await Geolocator.isLocationServiceEnabled();

  if (!serviceEnabled) {
    await Geolocator.openLocationSettings();
  }
  serviceEnabled = await Geolocator.isLocationServiceEnabled();

  await Geolocator.requestPermission();
  permission = await Geolocator.checkPermission();

  if (serviceEnabled == true &&
      (permission != LocationPermission.denied &&
          permission != LocationPermission.deniedForever)) {
    try {
      if (contextDialogLocation != null &&
          contextDialogLocation is BuildContext) {
        Navigator.pop(contextDialogLocation);
      }
    } catch (e) {}

    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      provider.setLocation(position.latitude, position.longitude);
      /* provider.user.long = position.longitude;
      provider.setUser(provider.user);
      print("lat");
      print(position.latitude);
      print("lng");
      print(position.longitude);
      WebService(context).updateLocationUser(
          provider.user.id ?? "",
          position.latitude ?? 0,
          position.longitude ?? 0,
          provider.user.token ?? "");*/
    } catch (e) {
      registerLocation(context);
    }
  } else {
    if (Theme.of(context).platform == TargetPlatform.iOS) {
      return;
    }

    showDialog<void>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext contextd) {
        contextDialogLocation = contextd;
        return StatefulBuilder(builder: (contextS, setState) {
          return WillPopScope(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    height: 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(110 / 2)),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: CustomColors.primary.withOpacity(0.5),
                          blurRadius: 110 / 10,
                          offset: Offset(0, 110 / 10),
                        ),
                      ],
                    ),
                    child: MaterialButton(
                      color: CustomColors.primary,
                      padding: EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        side: BorderSide.none,
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            child: Container(
                                width: 20,
                                child: Icon(
                                  Icons.location_off,
                                  color: Colors.white,
                                  size: 35,
                                )),
                          ),
                          Row(
                            children: [
                              Flexible(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                      "Es necesario activar los permisos de ubicación. ",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.normal),
                                      textAlign: TextAlign.center),
                                ),
                              )
                            ],
                          ),
                          Row(
                            // Replace with a Row for horizontal icon + text
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Expanded(
                                child: Text(
                                  "Activar los servicios de ubicación.",
                                  textAlign: TextAlign.center,
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Container(
                                  width: 20,
                                  child: Icon(
                                    FontAwesomeIcons.chevronRight,
                                    color: Colors.white,
                                    size: 20,
                                  )),
                            ],
                          )
                        ],
                      ),
                      onPressed: () async {
                        registerLocation(context, contextDialog: contextd);
                      },
                    ),
                  ),
                ),
              ),
              onWillPop: () async {
                return false;
              });
        });
      },
    );
  }
}

String getImageUrl(String img) {
  return imagesUrlProfiles + img;
}

showErrorsDialog(BuildContext context, dynamic errors,
    {dynamic callback = null}) async {
  print(errors);
  if (errors is List<dynamic> && errors.length <= 0) return;
  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (contextDialog) {
        return CustomDialog(
          "",
          errors.join(".\n"),
          "Accept",
          () {
            if (callback != null && callback is Function) callback();
          },
          useBtnCancel: false,
          image: '',
        );
      });
}

logout(BuildContext context, {bool direct = false, String messageAfter = ""}) {
  BuildContext mainContext = context;
  final provider = Provider.of<AppProvider>(context, listen: false);
  final UserModel user = provider.user;

  if (direct) {
    simpleLoading(context, (BuildContext loadingContext) async {
      try {
        UserModel user = provider.user;

        UserModel userTmp = UserModel();
        userTmp.id = null;
        userTmp.name = null;

        userTmp.picture = null;
        userTmp.id_rol = null;

        userTmp.status = null;
        userTmp.token = null;

        userTmp.created_at = null;
        userTmp.updated_at = null;

        await provider.setUser(userTmp);

        Navigator.pop(loadingContext);

        SchedulerBinding.instance.addPostFrameCallback((_) {
          Navigator.pushAndRemoveUntil(
              context,
              PageTransition(
                  child: LoginPage(),
                  type: PageTransitionType.slideInUp,
                  duration: Duration(milliseconds: 250)),
              (Route<dynamic> route) => false);
        });
      } catch (e) {
        print(e);

        Navigator.pop(loadingContext);
        showErrorsDialog(
            context, ["Ocurrió un error desconocido, intente de nuevo."]);
      }
    });
  } else {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (contextDialog) {
          return CustomDialog(
            "",
            "Do you want to log out?",
            "Accept",
            () {
              simpleLoading(context, (BuildContext loadingContext) async {
                try {
                  UserModel user = provider.user;

                  Navigator.pop(loadingContext);

                  SchedulerBinding.instance.addPostFrameCallback((_) {
                    Navigator.pushAndRemoveUntil(
                        context,
                        PageTransition(
                            child: LoginPage(),
                            type: PageTransitionType.slideInUp,
                            duration: Duration(milliseconds: 250)),
                        (Route<dynamic> route) => false);

                    UserModel userTmp = UserModel();
                    userTmp.id = null;
                    userTmp.name = null;

                    userTmp.picture = null;
                    userTmp.id_rol = null;

                    userTmp.status = null;
                    userTmp.token = null;

                    userTmp.created_at = null;
                    userTmp.updated_at = null;

                    provider.setUser(userTmp);
                  });
                } catch (e) {
                  print(e);

                  Navigator.pop(loadingContext);
                  showErrorsDialog(context,
                      ["Ocurrió un error desconocido, intente de nuevo."]);
                }
              });
            },
            useBtnCancel: true,
            image: '',
          );
        });
  }
}

initProcess(BuildContext context, UserModel user, Function callback) async {
  final provider = Provider.of<AppProvider>(context, listen: false);

  Future.wait([
    WebService(context).getInterfaces("equipment_trailer", user.token!),
    WebService(context).getInterfaces("trucks_cars", user.token!),
    WebService(context).getCheckout(user.token!, user.id!),
    WebService(context).getCheckoutTool(user.token!, user.id!)
  ]).then((List responses) async {
    checksTrailers = setOrderInterfaces(responses[0]);
    checksTrucks = setOrderInterfaces(responses[1]);
    print("TAMAO DE TRAILERS");
    print(checksTrailers.length);
    for (var i = 0; i < checksTrailers.length; i++) {
      print(checksTrailers[i].type);
    }
    checksTrucks.insert(
        0,
        InterfaceModel(
            id: -1,
            order: -1,
            picture: "odometro.png",
            title: "ODOMETER READING",
            type: "OdometerReadingPage",
            widget: "OdometerReadingPage"));

    checksTrucks = setOrderInterfaces(checksTrucks);
    provider.setCheckout(responses[2]);

    provider.setCheckoutsTools(responses[3]);
    callback();
  }).catchError((err) {
    print("error al cargar la información inicial");
    print(err);

    Navigator.pushAndRemoveUntil(
        context,
        PageTransition(
            child: LoginPage(),
            type: PageTransitionType.slideInUp,
            duration: Duration(milliseconds: 250)),
        (Route<dynamic> route) => false);
  });
}

setOrderInterfaces(List<InterfaceModel> interfaces) {
  List<InterfaceModel> tmp = [];

  for (var i = 0; i < interfaces.length; i++) {
    interfaces[i].order = i;
    tmp.add(interfaces[i]);
  }
  return tmp;
}

registerCheckOut(Function callback, BuildContext context) {
  simpleLoading(context, (BuildContext loadingContext) {
    final provider = Provider.of<AppProvider>(context, listen: false);

    print("place");
    print(place);
    if (!checkEmpty(place) || !checkEmpty(checkout_fleet)) {
      Navigator.pop(loadingContext);
      showErrorsDialog(context, ["An error occurred, repeat the process"]);
      return;
    }
    WebService(context)
        .checkoutFleet(
            place,
            checkout_problem_found,
            provider.user.id.toString(),
            (checkout_fleet as FleetModel).id.toString(),
            provider.user.token ?? "",
            lat: lat,
            lng: lng,
            odometer_reading: checkout_odometer_reading)
        .then((checkout) async {
      checkout_fleet = null;
      checkout_odometer_reading = null;
      checkout_problem_found = null;
      place = null;
      lat = null;
      lng = null;
      provider.setCheckout(checkout);
      for (var i = 0; i < (interfacesToRegister as List).length; i++) {
        dynamic interfaceItem = (interfacesToRegister as List)[i];

        await WebService(context).addCheck(
            interfaceItem["id"],
            interfaceItem["status"],
            interfaceItem["is_critical"],
            interfaceItem["type"],
            checkout.id.toString(),
            provider.user.token ?? "");
      }

      interfacesToRegister = [];
      Navigator.pop(loadingContext);
      callback();
    }).catchError((e) {
      print("Error");
      print(e);
      Navigator.pop(loadingContext);
      showErrorsDialog(context, e);
    });
  });
}

registerCheckIn(Function callback, String id_check_out, BuildContext context) {
  simpleLoading(context, (BuildContext loadingContext) {
    final provider = Provider.of<AppProvider>(context, listen: false);

    if (!checkEmpty(place)) {
      Navigator.pop(loadingContext);
      showErrorsDialog(context, ["An error occurred, repeat the process"]);
      return;
    }
    WebService(context)
        .checkInFleet(
            place,
            provider.user.id.toString(),
            (provider.checkout!.fleet as FleetModel).id.toString(),
            provider.user.token ?? "",
            id_check_out,
            lat: lat,
            lng: lng,
            odometer_reading: checkout_odometer_reading)
        .then((checkin) async {
      checkout_fleet = null;
      checkout_odometer_reading = null;
      checkout_problem_found = null;
      place = null;
      lat = null;
      lng = null;
      provider.setCheckout(null);

      for (var i = 0; i < (interfacesToRegister as List).length; i++) {
        dynamic interfaceItem = (interfacesToRegister as List)[i];

        await WebService(context).addCheck(
            interfaceItem["id"],
            interfaceItem["status"],
            interfaceItem["is_critical"],
            interfaceItem["type"],
            checkin["id"].toString(),
            provider.user.token ?? "");
      }

      interfacesToRegister = [];
      Navigator.pop(loadingContext);
      callback();
    }).catchError((e) {
      print("Error");
      print(e);
      Navigator.pop(loadingContext);
      showErrorsDialog(context, e);
    });
  });
}

setCheck(String id, String status, String is_critical, String type) {
  interfacesToRegister.add(
      {"id": id, "status": status, "is_critical": is_critical, "type": type});
}
