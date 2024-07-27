import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_page_transition/flutter_page_transition.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wilcoerp/components/big_button_menus.dart';
import 'package:wilcoerp/components/select_picture_dialog_wec.dart';
import 'package:wilcoerp/constants/colors.dart';
import 'package:wilcoerp/constants/globals.dart';
import 'package:wilcoerp/helpers/helpers.dart';
import 'package:wilcoerp/pages/auto_incident_step4_page.dart';
import 'package:wilcoerp/pages/select_trucks_cars_page.dart';
import 'package:wilcoerp/pages/utility_damage_step6_page.dart';

class AutoIncidentStep3Page extends StatefulWidget {
  const AutoIncidentStep3Page({super.key});

  @override
  State<AutoIncidentStep3Page> createState() => _AutoIncidentStep3PageState();
}

class _AutoIncidentStep3PageState extends State<AutoIncidentStep3Page> {
  final cAddressOfIncident = TextEditingController();
  final cVehicle2Model = TextEditingController();
  final cVehicle2License = TextEditingController();
  final cVehicle2Photo = TextEditingController();
  final cRoadConditions = TextEditingController();
  final cWeatherConditions = TextEditingController();

  final formKey = new GlobalKey<FormState>();

  String ampm = "";
  List<dynamic> pictureFiles = [];
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
    final addressOfIncidentField = TextFormField(
      autofocus: false,
      textInputAction: TextInputAction.next,
      controller: cAddressOfIncident,
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

    final vehicle2PhotoField = TextFormField(
      autofocus: false,
      textInputAction: TextInputAction.next,
      controller: cVehicle2Photo,
      keyboardType: TextInputType.text,
      readOnly: true,
      onTap: () {
        showTakePicture();
      },
      obscureText: false,
      style: TextStyle(fontSize: 18.0),
      //initialValue: Environment.localUsername(),
      decoration: decorationFields.copyWith(hintText: "Upload photo"),
      onFieldSubmitted: (val) {},
    );

    final vehicle2ModelField = TextFormField(
      autofocus: false,
      textInputAction: TextInputAction.next,
      controller: cVehicle2Model,
      keyboardType: TextInputType.text,
      readOnly: false,
      validator: (val) {
        return validateAny(val ?? "", context);
      },
      obscureText: false,
      style: TextStyle(fontSize: 18.0),
      //initialValue: Environment.localUsername(),
      decoration: decorationFields.copyWith(hintText: "Model"),
      onFieldSubmitted: (val) {},
    );

    final vehicle2LicenseField = TextFormField(
      autofocus: false,
      textInputAction: TextInputAction.next,
      controller: cVehicle2License,
      keyboardType: TextInputType.text,
      readOnly: false,
      validator: (val) {
        return validateAny(val ?? "", context);
      },
      obscureText: false,
      style: TextStyle(fontSize: 18.0),
      //initialValue: Environment.localUsername(),
      decoration: decorationFields.copyWith(hintText: "Driver license #"),

      onFieldSubmitted: (val) {},
    );

    final roadConditionsField = TextFormField(
      autofocus: false,
      textInputAction: TextInputAction.next,
      controller: cRoadConditions,
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

    final weatherConditionsField = TextFormField(
      autofocus: false,
      textInputAction: TextInputAction.next,
      controller: cWeatherConditions,
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
                        "AUTO INCIDENT",
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
                              "Address of incident",
                              style: TextStyle(color: Colors.grey.shade600),
                            ),
                          ),
                          addressOfIncidentField,
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Text(
                              "Vehicle 2",
                              style: TextStyle(color: Colors.grey.shade600),
                            ),
                          ),
                          vehicle2ModelField
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Text(
                              "Vehicle 2",
                              style: TextStyle(color: Colors.grey.shade600),
                            ),
                          ),
                          vehicle2LicenseField,
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Text(
                              "Vehicle 2",
                              style: TextStyle(color: Colors.grey.shade600),
                            ),
                          ),
                          vehicle2PhotoField,
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Text(
                              "Weather conditions",
                              style: TextStyle(color: Colors.grey.shade600),
                            ),
                          ),
                          weatherConditionsField,
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

  showTakePicture() async {
    await showDialog(
        context: context,
        builder: (contextDialog) {
          return SelectPictureDialogWec(
            "Select photos",
            (contextDialog, image) {
              Navigator.pop(contextDialog);
              if (image == "gallery") {
                callbackShowSelectPictures(contextDialog);
              } else {
                callbackShowTakePicture(contextDialog);
              }
            },
            useBtnCancel: true,
          );
        });
  }

  Future callbackShowSelectPictures(contextDialog) async {
    simpleLoading(context, (BuildContext loadingContext) async {
      try {
        final imageFile =
            await ImagePicker().pickImage(source: ImageSource.gallery);
        if (imageFile == null) {
          Navigator.pop(loadingContext);
          return;
        }
        final file = await File(imageFile.path);
        setState(() {
          pictureFiles.add(file);
          cVehicle2Photo.text = "Uploaded successfully";
        });

        Navigator.pop(loadingContext);
      } catch (e) {}
    });
  }

  Future callbackShowTakePicture(contextDialog) async {
    simpleLoading(context, (BuildContext loadingContext) async {
      try {
        final imageFile =
            await ImagePicker().pickImage(source: ImageSource.camera);
        if (imageFile == null) {
          Navigator.pop(loadingContext);
          return;
        }
        final file = await File(imageFile.path);
        setState(() {
          pictureFiles.add(file);
          cVehicle2Photo.text = "Uploaded successfully";
        });
        Navigator.pop(loadingContext);
      } catch (e) {}
    });
  }

  next() async {
    final form = formKey.currentState;
    if (form!.validate()) {
      form.save();

      report_auto_incident.add({
        "question_text": "Address of incident",
        "content": cAddressOfIncident.text,
        "type": "text"
      });

      report_auto_incident.add({
        "question_text": "Vehicle 2 model",
        "content": cVehicle2Model.text,
        "type": "text"
      });

      report_auto_incident.add({
        "question_text": "Vehicle 2 driver license #",
        "content": cVehicle2License.text,
        "type": "text"
      });

      report_auto_incident.add({
        "question_text": "Vehicle 2 photo",
        "content": pictureFiles,
        "type": "pictures"
      });
      report_auto_incident.add({
        "question_text": "Weather conditions",
        "content": cWeatherConditions.text,
        "type": "text"
      });

      Navigator.push(
          context,
          PageTransition(
              child: AutoIncidentStep4Page(),
              type: PageTransitionType.slideInUp,
              duration: Duration(milliseconds: 500)));
    }
  }
}
