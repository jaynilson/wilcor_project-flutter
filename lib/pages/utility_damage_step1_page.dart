import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_page_transition/flutter_page_transition.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:wilcoerp/constants/colors.dart';
import 'package:wilcoerp/constants/globals.dart';
import 'package:wilcoerp/helpers/helpers.dart';
import 'package:wilcoerp/pages/employee_incident_injury_report_step2_page.dart';
import 'package:wilcoerp/pages/utility_damage_step2_page.dart';

class UtilityDamageStep1Page extends StatefulWidget {
  const UtilityDamageStep1Page({super.key});

  @override
  State<UtilityDamageStep1Page> createState() => _UtilityDamageStep1PageState();
}

class _UtilityDamageStep1PageState extends State<UtilityDamageStep1Page> {
  final cDamageDate = TextEditingController();
  final cForeman = TextEditingController();
  final cOwnerOfUtility = TextEditingController();
  final cTypeOfUtility = TextEditingController();

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
    final damageDateField = TextFormField(
      autofocus: false,
      textInputAction: TextInputAction.next,
      controller: cDamageDate,
      keyboardType: TextInputType.name,
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

    final foremanField = TextFormField(
      autofocus: false,
      textInputAction: TextInputAction.next,
      controller: cForeman,
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

    final ownerOfUtilityField = TextFormField(
      autofocus: false,
      textInputAction: TextInputAction.next,
      controller: cOwnerOfUtility,
      keyboardType: TextInputType.text,
      readOnly: false,

      obscureText: false,
      style: TextStyle(fontSize: 18.0),
      //initialValue: Environment.localUsername(),
      decoration: decorationFields,
      onFieldSubmitted: (val) {},
    );

    final typeOfUtilityField = TextFormField(
      autofocus: false,
      textInputAction: TextInputAction.next,
      controller: cTypeOfUtility,
      keyboardType: TextInputType.text,
      readOnly: false,

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
                              "Damage date",
                              style: TextStyle(color: Colors.grey.shade600),
                            ),
                          ),
                          damageDateField,
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Text(
                              "Foreman",
                              style: TextStyle(color: Colors.grey.shade600),
                            ),
                          ),
                          foremanField,
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Text(
                              "Owner of utility damaged",
                              style: TextStyle(color: Colors.grey.shade600),
                            ),
                          ),
                          Row(
                            children: [
                              Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        ownerUtilityDamaged = "Customer";
                                      });
                                    },
                                    child: Container(
                                      width: 150,
                                      child: ListTile(
                                        horizontalTitleGap: 1,
                                        contentPadding: EdgeInsets.all(0),
                                        title: Text(
                                          'Customer',
                                          style: TextStyle(color: Colors.grey),
                                        ),
                                        leading: Radio<String>(
                                          value: "Customer",
                                          groupValue: ownerUtilityDamaged,
                                          onChanged: (String? value) {
                                            setState(() {
                                              ownerUtilityDamaged = value ?? "";
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        ownerUtilityDamaged = "AT&T";
                                      });
                                    },
                                    child: Container(
                                      width: 150,
                                      child: ListTile(
                                        horizontalTitleGap: 1,
                                        contentPadding: EdgeInsets.all(0),
                                        title: Text(
                                          'AT&T',
                                          style: TextStyle(color: Colors.grey),
                                        ),
                                        leading: Radio<String>(
                                          value: "AT&T",
                                          groupValue: ownerUtilityDamaged,
                                          onChanged: (String? value) {
                                            setState(() {
                                              ownerUtilityDamaged = value ?? "";
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        ownerUtilityDamaged = "PBC water";
                                      });
                                    },
                                    child: Container(
                                      width: 150,
                                      child: ListTile(
                                        horizontalTitleGap: 1,
                                        contentPadding: EdgeInsets.all(0),
                                        title: Text(
                                          'PBC water',
                                          style: TextStyle(color: Colors.grey),
                                        ),
                                        leading: Radio<String>(
                                          value: "PBC water",
                                          groupValue: ownerUtilityDamaged,
                                          onChanged: (String? value) {
                                            setState(() {
                                              ownerUtilityDamaged = value ?? "";
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        ownerUtilityDamaged = "Other";
                                      });
                                    },
                                    child: Container(
                                      width: 150,
                                      child: ListTile(
                                        horizontalTitleGap: 1,
                                        contentPadding: EdgeInsets.all(0),
                                        title: Text(
                                          'Other',
                                          style: TextStyle(color: Colors.grey),
                                        ),
                                        leading: Radio<String>(
                                          value: "Other",
                                          groupValue: ownerUtilityDamaged,
                                          onChanged: (String? value) {
                                            setState(() {
                                              ownerUtilityDamaged = value ?? "";
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          ownerOfUtilityField,
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Text(
                              "Type of Utility",
                              style: TextStyle(color: Colors.grey.shade600),
                            ),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        typeOfUtility = "Water";
                                      });
                                    },
                                    child: Container(
                                      width: 150,
                                      child: ListTile(
                                        horizontalTitleGap: 1,
                                        contentPadding: EdgeInsets.all(0),
                                        title: Text(
                                          'Water',
                                          style: TextStyle(color: Colors.grey),
                                        ),
                                        leading: Radio<String>(
                                          value: "Water",
                                          groupValue: typeOfUtility,
                                          onChanged: (String? value) {
                                            setState(() {
                                              typeOfUtility = value ?? "";
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        typeOfUtility = "Other";
                                      });
                                    },
                                    child: Container(
                                      width: 150,
                                      child: ListTile(
                                        horizontalTitleGap: 1,
                                        contentPadding: EdgeInsets.all(0),
                                        title: Text(
                                          'Other',
                                          style: TextStyle(color: Colors.grey),
                                        ),
                                        leading: Radio<String>(
                                          value: "Other",
                                          groupValue: typeOfUtility,
                                          onChanged: (String? value) {
                                            setState(() {
                                              typeOfUtility = value ?? "";
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        typeOfUtility = "Fiber";
                                      });
                                    },
                                    child: Container(
                                      width: 150,
                                      child: ListTile(
                                        horizontalTitleGap: 1,
                                        contentPadding: EdgeInsets.all(0),
                                        title: Text(
                                          'Fiber',
                                          style: TextStyle(color: Colors.grey),
                                        ),
                                        leading: Radio<String>(
                                          value: "Fiber",
                                          groupValue: typeOfUtility,
                                          onChanged: (String? value) {
                                            setState(() {
                                              typeOfUtility = value ?? "";
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(),
                                ],
                              ),
                            ],
                          ),
                          typeOfUtilityField
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
      cDamageDate.text =
          '${newDateTime.year}-${newDateTime.month}-${newDateTime.day}';
    } else {
      cDamageDate.text = "";
    }
  }

  next() async {
    final form = formKey.currentState;
    if (form!.validate()) {
      form.save();

      if (ownerUtilityDamaged == "") {
        showErrorsDialog(context,
            ["You must select an answer for owner of utility damaged"]);
        return;
      } else if (typeOfUtility == "") {
        showErrorsDialog(
            context, ["You must select an answer for type of utility"]);
        return;
      } else if (ownerUtilityDamaged == "Other" &&
          cOwnerOfUtility.text.trim() == "") {
        showErrorsDialog(context,
            ["It is necessary to enter an answer for the other option"]);
        return;
      } else if (typeOfUtility == "Other" && cTypeOfUtility.text.trim() == "") {
        showErrorsDialog(context,
            ["It is necessary to enter an answer for the other option"]);
        return;
      }

      report_utility_damage.add({
        "question_text": "Damage date",
        "content": cDamageDate.text,
        "type": "text"
      });

      report_utility_damage.add({
        "question_text": "Foreman",
        "content": cForeman.text,
        "type": "text"
      });

      if (ownerUtilityDamaged == "Other") {
        report_utility_damage.add({
          "question_text": "Owner of utility damaged",
          "content": cOwnerOfUtility.text,
          "type": "radio"
        });
      } else {
        report_utility_damage.add({
          "question_text": "Owner of utility damaged",
          "content": ownerUtilityDamaged,
          "type": "radio"
        });
      }

      if (typeOfUtility == "Other") {
        report_utility_damage.add({
          "question_text": "Type of utility",
          "content": cTypeOfUtility.text,
          "type": "radio"
        });
      } else {
        report_utility_damage.add({
          "question_text": "Type of utility",
          "content": typeOfUtility,
          "type": "radio"
        });
      }

      Navigator.push(
          context,
          PageTransition(
              child: UtilityDamageStep2Page(),
              type: PageTransitionType.slideInUp,
              duration: Duration(milliseconds: 500)));
    }
  }
}
