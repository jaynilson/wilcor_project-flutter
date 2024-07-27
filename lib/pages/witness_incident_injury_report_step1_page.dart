import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_page_transition/flutter_page_transition.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:wilcoerp/components/big_button_menus.dart';
import 'package:wilcoerp/constants/colors.dart';
import 'package:wilcoerp/constants/globals.dart';
import 'package:wilcoerp/helpers/helpers.dart';
import 'package:wilcoerp/pages/auto_incident_step2_page.dart';
import 'package:wilcoerp/pages/auto_incident_step3_page.dart';
import 'package:wilcoerp/pages/select_trailers_page.dart';
import 'package:wilcoerp/pages/select_trucks_cars_page.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wilcoerp/pages/witness_incident_injury_report_step2_page.dart';

class WitnessIncidentInjuryReportStep1Page extends StatefulWidget {
  const WitnessIncidentInjuryReportStep1Page({super.key});

  @override
  State<WitnessIncidentInjuryReportStep1Page> createState() =>
      _WitnessIncidentInjuryReportStep1PageState();
}

class _WitnessIncidentInjuryReportStep1PageState
    extends State<WitnessIncidentInjuryReportStep1Page> {
  final cWitnessName = TextEditingController();
  final cPhoneNumber = TextEditingController();
  final cAddress = TextEditingController();
  final cCityStateZip = TextEditingController();
  final cDateOfBirth = TextEditingController();

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
    final witnessNameField = TextFormField(
      autofocus: false,
      textInputAction: TextInputAction.next,
      controller: cWitnessName,
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

    final phoneNumberField = TextFormField(
      autofocus: false,
      textInputAction: TextInputAction.next,
      controller: cPhoneNumber,
      keyboardType: TextInputType.phone,
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

    final addressField = TextFormField(
      autofocus: false,
      textInputAction: TextInputAction.next,
      controller: cAddress,
      keyboardType: TextInputType.streetAddress,
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

    final cityStateZipField = TextFormField(
      autofocus: false,
      textInputAction: TextInputAction.next,
      controller: cCityStateZip,
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

    final dateOfBirthField = TextFormField(
      autofocus: false,
      textInputAction: TextInputAction.next,
      controller: cDateOfBirth,
      keyboardType: TextInputType.text,
      onTap: () {
        selectedDate();
      },
      readOnly: true,
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
                              "Witness name",
                              style: TextStyle(color: Colors.grey.shade600),
                            ),
                          ),
                          witnessNameField,
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Text(
                              "Phone number",
                              style: TextStyle(color: Colors.grey.shade600),
                            ),
                          ),
                          phoneNumberField,
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Text(
                              "Address",
                              style: TextStyle(color: Colors.grey.shade600),
                            ),
                          ),
                          addressField,
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Text(
                              "City, State, Zip",
                              style: TextStyle(color: Colors.grey.shade600),
                            ),
                          ),
                          cityStateZipField,
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
                                    "Date of Birth",
                                    style:
                                        TextStyle(color: Colors.grey.shade600),
                                  ),
                                ),
                                dateOfBirthField,
                              ],
                            ),
                          ),
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
      cDateOfBirth.text =
          '${newDateTime.year}-${newDateTime.month}-${newDateTime.day}';
    } else {
      cDateOfBirth.text = "";
    }
  }

  next() async {
    final form = formKey.currentState;
    if (form!.validate()) {
      form.save();

      report_witness_incident_injury.add({
        "question_text": "Witness name",
        "content": cWitnessName.text,
        "type": "text"
      });
      report_witness_incident_injury.add({
        "question_text": "Phone number",
        "content": cPhoneNumber.text,
        "type": "text"
      });
      report_witness_incident_injury.add({
        "question_text": "Address",
        "content": cAddress.text,
        "type": "text"
      });
      report_witness_incident_injury.add({
        "question_text": "City, State, Zip",
        "content": cCityStateZip.text,
        "type": "text"
      });
      report_witness_incident_injury.add({
        "question_text": "Date of Birth",
        "content": cDateOfBirth.text,
        "type": "text"
      });
      Navigator.push(
          context,
          PageTransition(
              child: WitnessIncidentInjuryReportStep2Page(),
              type: PageTransitionType.slideInUp,
              duration: Duration(milliseconds: 500)));
    }
  }
}
