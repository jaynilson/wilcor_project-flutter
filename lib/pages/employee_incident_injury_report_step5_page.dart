import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_page_transition/flutter_page_transition.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:provider/provider.dart';
import 'package:wilcoerp/components/override_date_picker.dart';
import 'package:wilcoerp/constants/colors.dart';
import 'package:wilcoerp/constants/globals.dart';
import 'package:wilcoerp/helpers/helpers.dart';
import 'package:wilcoerp/pages/done_page.dart';
import 'package:wilcoerp/pages/employee_incident_injury_report_step3_page.dart';
import 'package:wilcoerp/pages/home_page.dart';
import 'package:wilcoerp/providers/app.dart';
import 'package:wilcoerp/services/web_service.dart';

class EmployeeIncidentInjuryReportStep5Page extends StatefulWidget {
  const EmployeeIncidentInjuryReportStep5Page({super.key});

  @override
  State<EmployeeIncidentInjuryReportStep5Page> createState() =>
      _EmployeeIncidentInjuryReportStep5PageState();
}

class _EmployeeIncidentInjuryReportStep5PageState
    extends State<EmployeeIncidentInjuryReportStep5Page> {
  final cDateAndTimeIncident = TextEditingController();
  final cAddress = TextEditingController();
  final cNameMedicalCare = TextEditingController();
  final cDateIncidentReportedManager = TextEditingController();

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
    final dateAndTimeIncidentField = TextFormField(
      autofocus: false,
      textInputAction: TextInputAction.next,
      controller: cDateAndTimeIncident,
      keyboardType: TextInputType.text,
      readOnly: true,
      onTap: () {
        selectedDateTime((dateTime) {
          cDateAndTimeIncident.text =
              getDateTimeFromStringFormat(dateTime.toString());
        });
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

    final addressField = TextFormField(
      autofocus: false,
      textInputAction: TextInputAction.next,
      controller: cAddress,
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

    final nameMedicalCareField = TextFormField(
      autofocus: false,
      textInputAction: TextInputAction.newline,
      controller: cNameMedicalCare,
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
    final dateIncidentReportedManagerField = TextFormField(
      autofocus: false,
      textInputAction: TextInputAction.next,
      controller: cDateIncidentReportedManager,
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
                        "EMPLOYEE INCIDENT INJURY REPORT",
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
                              "Date and Time of incident",
                              style: TextStyle(color: Colors.grey.shade600),
                            ),
                          ),
                          dateAndTimeIncidentField,
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Text(
                              "Address where incident occurred",
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
                              "Name and address of where medical care was sought",
                              style: TextStyle(color: Colors.grey.shade600),
                            ),
                          ),
                          Container(
                              height: 100,
                              width: MediaQuery.of(context).size.width,
                              child: nameMedicalCareField),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Text(
                              "Date the incident was reported to a manager",
                              style: TextStyle(color: Colors.grey.shade600),
                            ),
                          ),
                          dateIncidentReportedManagerField,
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

  selectedDate() async {
    DateTime? newDateTime = await showRoundedDatePicker(
      context: context,
      initialDate: DateTime.now(),
      borderRadius: 16,
    );
    if (newDateTime != null) {
      cDateIncidentReportedManager.text =
          '${newDateTime.year}-${newDateTime.month}-${newDateTime.day}';
    } else {
      cDateIncidentReportedManager.text = "";
    }
  }

  selectedDateTime(Function callback) {
    OverrideDatePicker.showDatePicker(context,
        theme: DatePickerTheme(),
        showTitleActions: true,
        maxTime: DateTime.now(),
        minTime: DateTime(1940),
        onChanged: (date) {}, onConfirm: (date) {
      callback(date);
    },
        currentTime: DateTime.now().subtract(Duration(days: 7300)),
        locale: LocaleType.en);
  }

  next() async {
    final form = formKey.currentState;
    if (form!.validate()) {
      form.save();

      report_employee_incident.add({
        "question_text": "Date and Time of incident",
        "content": cDateAndTimeIncident.text,
        "type": "text"
      });

      report_employee_incident.add({
        "question_text": "Address where incident occurred",
        "content": cAddress.text,
        "type": "text"
      });

      report_employee_incident.add({
        "question_text": "Address where incident occurred",
        "content": cAddress.text,
        "type": "text"
      });

      report_employee_incident.add({
        "question_text": "Name and address of where medical care was sought",
        "content": cNameMedicalCare.text,
        "type": "text"
      });

      report_employee_incident.add({
        "question_text": "Date the incident was reported to a manager",
        "content": cDateIncidentReportedManager.text,
        "type": "text"
      });

      simpleLoading(context, (BuildContext loadingContext) {
        final provider = Provider.of<AppProvider>(context, listen: false);
        WebService(context)
            .accidentReport("employee incident", provider.user.id.toString(),
                provider.user.token ?? "")
            .then((data) async {
          for (var i = 0; i < report_employee_incident.length; i++) {
            dynamic item = report_employee_incident[i];

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
