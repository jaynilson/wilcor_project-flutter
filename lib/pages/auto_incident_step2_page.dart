import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_page_transition/flutter_page_transition.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:wilcoerp/components/big_button_menus.dart';
import 'package:wilcoerp/constants/colors.dart';
import 'package:wilcoerp/constants/globals.dart';
import 'package:wilcoerp/helpers/helpers.dart';
import 'package:wilcoerp/models/fleet.dart';
import 'package:wilcoerp/pages/auto_incident_step3_page.dart';
import 'package:wilcoerp/pages/select_trucks_cars_page.dart';
import 'package:wilcoerp/pages/utility_damage_step6_page.dart';

class AutoIncidentStep2Page extends StatefulWidget {
  const AutoIncidentStep2Page({super.key});

  @override
  State<AutoIncidentStep2Page> createState() => _AutoIncidentStep2PageState();
}

class _AutoIncidentStep2PageState extends State<AutoIncidentStep2Page> {
  final cDriver = TextEditingController();
  final cPassenger = TextEditingController();
  final cDriverLicense = TextEditingController();
  final cDriverDateOfBirth = TextEditingController();
  final cDateOfAccident = TextEditingController();
  final cTime = TextEditingController();

  final formKey = new GlobalKey<FormState>();

  String ampm = "AM";
  @override
  Widget build(BuildContext context) {
    InputDecoration decorationFields = InputDecoration(
      contentPadding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
      hintText: "",
      hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
      fillColor: Colors.grey.shade300,
      focusColor: Colors.grey,
      hoverColor: Colors.grey,
      filled: true,
      border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade400, width: 0),
          borderRadius: BorderRadius.circular(10.0)),
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade400, width: 0),
          borderRadius: BorderRadius.circular(10.0)),
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade400, width: 0),
          borderRadius: BorderRadius.circular(10.0)),
      errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade400, width: 0),
          borderRadius: BorderRadius.circular(10.0)),
      focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade400, width: 0),
          borderRadius: BorderRadius.circular(10.0)),
    );
    final driverField = TextFormField(
      autofocus: false,
      textInputAction: TextInputAction.next,
      controller: cDriver,
      keyboardType: TextInputType.text,
      readOnly: false,
      validator: (val) {
        return validateAny(val ?? "", context);
      },
      obscureText: false,
      style: TextStyle(fontSize: 18.0),
      //initialValue: Environment.localUsername(),
      decoration: decorationFields,
      onFieldSubmitted: (val) {},
    );

    final passengerField = TextFormField(
      autofocus: false,
      textInputAction: TextInputAction.next,
      controller: cPassenger,
      keyboardType: TextInputType.text,
      readOnly: false,
      validator: (val) {
        return validateAny(val ?? "", context);
      },
      obscureText: false,
      style: TextStyle(fontSize: 18.0),
      //initialValue: Environment.localUsername(),
      decoration: decorationFields,
      onFieldSubmitted: (val) {},
    );

    final driverLicenseField = TextFormField(
      autofocus: false,
      textInputAction: TextInputAction.next,
      controller: cDriverLicense,
      keyboardType: TextInputType.text,
      readOnly: false,
      validator: (val) {
        return validateAny(val ?? "", context);
      },
      obscureText: false,
      style: TextStyle(fontSize: 18.0),
      //initialValue: Environment.localUsername(),
      decoration: decorationFields,
      onFieldSubmitted: (val) {},
    );

    final driverDateOfBirthField = TextFormField(
      autofocus: false,
      textInputAction: TextInputAction.next,
      controller: cDriverDateOfBirth,
      keyboardType: TextInputType.text,
      readOnly: true,
      onTap: () {
        selectedDate();
      },
      validator: (val) {
        return validateAny(val ?? "", context);
      },
      obscureText: false,
      style: TextStyle(fontSize: 18.0),
      //initialValue: Environment.localUsername(),
      decoration: decorationFields,
      onFieldSubmitted: (val) {},
    );

    final dateOfAccidentField = TextFormField(
      autofocus: false,
      textInputAction: TextInputAction.next,
      controller: cDateOfAccident,
      keyboardType: TextInputType.text,
      readOnly: false,
      validator: (val) {
        return validateAny(val ?? "", context);
      },
      obscureText: false,
      style: TextStyle(fontSize: 18.0),
      //initialValue: Environment.localUsername(),
      decoration: decorationFields,
      onFieldSubmitted: (val) {},
    );

    final timeField = TextFormField(
      autofocus: false,
      textInputAction: TextInputAction.next,
      controller: cTime,
      keyboardType: TextInputType.datetime,
      readOnly: false,
      validator: (val) {
        return validateAny(val ?? "", context);
      },
      obscureText: false,
      style: TextStyle(fontSize: 18.0),
      //initialValue: Environment.localUsername(),
      decoration: decorationFields,
      onFieldSubmitted: (val) {},
    );

    return Scaffold(
      extendBody: true,
      appBar: getAppBar(context),
      body: Center(
        child: ListView(
          shrinkWrap: true,
          children: [
            Padding(
              padding: EdgeInsets.all(MediaQuery.of(context).size.width * .08),
              child: Center(
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "AUTO INCIDENT",
                        style: TextStyle(
                            color: CustomColors.primary, fontSize: 25),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Text(
                              "Driver",
                              style: TextStyle(color: Colors.grey.shade600),
                            ),
                          ),
                          driverField,
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Text(
                              "Passenger",
                              style: TextStyle(color: Colors.grey.shade600),
                            ),
                          ),
                          passengerField,
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Text(
                              "Driver license #",
                              style: TextStyle(color: Colors.grey.shade600),
                            ),
                          ),
                          driverLicenseField,
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Text(
                              "Driver date of birth",
                              style: TextStyle(color: Colors.grey.shade600),
                            ),
                          ),
                          driverDateOfBirthField,
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Flexible(
                            flex: 5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10.0),
                                  child: Text(
                                    "Time",
                                    style:
                                        TextStyle(color: Colors.grey.shade600),
                                  ),
                                ),
                                timeField,
                              ],
                            ),
                          ),
                          Flexible(
                            flex: 2,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      ampm = "AM";
                                    });
                                  },
                                  child: Container(
                                    width: 150,
                                    height: 40,
                                    child: ListTile(
                                      horizontalTitleGap: 1,
                                      contentPadding: EdgeInsets.all(0),
                                      title: Text(
                                        'AM',
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                      leading: Radio<String>(
                                        value: "AM",
                                        groupValue: ampm,
                                        onChanged: (String? value) {
                                          setState(() {
                                            ampm = value ?? "";
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      ampm = "PM";
                                    });
                                  },
                                  child: Container(
                                    width: 150,
                                    height: 40,
                                    child: ListTile(
                                      horizontalTitleGap: 1,
                                      contentPadding: EdgeInsets.all(0),
                                      title: Text(
                                        'PM',
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                      leading: Radio<String>(
                                        value: "PM",
                                        groupValue: ampm,
                                        onChanged: (String? value) {
                                          setState(() {
                                            ampm = value ?? "";
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            elevation: 2,
                            primary: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            )),
                        onPressed: () {
                          next();
                        },
                        child: Container(
                          width: double.infinity,
                          height: 55.0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Flexible(
                                flex: 12,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Flexible(
                                          child: Text(
                                            "NEXT",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20.0,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  selectedDate() async {
    DateTime? newDateTime = await showRoundedDatePicker(
      context: context,
      initialDate: DateTime.now(),
      borderRadius: 16,
    );
    if (newDateTime != null) {
      cDriverDateOfBirth.text =
          '${newDateTime.year}-${newDateTime.month}-${newDateTime.day}';
    } else {
      cDriverDateOfBirth.text = "";
    }
  }

  next() async {
    final form = formKey.currentState;
    if (form!.validate()) {
      form.save();
      id_fleet_report_auto_incident =
          (checkout_fleet as FleetModel).id.toString();

      report_auto_incident.add(
          {"question_text": "Driver", "content": cDriver.text, "type": "text"});

      report_auto_incident.add({
        "question_text": "Passenger",
        "content": cPassenger.text,
        "type": "text"
      });

      report_auto_incident.add({
        "question_text": "Driver license #",
        "content": cDriverLicense.text,
        "type": "text"
      });

      report_auto_incident.add({
        "question_text": "Driver date of birth",
        "content": cDriverDateOfBirth.text,
        "type": "text"
      });
      report_auto_incident.add({
        "question_text": "Time",
        "content": cTime.text + " " + ampm,
        "type": "text"
      });

      Navigator.push(
          context,
          PageTransition(
              child: AutoIncidentStep3Page(),
              type: PageTransitionType.slideInUp,
              duration: Duration(milliseconds: 500)));
    }
  }
}
