import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_page_transition/flutter_page_transition.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:provider/provider.dart';
import 'package:wilcoerp/constants/colors.dart';
import 'package:wilcoerp/helpers/helpers.dart';
import 'package:wilcoerp/models/checkout.dart';
import 'package:wilcoerp/pages/done_page.dart';
import 'package:wilcoerp/pages/home_page.dart';
import 'package:wilcoerp/providers/app.dart';
import 'package:wilcoerp/services/web_service.dart';

class LostStolenPage extends StatefulWidget {
  CheckOut checkout;

  LostStolenPage(this.checkout, {super.key});

  @override
  State<LostStolenPage> createState() => _LostStolenPageState();
}

class _LostStolenPageState extends State<LostStolenPage> {
  final cDetails = TextEditingController();
  final cLastSeen = TextEditingController();
  final cDateIncident = TextEditingController();
  final cTime = TextEditingController();

  final formKey = new GlobalKey<FormState>();
  String ampm = "";
  String lostStolen = "";
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

    final timeField = TextFormField(
      autofocus: false,
      textInputAction: TextInputAction.next,
      controller: cTime,
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

    final detailsField = TextFormField(
      autofocus: false,
      textInputAction: TextInputAction.next,
      controller: cDetails,
      maxLines: null,
      minLines: null,
      expands: true,
      keyboardType: TextInputType.multiline,
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

    final lastSeenField = TextFormField(
      autofocus: false,
      textInputAction: TextInputAction.next,
      controller: cLastSeen,
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

    final dateIncidentField = TextFormField(
      autofocus: false,
      textInputAction: TextInputAction.next,
      controller: cDateIncident,
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
                        "LOST STOLEN",
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
                              "Details of incident (please be specific)",
                              style: TextStyle(color: Colors.grey.shade600),
                            ),
                          ),
                        ],
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
                                      lostStolen = "LOST";
                                    });
                                  },
                                  child: Container(
                                    width: 150,
                                    height: 40,
                                    child: ListTile(
                                      horizontalTitleGap: 1,
                                      contentPadding: EdgeInsets.all(0),
                                      title: Text(
                                        'LOST',
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                      leading: Radio<String>(
                                        value: "LOST",
                                        groupValue: lostStolen,
                                        onChanged: (String? value) {
                                          setState(() {
                                            lostStolen = value ?? "";
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
                                      lostStolen = "STOLEN";
                                    });
                                  },
                                  child: Container(
                                    width: 150,
                                    height: 40,
                                    child: ListTile(
                                      horizontalTitleGap: 1,
                                      contentPadding: EdgeInsets.all(0),
                                      title: Text(
                                        'STOLEN',
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                      leading: Radio<String>(
                                        value: "STOLEN",
                                        groupValue: lostStolen,
                                        onChanged: (String? value) {
                                          setState(() {
                                            lostStolen = value ?? "";
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
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                height: 100,
                                width: MediaQuery.of(context).size.width,
                                child: detailsField),
                          ]),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Text(
                              "Last Seen",
                              style: TextStyle(color: Colors.grey.shade600),
                            ),
                          ),
                          lastSeenField,
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Text(
                              "Date of incident",
                              style: TextStyle(color: Colors.grey.shade600),
                            ),
                          ),
                          dateIncidentField,
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
                                    "Time",
                                    style:
                                        TextStyle(color: Colors.grey.shade600),
                                  ),
                                ),
                                timeField,
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
                                      ampm = "AM";
                                    });
                                  },
                                  child: Container(
                                    width: 150,
                                    height: 40,
                                    child: ListTile(
                                      horizontalTitleGap: 1,
                                      contentPadding: EdgeInsets.all(0),
                                      title: Text(
                                        'AM',
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                      leading: Radio<String>(
                                        value: "AM",
                                        groupValue: ampm,
                                        onChanged: (String? value) {
                                          setState(() {
                                            ampm = value ?? "";
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      ampm = "PM";
                                    });
                                  },
                                  child: Container(
                                    width: 150,
                                    height: 40,
                                    child: ListTile(
                                      horizontalTitleGap: 1,
                                      contentPadding: EdgeInsets.all(0),
                                      title: Text(
                                        'PM',
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                      leading: Radio<String>(
                                        value: "PM",
                                        groupValue: ampm,
                                        onChanged: (String? value) {
                                          setState(() {
                                            ampm = value ?? "";
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

  selectedDate() async {
    DateTime? newDateTime = await showRoundedDatePicker(
      context: context,
      initialDate: DateTime.now(),
      borderRadius: 16,
    );
    if (newDateTime != null) {
      cDateIncident.text =
          '${newDateTime.year}-${newDateTime.month}-${newDateTime.day}';
    } else {
      cDateIncident.text = "";
    }
  }

  next() async {
    final form = formKey.currentState;
    if (form!.validate()) {
      form.save();

      simpleLoading(context, (BuildContext loadingContext) {
        final provider = Provider.of<AppProvider>(context, listen: false);

        WebService(context)
            .lost(
                (lostStolen == "LOST") ? "true" : "",
                (lostStolen == "STOLEN") ? "true" : "",
                cDetails.text,
                cLastSeen.text,
                ampm,
                cTime.text,
                cDateIncident.text,
                provider.user.id.toString(),
                widget.checkout.tool!.id.toString(),
                widget.checkout.id.toString(),
                provider.user.token ?? "")
            .then((data) async {
          WebService(context)
              .checkInTool(
                  provider.user.id.toString(),
                  widget.checkout.tool!.id.toString(),
                  widget.checkout.id.toString(),
                  provider.user.token ?? "")
              .then((data) async {
            List<CheckOut> checkouts = await WebService(context)
                .getCheckoutTool(provider.user.token ?? "", provider.user.id!);
            provider.setCheckoutsTools(checkouts);
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
