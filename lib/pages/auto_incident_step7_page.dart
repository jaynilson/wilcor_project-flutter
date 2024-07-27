import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_page_transition/flutter_page_transition.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wilcoerp/components/fade_animation.dart';
import 'package:wilcoerp/constants/colors.dart';
import 'package:wilcoerp/constants/globals.dart';
import 'package:wilcoerp/helpers/helpers.dart';
import 'package:wilcoerp/pages/check_out_page.dart';
import 'package:wilcoerp/pages/home_page.dart';
import 'package:wilcoerp/pages/witness_incident_injury_report_step1_page.dart';

class AutoIncidentStep7Page extends StatefulWidget {
  AutoIncidentStep7Page({super.key});

  @override
  State<AutoIncidentStep7Page> createState() => _AutoIncidentStep7PageState();
}

class _AutoIncidentStep7PageState extends State<AutoIncidentStep7Page> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                child: FadeAnimation(
                  1,
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset('assets/images/correcto_red.png', width: 130),
                      Padding(
                        padding: const EdgeInsets.only(top: 25.0),
                        child: Text(
                          "DONE!",
                          style: TextStyle(
                              color: CustomColors.primary, fontSize: 25),
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              elevation: 2,
                              primary: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              )),
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                PageTransition(
                                    child: HomePage(),
                                    type: PageTransitionType.slideInUp,
                                    duration: Duration(milliseconds: 500)));
                          },
                          child: Container(
                            width: double.infinity,
                            height: 70.0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                                              "HOME",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 15.0,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Flexible(flex: 2, child: Icon(Icons.home))
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                elevation: 2,
                                primary: CustomColors.primary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                )),
                            onPressed: () {
                              // if (id_report_auto_incident != "")
                              Navigator.push(
                                  context,
                                  PageTransition(
                                      child:
                                          WitnessIncidentInjuryReportStep1Page(),
                                      type: PageTransitionType.slideInUp,
                                      duration: Duration(milliseconds: 500)));
                            },
                            child: Container(
                              width: double.infinity,
                              height: 70.0,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
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
                                                "WITNESS INCIDENT",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15.0,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                      flex: 2,
                                      child: Icon(FontAwesomeIcons.arrowRight))
                                ],
                              ),
                            )),
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
}
