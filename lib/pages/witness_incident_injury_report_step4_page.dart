import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_page_transition/flutter_page_transition.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:provider/provider.dart';
import 'package:wilcoerp/components/big_button_menus.dart';
import 'package:wilcoerp/components/override_date_picker.dart';
import 'package:wilcoerp/constants/colors.dart';
import 'package:wilcoerp/constants/globals.dart';
import 'package:wilcoerp/helpers/helpers.dart';
import 'package:wilcoerp/pages/auto_incident_step2_page.dart';
import 'package:wilcoerp/pages/auto_incident_step3_page.dart';
import 'package:wilcoerp/pages/done_page.dart';
import 'package:wilcoerp/pages/home_page.dart';
import 'package:wilcoerp/pages/select_trailers_page.dart';
import 'package:wilcoerp/pages/select_trucks_cars_page.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wilcoerp/pages/witness_incident_injury_report_step3_page.dart';
import 'package:wilcoerp/providers/app.dart';
import 'package:wilcoerp/services/web_service.dart';

class WitnessIncidentInjuryReportStep4Page extends StatefulWidget {
  const WitnessIncidentInjuryReportStep4Page({super.key});

  @override
  State<WitnessIncidentInjuryReportStep4Page> createState() =>
      _WitnessIncidentInjuryReportStep4PageState();
}

class _WitnessIncidentInjuryReportStep4PageState
    extends State<WitnessIncidentInjuryReportStep4Page> {
  final cDateTimeIncident = TextEditingController();
  final cAddressIncidentOcurred = TextEditingController();
  final cIncidentReportedManager = TextEditingController();

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
    final dateTimeIncidentField = TextFormField(
      autofocus: false,
      textInputAction: TextInputAction.next,
      controller: cDateTimeIncident,
      keyboardType: TextInputType.text,
      readOnly: true,
      onTap: () {
        selectedDateTime((dateTime) {
          cDateTimeIncident.text =
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

    final addressIncidentOcurredField = TextFormField(
      autofocus: false,
      textInputAction: TextInputAction.next,
      controller: cAddressIncidentOcurred,
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

    final incidentReportedManagerField = TextFormField(
      autofocus: false,
      textInputAction: TextInputAction.next,
      controller: cIncidentReportedManager,
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
                              "Date and Time of incident",
                              style: TextStyle(color: Colors.grey.shade600),
                            ),
                          ),
                          dateTimeIncidentField,
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Text(
                              "Address where incident ocurred",
                              style: TextStyle(color: Colors.grey.shade600),
                            ),
                          ),
                          addressIncidentOcurredField,
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
                          incidentReportedManagerField,
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

  selectedDateTime(Function callback) {
    OverrideDatePicker.showDateTimePicker(context,
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

  selectedDate() async {
    DateTime? newDateTime = await showRoundedDatePicker(
      context: context,
      initialDate: DateTime.now(),
      borderRadius: 16,
    );
    if (newDateTime != null) {
      cIncidentReportedManager.text =
          '${newDateTime.year}-${newDateTime.month}-${newDateTime.day}';
    } else {
      cIncidentReportedManager.text = "";
    }
  }

  next() async {
    final form = formKey.currentState;
    if (form!.validate()) {
      form.save();

      report_witness_incident_injury.add({
        "question_text": "Date and Time of incident",
        "content": cDateTimeIncident.text,
        "type": "text"
      });

      report_witness_incident_injury.add({
        "question_text": "Address where incident ocurred",
        "content": cAddressIncidentOcurred.text,
        "type": "text"
      });

      report_witness_incident_injury.add({
        "question_text": "Date the incident was reported to a manager",
        "content": cIncidentReportedManager.text,
        "type": "text"
      });

      simpleLoading(context, (BuildContext loadingContext) {
        final provider = Provider.of<AppProvider>(context, listen: false);
        WebService(context)
            .accidentReport("witness incident injury",
                provider.user.id.toString(), provider.user.token ?? "")
            .then((data) async {
          for (var i = 0; i < report_witness_incident_injury.length; i++) {
            dynamic item = report_witness_incident_injury[i];

            if (item["type"] == "pictures") {
              if (item["content"] is List) {
                dynamic resTmp = await WebService(context).accidentReportAnswer(
                    item["type"],
                    item["question_text"],
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
                    item["question_text"],
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

          dynamic linkedTmp = await WebService(context).accidentReportLinked(
              id_report_auto_incident,
              data["id"].toString(),
              provider.user.token ?? "");

          id_report_auto_incident = "";
          report_witness_incident_injury = [];
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
