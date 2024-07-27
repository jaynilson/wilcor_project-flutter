import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wilcoerp/models/checkout.dart';
import 'package:wilcoerp/models/user.dart';
import 'package:wilcoerp/models/app_preferences.dart';

class AppProvider with ChangeNotifier {
  UserModel _user = UserModel();
  double _lat = 40.411179;
  double _long = -3.701137;
  dynamic _fromIconPin ;
  double get lat => _lat;
  double get long => _long;
  UserModel get user => _user;
  BitmapDescriptor get getFromIconPin => _fromIconPin;
  dynamic _checkout ;
  CheckOut? get checkout => _checkout;

  List<CheckOut> _checkoutsTools = [];
  List<CheckOut> get checkoutsTools => _checkoutsTools;

  setLocation(double lat, double long) {
    _lat = lat;
    _long = long;
    notifyListeners();
  }

  setCheckout(CheckOut? checkout) {
    _checkout = checkout;
    notifyListeners();
  }

  setCheckoutsTools(List<CheckOut> checkouts) {
    _checkoutsTools = checkouts;
    notifyListeners();
  }

  setUser(UserModel user) async {
    _user = user;
    await AppPreferences().setUser(user);
    notifyListeners();
  }

  setFromIconPin(BitmapDescriptor fromIconPin) {
    _fromIconPin = fromIconPin;
    notifyListeners();
  }
}
