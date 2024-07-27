import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_page_transition/flutter_page_transition.dart';
import 'package:wilcoerp/components/big_button_menus.dart';
import 'package:wilcoerp/constants/colors.dart';
import 'package:wilcoerp/helpers/helpers.dart';
import 'package:wilcoerp/pages/auto_incident_step2_page.dart';
import 'package:wilcoerp/pages/auto_incident_step3_page.dart';
import 'package:wilcoerp/pages/select_trailers_page.dart';
import 'package:wilcoerp/pages/select_trucks_cars_page.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wilcoerp/pages/witness_incident_injury_report_step3_page.dart';

import '../constants/globals.dart';

class WitnessIncidentInjuryReportStep2Page extends StatefulWidget {
  const WitnessIncidentInjuryReportStep2Page({super.key});

  @override
  State<WitnessIncidentInjuryReportStep2Page> createState() =>
      _WitnessIncidentInjuryReportStep2PageState();
}

class _WitnessIncidentInjuryReportStep2PageState
    extends State<WitnessIncidentInjuryReportStep2Page> {
  final cInjuredEmployeeName = TextEditingController();
  final cSupervisor = TextEditingController();
  final cDepartment = TextEditingController();
  final cDetailsOfIncident = TextEditingController();

  final formKey = new GlobalKey<FormState>();

  String ampm = "";
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
    final injuredEmployeeNameField = TextFormField(
      autofocus: false,
      textInputAction: TextInputAction.next,
      controller: cInjuredEmployeeName,
      keyboardType: TextInputType.name,
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

    final supervisorField = TextFormField(
      autofocus: false,
      textInputAction: TextInputAction.next,
      controller: cSupervisor,
      keyboardType: TextInputType.name,
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

    final departmentField = TextFormField(
      autofocus: false,
      textInputAction: TextInputAction.next,
      controller: cDepartment,
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

    final detailsOfIncidentField = TextFormField(
      autofocus: false,
      textInputAction: TextInputAction.newline,
      controller: cDetailsOfIncident,
      keyboardType: TextInputType.multiline,
      expands: true,
      maxLines: null,
      minLines: null,
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
                        "WITNESS INCIDENT INJURY REPORT",
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
                              "Injured employee's name",
                              style: TextStyle(color: Colors.grey.shade600),
                            ),
                          ),
                          injuredEmployeeNameField,
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Text(
                              "Supervisor",
                              style: TextStyle(color: Colors.grey.shade600),
                            ),
                          ),
                          supervisorField,
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Text(
                              "Department",
                              style: TextStyle(color: Colors.grey.shade600),
                            ),
                          ),
                          departmentField,
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "WITNESS INFORMATION",
                        style: TextStyle(
                            color: CustomColors.primary, fontSize: 25),
                        textAlign: TextAlign.center,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Text(
                              "Details of incident (please be specific)",
                              style: TextStyle(color: Colors.grey.shade600),
                            ),
                          ),
                          Container(
                              height: 100,
                              width: MediaQuery.of(context).size.width,
                              child: detailsOfIncidentField),
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

      report_witness_incident_injury.add({
        "question_text": "Injured employee's name",
        "content": cInjuredEmployeeName.text,
        "type": "text"
      });

      report_witness_incident_injury.add({
        "question_text": "Supervisor",
        "content": cSupervisor.text,
        "type": "text"
      });

      report_witness_incident_injury.add({
        "question_text": "Department",
        "content": cDepartment.text,
        "type": "text"
      });

      report_witness_incident_injury.add({
        "question_text": "Details of incident",
        "content": cDetailsOfIncident.text,
        "type": "text"
      });
      Navigator.push(
          context,
          PageTransition(
              child: WitnessIncidentInjuryReportStep3Page(),
              type: PageTransitionType.slideInUp,
              duration: Duration(milliseconds: 500)));
    }
  }
}
