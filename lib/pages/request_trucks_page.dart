import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_page_transition/flutter_page_transition.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:provider/provider.dart';
import 'package:wilcoerp/constants/colors.dart';
import 'package:wilcoerp/constants/globals.dart';
import 'package:wilcoerp/helpers/helpers.dart';
import 'package:wilcoerp/models/fleet.dart';
import 'package:wilcoerp/pages/confirm_report_problem.dart';
import 'package:wilcoerp/pages/done_page.dart';
import 'package:wilcoerp/pages/home_page.dart';
import 'package:wilcoerp/pages/odometer_reading_page.dart';
import 'package:wilcoerp/providers/app.dart';
import 'package:wilcoerp/services/web_service.dart';

class RequestTrucksPage extends StatefulWidget {
  const RequestTrucksPage({super.key});

  @override
  State<RequestTrucksPage> createState() => _RequestTrucksPageState();
}

class _RequestTrucksPageState extends State<RequestTrucksPage> {
  final cDateNeeded = TextEditingController();
  final cCant = TextEditingController();
  final formKey = new GlobalKey<FormState>();
  int cant = 0;

  @override
  void initState() {
    super.initState();
    cant = 1;
    cCant.text = cant.toString();
  }

  @override
  Widget build(BuildContext context) {
    FleetModel fleet = checkout_fleet;
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
    final dateNeededField = TextFormField(
      autofocus: false,
      textInputAction: TextInputAction.next,
      controller: cDateNeeded,
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

    final cantField = TextFormField(
      autofocus: false,
      textAlign: TextAlign.center,
      textInputAction: TextInputAction.next,
      controller: cCant,
      keyboardType: TextInputType.number,
      readOnly: true,
      validator: (val) {
        return validateAny(val ?? "", context);
      },
      obscureText: false,
      style: TextStyle(fontSize: 18.0),
      //initialValue: Environment.localUsername(),
      decoration: decorationFields.copyWith(
        prefixIcon: InkWell(
            onTap: () {
              if (cant > 0) {
                cant--;
              }
              setState(() {
                cCant.text = cant.toString();
              });
            },
            child: Icon(
              Icons.remove,
              color: Colors.grey,
            )),
        suffixIcon: InkWell(
            onTap: () {
              cant++;
              setState(() {
                cCant.text = cant.toString();
              });
            },
            child: Icon(
              Icons.add,
              color: Colors.grey,
            )),
      ),
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
              padding: EdgeInsets.all(MediaQuery.of(context).size.width * .05),
              child: Center(
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 25.0),
                        child: Text(
                          "REQUEST",
                          style: TextStyle(
                              color: CustomColors.primary,
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Card(
                        color: Colors.grey.shade200,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              FadeInImage.assetNetwork(
                                placeholder: "assets/images/loading-image1.gif",
                                imageErrorBuilder:
                                    (context, error, stackTrace) {
                                  return Container();
                                },
                                image:
                                    imagesUrlFleet + fleet.picture.toString(),
                                width: MediaQuery.of(context).size.width * .80,
                                fit: BoxFit.fitWidth,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0, vertical: 2),
                                child: Container(
                                  child: Row(
                                    children: [
                                      Text(
                                        "N:",
                                        style: TextStyle(
                                            fontFamily: "",
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12),
                                      ),
                                      Flexible(
                                        child: Text(
                                          fleet.n ?? "",
                                          style: TextStyle(
                                              fontFamily: "",
                                              fontSize: 12,
                                              fontWeight: FontWeight.normal),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0, vertical: 2),
                                child: Container(
                                  child: Row(
                                    children: [
                                      Text(
                                        "Model:",
                                        style: TextStyle(
                                            fontFamily: "",
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12),
                                      ),
                                      Flexible(
                                        child: Text(
                                          fleet.model ?? "",
                                          style: TextStyle(
                                              fontFamily: "",
                                              fontSize: 12,
                                              fontWeight: FontWeight.normal),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0, vertical: 2),
                                child: Container(
                                  child: Row(
                                    children: [
                                      Text(
                                        "License Plate:",
                                        style: TextStyle(
                                            fontFamily: "",
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12),
                                      ),
                                      Flexible(
                                        child: Text(
                                          fleet.licence_plate ?? "",
                                          style: TextStyle(
                                              fontFamily: "",
                                              fontSize: 12,
                                              fontWeight: FontWeight.normal),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0, vertical: 2),
                                child: Container(
                                  child: Row(
                                    children: [
                                      Text(
                                        "Year:",
                                        style: TextStyle(
                                            fontFamily: "",
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12),
                                      ),
                                      Flexible(
                                        child: Text(
                                          fleet.year ?? "",
                                          style: TextStyle(
                                              fontFamily: "",
                                              fontSize: 12,
                                              fontWeight: FontWeight.normal),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0, vertical: 2),
                                child: Container(
                                  child: Row(
                                    children: [
                                      Text(
                                        "Yard Location:",
                                        style: TextStyle(
                                            fontFamily: "",
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12),
                                      ),
                                      Flexible(
                                        child: Text(
                                          fleet.yard_location ?? "",
                                          style: TextStyle(
                                              fontFamily: "",
                                              fontSize: 12,
                                              fontWeight: FontWeight.normal),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0, vertical: 2),
                                child: Container(
                                  child: Row(
                                    children: [
                                      Text(
                                        "Department:",
                                        style: TextStyle(
                                            fontFamily: "",
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12),
                                      ),
                                      Flexible(
                                        child: Text(
                                          fleet.department ?? "",
                                          style: TextStyle(
                                              fontFamily: "",
                                              fontSize: 12,
                                              fontWeight: FontWeight.normal),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Text(
                              "Date Needed",
                              style: TextStyle(color: Colors.grey.shade600),
                            ),
                          ),
                          dateNeededField,
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Flexible(flex: 5, child: cantField),
                            Container(
                              width: 8,
                            ),
                            Flexible(
                              flex: 5,
                              child: ElevatedButton(
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
                                  height: 50.0,
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
                              ),
                            )
                          ],
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
      cDateNeeded.text =
          '${newDateTime.year}-${newDateTime.month}-${newDateTime.day}';
    } else {
      cDateNeeded.text = "";
    }
  }

  next() async {
    final form = formKey.currentState;
    if (form!.validate()) {
      form.save();

      simpleLoading(context, (BuildContext loadingContext) {
        final provider = Provider.of<AppProvider>(context, listen: false);
        WebService(context)
            .requestFleet(
                provider.user.id.toString(),
                (checkout_fleet as FleetModel).id.toString(),
                cDateNeeded.text,
                int.parse(cCant.text),
                provider.user.token ?? "")
            .then((data) async {
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
