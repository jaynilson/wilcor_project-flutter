import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_page_transition/flutter_page_transition.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wilcoerp/constants/colors.dart';
import 'package:wilcoerp/constants/globals.dart';
import 'package:wilcoerp/helpers/helpers.dart';

class OdometerReadingPage extends StatefulWidget {
  Function callbackNext;
  OdometerReadingPage(this.callbackNext, {super.key});

  @override
  State<OdometerReadingPage> createState() => _OdometerReadingPageState();
}

class _OdometerReadingPageState extends State<OdometerReadingPage> {
  final cMiles = TextEditingController();
  final formKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final milesField = TextFormField(
      autofocus: false,
      textInputAction: TextInputAction.next,
      controller: cMiles,
      keyboardType: TextInputType.number,
      readOnly: false,
      validator: (val) {
        return validateMiles(val ?? "", context);
      },
      obscureText: false,
      style: TextStyle(fontSize: 18.0),
      //initialValue: Environment.localUsername(),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 18.0, 20.0, 18.0),
        hintText: "",
        hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
        fillColor: Colors.grey.shade300,
        focusColor: Colors.grey,
        hoverColor: Colors.grey,
        filled: true,
        suffixIcon: InkWell(
          onTap: () {
            cMiles.text = "";
            FocusScope.of(context).unfocus();
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Text(
                  "Miles",
                  style: TextStyle(
                      color: Colors.grey, fontSize: 20, fontFamily: ""),
                ),
              ),
            ],
          ),
        ),
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
      ),
      onFieldSubmitted: (val) {
        checkout_odometer_reading = cMiles.text;
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
                      Image.asset(
                        'assets/images/odometro.png',
                        width: 180,
                        color: CustomColors.primary,
                      ),
                      Text(
                        "ODOMETER READING",
                        style: TextStyle(
                            color: CustomColors.primary, fontSize: 25),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      milesField,
                      SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            elevation: 2,
                            primary: CustomColors.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            )),
                        onPressed: () {
                          checkout_odometer_reading = cMiles.text;
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
      widget.callbackNext();
    }
  }
}
