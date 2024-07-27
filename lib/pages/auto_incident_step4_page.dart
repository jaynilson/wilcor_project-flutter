import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_page_transition/flutter_page_transition.dart';
import 'package:wilcoerp/components/big_button_menus.dart';
import 'package:wilcoerp/constants/colors.dart';
import 'package:wilcoerp/constants/globals.dart';
import 'package:wilcoerp/helpers/helpers.dart';
import 'package:wilcoerp/pages/auto_incident_step3_page.dart';
import 'package:wilcoerp/pages/auto_incident_step5_page.dart';
import 'package:wilcoerp/pages/select_trucks_cars_page.dart';
import 'package:wilcoerp/pages/utility_damage_step6_page.dart';

class AutoIncidentStep4Page extends StatefulWidget {
  const AutoIncidentStep4Page({super.key});

  @override
  State<AutoIncidentStep4Page> createState() => _AutoIncidentStep4PageState();
}

class _AutoIncidentStep4PageState extends State<AutoIncidentStep4Page> {
  final cSpeedLimit = TextEditingController();
  final cCitationNo = TextEditingController();
  final cIssuingAuthorithy = TextEditingController();

  String wasDriverWearing = "";
  String wasDriverUsingCellPhone = "";
  String noCitationIssued = "";

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

    final speedLimitField = TextFormField(
      autofocus: false,
      textInputAction: TextInputAction.next,
      controller: cSpeedLimit,
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

    final citationNoField = TextFormField(
      autofocus: false,
      textInputAction: TextInputAction.next,
      controller: cCitationNo,
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

    final issuingAuthorithyField = TextFormField(
      autofocus: false,
      textInputAction: TextInputAction.next,
      controller: cIssuingAuthorithy,
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
                              "Speed limit",
                              style: TextStyle(color: Colors.grey.shade600),
                            ),
                          ),
                          speedLimitField,
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Text(
                              "Was driver wearing a seatbelt?",
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
                                          wasDriverWearing = "YES";
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
                                            groupValue: wasDriverWearing,
                                            onChanged: (String? value) {
                                              setState(() {
                                                wasDriverWearing = value ?? "";
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
                                          wasDriverWearing = "NO";
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
                                            groupValue: wasDriverWearing,
                                            onChanged: (String? value) {
                                              setState(() {
                                                wasDriverWearing = value ?? "";
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
                              "Was driver using a cell phone?",
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
                                          wasDriverUsingCellPhone = "YES";
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
                                            groupValue: wasDriverUsingCellPhone,
                                            onChanged: (String? value) {
                                              setState(() {
                                                wasDriverUsingCellPhone =
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
                                          wasDriverUsingCellPhone = "NO";
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
                                            groupValue: wasDriverUsingCellPhone,
                                            onChanged: (String? value) {
                                              setState(() {
                                                wasDriverUsingCellPhone =
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
                              "No Citation issued?",
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
                                          noCitationIssued = "YES";
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
                                            groupValue: noCitationIssued,
                                            onChanged: (String? value) {
                                              setState(() {
                                                noCitationIssued = value ?? "";
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
                                          noCitationIssued = "NO";
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
                                            groupValue: noCitationIssued,
                                            onChanged: (String? value) {
                                              setState(() {
                                                noCitationIssued = value ?? "";
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
                              "Citation No.",
                              style: TextStyle(color: Colors.grey.shade600),
                            ),
                          ),
                          citationNoField,
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Text(
                              "Issuing authorithy",
                              style: TextStyle(color: Colors.grey.shade600),
                            ),
                          ),
                          issuingAuthorithyField,
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

      if (wasDriverWearing == "" ||
          wasDriverUsingCellPhone == "" ||
          noCitationIssued == "") {
        showErrorsDialog(
            context, ["You must choose one option for each question"]);
        return;
      }
      report_auto_incident.add({
        "question_text": "Speed limit",
        "content": cSpeedLimit.text,
        "type": "text"
      });

      report_auto_incident.add({
        "question_text": "Was driver wearing a seatbelt?",
        "content": wasDriverWearing,
        "type": "radio"
      });
      report_auto_incident.add({
        "question_text": "Was driver using a cell phone?",
        "content": wasDriverUsingCellPhone,
        "type": "radio"
      });
      report_auto_incident.add({
        "question_text": "No citation issued?",
        "content": noCitationIssued,
        "type": "radio"
      });

      report_auto_incident.add({
        "question_text": "Citation No.",
        "content": cCitationNo.text,
        "type": "text"
      });

      report_auto_incident.add({
        "question_text": "Issuing authorithy",
        "content": cIssuingAuthorithy.text,
        "type": "text"
      });

      Navigator.push(
          context,
          PageTransition(
              child: AutoIncidentStep5Page(),
              type: PageTransitionType.slideInUp,
              duration: Duration(milliseconds: 500)));
    }
  }
}
