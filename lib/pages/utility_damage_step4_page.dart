import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_page_transition/flutter_page_transition.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:wilcoerp/constants/colors.dart';
import 'package:wilcoerp/constants/globals.dart';
import 'package:wilcoerp/helpers/helpers.dart';
import 'package:wilcoerp/pages/employee_incident_injury_report_step2_page.dart';
import 'package:wilcoerp/pages/utility_damage_step5_page.dart';

class UtilityDamageStep4Page extends StatefulWidget {
  const UtilityDamageStep4Page({super.key});

  @override
  State<UtilityDamageStep4Page> createState() => _UtilityDamageStep4PageState();
}

class _UtilityDamageStep4PageState extends State<UtilityDamageStep4Page> {
  final cPhotoDate = TextEditingController();
  final cLocateRequest = TextEditingController();
  final cLocateExparationDate = TextEditingController();
  final cWasTicketWhiteLined = TextEditingController();
  final cHitKitUsed = TextEditingController();
  final cFacilityMarksVisibleTime = TextEditingController();

  final formKey = new GlobalKey<FormState>();

  String ownerUtilityDamaged = "";
  String typeOfUtility = "";
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
    final photoDateField = TextFormField(
      autofocus: false,
      textInputAction: TextInputAction.next,
      controller: cPhotoDate,
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

    final locateRequestField = TextFormField(
      autofocus: false,
      textInputAction: TextInputAction.next,
      controller: cLocateRequest,
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

    final locateExparationDateField = TextFormField(
      autofocus: false,
      textInputAction: TextInputAction.next,
      controller: cLocateExparationDate,
      keyboardType: TextInputType.text,
      readOnly: true,
      validator: (val) {
        return validateAny(val ?? "", context);
      },
      onTap: () {
        selectedDateLocateExparation();
      },
      obscureText: false,
      style: TextStyle(fontSize: 18.0),
      //initialValue: Environment.localUsername(),
      decoration: decorationFields,
      onFieldSubmitted: (val) {},
    );

    final wasTicketWhiteLinedField = TextFormField(
      autofocus: false,
      textInputAction: TextInputAction.next,
      controller: cWasTicketWhiteLined,
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

    final hitKitUsedField = TextFormField(
      autofocus: false,
      textInputAction: TextInputAction.next,
      controller: cHitKitUsed,
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

    final facilityMarksVisibleTimeField = TextFormField(
      autofocus: false,
      textInputAction: TextInputAction.next,
      controller: cFacilityMarksVisibleTime,
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
                        "UTILITY DAMAGE",
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
                              "Photo date",
                              style: TextStyle(color: Colors.grey.shade600),
                            ),
                          ),
                          photoDateField,
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Text(
                              "Locate request #",
                              style: TextStyle(color: Colors.grey.shade600),
                            ),
                          ),
                          locateRequestField,
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Text(
                              "Locate exparation date",
                              style: TextStyle(color: Colors.grey.shade600),
                            ),
                          ),
                          locateExparationDateField,
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Text(
                              "Was ticket white-lined?",
                              style: TextStyle(color: Colors.grey.shade600),
                            ),
                          ),
                          wasTicketWhiteLinedField,
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Text(
                              "Hit Kit used?",
                              style: TextStyle(color: Colors.grey.shade600),
                            ),
                          ),
                          hitKitUsedField,
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Text(
                              "Facility marks visible at time of damage?",
                              style: TextStyle(color: Colors.grey.shade600),
                            ),
                          ),
                          facilityMarksVisibleTimeField,
                        ],
                      ),
                      SizedBox(
                        height: 20,
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
      cPhotoDate.text =
          '${newDateTime.year}-${newDateTime.month}-${newDateTime.day}';
    } else {
      cPhotoDate.text = "";
    }
  }

  selectedDateLocateExparation() async {
    DateTime? newDateTime = await showRoundedDatePicker(
      context: context,
      initialDate: DateTime.now(),
      borderRadius: 16,
    );
    if (newDateTime != null) {
      cLocateExparationDate.text =
          '${newDateTime.year}-${newDateTime.month}-${newDateTime.day}';
    } else {
      cPhotoDate.text = "";
    }
  }

  next() async {
    final form = formKey.currentState;
    if (form!.validate()) {
      form.save();

      report_utility_damage.add({
        "question_text": "Photo date",
        "content": cPhotoDate.text,
        "type": "text"
      });

      report_utility_damage.add({
        "question_text": "Locate request #",
        "content": cLocateRequest.text,
        "type": "text"
      });

      report_utility_damage.add({
        "question_text": "Locate exparation date",
        "content": cLocateExparationDate.text,
        "type": "text"
      });

      report_utility_damage.add({
        "question_text": "Was ticket white-lined?",
        "content": cWasTicketWhiteLined.text,
        "type": "text"
      });

      report_utility_damage.add({
        "question_text": "Hit kit used?",
        "content": cHitKitUsed.text,
        "type": "text"
      });

      report_utility_damage.add({
        "question_text": "Facility marks visible at time of damage?",
        "content": cFacilityMarksVisibleTime.text,
        "type": "text"
      });

      Navigator.push(
          context,
          PageTransition(
              child: UtilityDamageStep5Page(),
              type: PageTransitionType.slideInUp,
              duration: Duration(milliseconds: 500)));
    }
  }
}
