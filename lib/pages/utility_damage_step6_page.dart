import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_page_transition/flutter_page_transition.dart';
import 'package:provider/provider.dart';
import 'package:wilcoerp/constants/colors.dart';
import 'package:wilcoerp/constants/globals.dart';
import 'package:wilcoerp/helpers/helpers.dart';
import 'package:wilcoerp/pages/done_page.dart';
import 'package:wilcoerp/pages/employee_incident_injury_report_step2_page.dart';
import 'package:wilcoerp/pages/home_page.dart';
import 'package:wilcoerp/pages/utility_damage_step3_page.dart';
import 'package:wilcoerp/providers/app.dart';
import 'package:wilcoerp/services/web_service.dart';

class UtilityDamageStep6Page extends StatefulWidget {
  const UtilityDamageStep6Page({super.key});

  @override
  State<UtilityDamageStep6Page> createState() => _UtilityDamageStep6PageState();
}

class _UtilityDamageStep6PageState extends State<UtilityDamageStep6Page> {
  final cRootCauses = TextEditingController();
  final cIsWilco = TextEditingController();
  final cNotes = TextEditingController();

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
    final rootCausesField = TextFormField(
      autofocus: false,
      textInputAction: TextInputAction.next,
      controller: cRootCauses,
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

    final isWilcoField = TextFormField(
      autofocus: false,
      textInputAction: TextInputAction.next,
      controller: cIsWilco,
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

    final notesField = TextFormField(
      autofocus: false,
      textInputAction: TextInputAction.newline,
      controller: cNotes,
      keyboardType: TextInputType.multiline,
      expands: true,
      maxLines: null,
      readOnly: false,
      validator: (val) {
        return validateAny(val ?? "", context);
      },
      obscureText: false,
      style: TextStyle(fontSize: 18.0),
      //initialValue: Environment.localUsername(),
      decoration: decorationFields,
      onFieldSubmitted: (val) {
        next();
      },
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
                              "Root causes",
                              style: TextStyle(color: Colors.grey.shade600),
                            ),
                          ),
                          rootCausesField,
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Text(
                              "Is Wilco liable?",
                              style: TextStyle(color: Colors.grey.shade600),
                            ),
                          ),
                          isWilcoField,
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Text(
                              "Notes",
                              style: TextStyle(color: Colors.grey.shade600),
                            ),
                          ),
                          Container(
                              height: 100,
                              width: MediaQuery.of(context).size.width,
                              child: notesField),
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
                                            "SEND REPORT",
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
        "question_text": "Root causes",
        "content": cRootCauses.text,
        "type": "text"
      });

      report_utility_damage.add({
        "question_text": "Is Wilco liable?",
        "content": cIsWilco.text,
        "type": "text"
      });

      report_utility_damage.add(
          {"question_text": "Notes", "content": cNotes.text, "type": "text"});

      simpleLoading(context, (BuildContext loadingContext) {
        final provider = Provider.of<AppProvider>(context, listen: false);
        WebService(context)
            .accidentReport("utility damage", provider.user.id.toString(),
                provider.user.token ?? "")
            .then((data) async {
          for (var i = 0; i < report_utility_damage.length; i++) {
            dynamic item = report_utility_damage[i];

            if (item["type"] == "pictures") {
              if (item["content"] is List) {
                dynamic resTmp = await WebService(context).accidentReportAnswer(
                    item["type"],
                    "pictures",
                    i.toString(),
                    "pictures",
                    data["id"].toString(),
                    provider.user.token ?? "");

                for (var i = 0;
                    i < (item["content"] as List<dynamic>).length;
                    i++) {
                  await WebService(context).uploadAsset(
                      "accident_report",
                      resTmp["id"].toString(),
                      (item["content"] as List<dynamic>)[i],
                      provider.user.token.toString());
                }
              } else {
                dynamic resTmp = await WebService(context).accidentReportAnswer(
                    item["type"],
                    "pictures",
                    i.toString(),
                    "pictures",
                    data["id"].toString(),
                    provider.user.token ?? "");
              }
            } else {
              dynamic resTmp = await WebService(context).accidentReportAnswer(
                  item["type"],
                  item["question_text"],
                  i.toString(),
                  item["content"],
                  data["id"].toString(),
                  provider.user.token ?? "");
            }
          }

          report_utility_damage = [];
          Navigator.pop(loadingContext);

          Navigator.push(
              context,
              PageTransition(
                  child: DonePage(
                    HomePage(),
                    pushAndRemoveUntil: true,
                  ),
                  type: PageTransitionType.slideInUp,
                  duration: Duration(milliseconds: 500)));
        }).catchError((e) {
          print("Error");
          print(e);
          Navigator.pop(loadingContext);
          showErrorsDialog(context, e);
        });
      });
    }
  }
}
