import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_page_transition/flutter_page_transition.dart';
import 'package:wilcoerp/components/big_button_menus.dart';
import 'package:wilcoerp/constants/colors.dart';
import 'package:wilcoerp/constants/globals.dart';
import 'package:wilcoerp/helpers/helpers.dart';
import 'package:wilcoerp/pages/auto_incident_step3_page.dart';
import 'package:wilcoerp/pages/auto_incident_step6_page.dart';
import 'package:wilcoerp/pages/select_trucks_cars_page.dart';
import 'package:wilcoerp/pages/utility_damage_step6_page.dart';

class AutoIncidentStep5Page extends StatefulWidget {
  const AutoIncidentStep5Page({super.key});

  @override
  State<AutoIncidentStep5Page> createState() => _AutoIncidentStep5PageState();
}

class _AutoIncidentStep5PageState extends State<AutoIncidentStep5Page> {
  final cAccidentDescription = TextEditingController();

  String photosTaken = "";
  String injuryToEitherParty = "";
  String didMedicsArrive = "";

  final cTime = TextEditingController();

  final formKey = new GlobalKey<FormState>();

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

    final accidentDescriptionField = TextFormField(
      autofocus: false,
      textInputAction: TextInputAction.next,
      controller: cAccidentDescription,
      keyboardType: TextInputType.multiline,
      maxLines: null,
      expands: true,
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
                              "Photos taken?",
                              style: TextStyle(color: Colors.grey.shade600),
                            ),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Flexible(
                                flex: 2,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          photosTaken = "YES";
                                        });
                                      },
                                      child: Container(
                                        width: 150,
                                        height: 40,
                                        child: ListTile(
                                          horizontalTitleGap: 1,
                                          contentPadding: EdgeInsets.all(0),
                                          title: Text(
                                            'YES',
                                            style:
                                                TextStyle(color: Colors.grey),
                                          ),
                                          leading: Radio<String>(
                                            value: "YES",
                                            groupValue: photosTaken,
                                            onChanged: (String? value) {
                                              setState(() {
                                                photosTaken = value ?? "";
                                              });
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
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
                                          photosTaken = "NO";
                                        });
                                      },
                                      child: Container(
                                        width: 150,
                                        height: 40,
                                        child: ListTile(
                                          horizontalTitleGap: 1,
                                          contentPadding: EdgeInsets.all(0),
                                          title: Text(
                                            'NO',
                                            style:
                                                TextStyle(color: Colors.grey),
                                          ),
                                          leading: Radio<String>(
                                            value: "NO",
                                            groupValue: photosTaken,
                                            onChanged: (String? value) {
                                              setState(() {
                                                photosTaken = value ?? "";
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
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Text(
                              "Injury to either party??",
                              style: TextStyle(color: Colors.grey.shade600),
                            ),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Flexible(
                                flex: 2,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          injuryToEitherParty = "YES";
                                        });
                                      },
                                      child: Container(
                                        width: 150,
                                        height: 40,
                                        child: ListTile(
                                          horizontalTitleGap: 1,
                                          contentPadding: EdgeInsets.all(0),
                                          title: Text(
                                            'YES',
                                            style:
                                                TextStyle(color: Colors.grey),
                                          ),
                                          leading: Radio<String>(
                                            value: "YES",
                                            groupValue: injuryToEitherParty,
                                            onChanged: (String? value) {
                                              setState(() {
                                                injuryToEitherParty =
                                                    value ?? "";
                                              });
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
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
                                          injuryToEitherParty = "NO";
                                        });
                                      },
                                      child: Container(
                                        width: 150,
                                        height: 40,
                                        child: ListTile(
                                          horizontalTitleGap: 1,
                                          contentPadding: EdgeInsets.all(0),
                                          title: Text(
                                            'NO',
                                            style:
                                                TextStyle(color: Colors.grey),
                                          ),
                                          leading: Radio<String>(
                                            value: "NO",
                                            groupValue: injuryToEitherParty,
                                            onChanged: (String? value) {
                                              setState(() {
                                                injuryToEitherParty =
                                                    value ?? "";
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
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Text(
                              "Did medics arrive?",
                              style: TextStyle(color: Colors.grey.shade600),
                            ),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Flexible(
                                flex: 2,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          didMedicsArrive = "YES";
                                        });
                                      },
                                      child: Container(
                                        width: 150,
                                        height: 40,
                                        child: ListTile(
                                          horizontalTitleGap: 1,
                                          contentPadding: EdgeInsets.all(0),
                                          title: Text(
                                            'YES',
                                            style:
                                                TextStyle(color: Colors.grey),
                                          ),
                                          leading: Radio<String>(
                                            value: "YES",
                                            groupValue: didMedicsArrive,
                                            onChanged: (String? value) {
                                              setState(() {
                                                didMedicsArrive = value ?? "";
                                              });
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
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
                                          didMedicsArrive = "NO";
                                        });
                                      },
                                      child: Container(
                                        width: 150,
                                        height: 40,
                                        child: ListTile(
                                          horizontalTitleGap: 1,
                                          contentPadding: EdgeInsets.all(0),
                                          title: Text(
                                            'NO',
                                            style:
                                                TextStyle(color: Colors.grey),
                                          ),
                                          leading: Radio<String>(
                                            value: "NO",
                                            groupValue: didMedicsArrive,
                                            onChanged: (String? value) {
                                              setState(() {
                                                didMedicsArrive = value ?? "";
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
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Text(
                              "Accident description (please be specific)",
                              style: TextStyle(color: Colors.grey.shade600),
                            ),
                          ),
                          Container(
                              height: 100,
                              width: MediaQuery.of(context).size.width,
                              child: accidentDescriptionField),
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

  next() async {
    final form = formKey.currentState;
    if (form!.validate()) {
      form.save();
      if (photosTaken == "" ||
          injuryToEitherParty == "" ||
          didMedicsArrive == "") {
        showErrorsDialog(
            context, ["You must choose one option for each question"]);
        return;
      }
      report_auto_incident.add({
        "question_text": "Photos taken?",
        "content": photosTaken,
        "type": "radio"
      });

      report_auto_incident.add({
        "question_text": "Injury to either party?",
        "content": injuryToEitherParty,
        "type": "radio"
      });

      report_auto_incident.add({
        "question_text": "Did medics arrive?",
        "content": didMedicsArrive,
        "type": "radio"
      });
      report_auto_incident.add({
        "question_text": "Accident description",
        "content": cAccidentDescription.text,
        "type": "text"
      });

      Navigator.push(
          context,
          PageTransition(
              child: AutoIncidentStep6Page(),
              type: PageTransitionType.slideInUp,
              duration: Duration(milliseconds: 500)));
    }
  }
}
