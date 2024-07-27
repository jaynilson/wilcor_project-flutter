import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_page_transition/flutter_page_transition.dart';
import 'package:wilcoerp/constants/colors.dart';
import 'package:wilcoerp/constants/globals.dart';
import 'package:wilcoerp/helpers/helpers.dart';
import 'package:wilcoerp/pages/employee_incident_injury_report_step2_page.dart';
import 'package:wilcoerp/pages/utility_damage_step6_page.dart';

class UtilityDamageStep5Page extends StatefulWidget {
  const UtilityDamageStep5Page({super.key});

  @override
  State<UtilityDamageStep5Page> createState() => _UtilityDamageStep5PageState();
}

class _UtilityDamageStep5PageState extends State<UtilityDamageStep5Page> {
  final cWereLocatesAccurate = TextEditingController();
  final cWereLocatesOutsideOfTolerance = TextEditingController();
  final cHowFarAreMarkingsFromFacility = TextEditingController();
  final cWasFacilityExposed = TextEditingController();
  final cWasDamageUnder = TextEditingController();
  final cFacilityMarksVisibleTime = TextEditingController();

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
    final wereLocatesAccurateField = TextFormField(
      autofocus: false,
      textInputAction: TextInputAction.next,
      controller: cWereLocatesAccurate,
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

    final wereLocatesOutsideOfToleranceField = TextFormField(
      autofocus: false,
      textInputAction: TextInputAction.next,
      controller: cWereLocatesOutsideOfTolerance,
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

    final howFarAreMarkingsFromFacilityField = TextFormField(
      autofocus: false,
      textInputAction: TextInputAction.next,
      controller: cHowFarAreMarkingsFromFacility,
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

    final wasFacilityExposedField = TextFormField(
      autofocus: false,
      textInputAction: TextInputAction.next,
      controller: cWasFacilityExposed,
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

    final wasDamageUnderField = TextFormField(
      autofocus: false,
      textInputAction: TextInputAction.next,
      controller: cWasDamageUnder,
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
                              "Were locates accurate?",
                              style: TextStyle(color: Colors.grey.shade600),
                            ),
                          ),
                          wereLocatesAccurateField,
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Text(
                              "Were locates outside of Tolerance zone?",
                              style: TextStyle(color: Colors.grey.shade600),
                            ),
                          ),
                          wereLocatesOutsideOfToleranceField,
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Text(
                              "How far are markings from facility?",
                              style: TextStyle(color: Colors.grey.shade600),
                            ),
                          ),
                          howFarAreMarkingsFromFacilityField,
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Text(
                              "Was facility exposed at time of damage?",
                              style: TextStyle(color: Colors.grey.shade600),
                            ),
                          ),
                          wasFacilityExposedField,
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Text(
                              "Was damage under pavement?",
                              style: TextStyle(color: Colors.grey.shade600),
                            ),
                          ),
                          wasDamageUnderField,
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

  next() async {
    final form = formKey.currentState;
    if (form!.validate()) {
      form.save();

      report_utility_damage.add({
        "question_text": "Were locates accurate?",
        "content": cWereLocatesAccurate.text,
        "type": "text"
      });

      report_utility_damage.add({
        "question_text": "Were locates outside of Tolerance zone?",
        "content": cWereLocatesOutsideOfTolerance.text,
        "type": "text"
      });

      report_utility_damage.add({
        "question_text": "How far are markings from facility?",
        "content": cHowFarAreMarkingsFromFacility.text,
        "type": "text"
      });

      report_utility_damage.add({
        "question_text": "Was facility exposed at time of damage?",
        "content": cWasFacilityExposed.text,
        "type": "text"
      });

      report_utility_damage.add({
        "question_text": "Was damage under pavement?",
        "content": cWasDamageUnder.text,
        "type": "text"
      });

      Navigator.push(
          context,
          PageTransition(
              child: UtilityDamageStep6Page(),
              type: PageTransitionType.slideInUp,
              duration: Duration(milliseconds: 500)));
    }
  }
}
