import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_page_transition/flutter_page_transition.dart';
import 'package:provider/provider.dart';
import 'package:wilcoerp/components/big_button_menus.dart';
import 'package:wilcoerp/constants/colors.dart';
import 'package:wilcoerp/helpers/helpers.dart';
import 'package:wilcoerp/pages/checks_trailer_page.dart';
import 'package:wilcoerp/pages/home_page.dart';
import 'package:wilcoerp/pages/select_trucks_cars_page.dart';
import 'package:wilcoerp/pages/thanks_page.dart';
import 'package:wilcoerp/providers/app.dart';

import '../constants/globals.dart';
import 'checks_truck_page.dart';

class ConfirmReportProblem extends StatefulWidget {
  const ConfirmReportProblem({super.key});

  @override
  State<ConfirmReportProblem> createState() => _ConfirmReportProblemState();
}

class _ConfirmReportProblemState extends State<ConfirmReportProblem> {
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/services.png',
                      width: 150,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 35.0),
                      child: Text(
                        "REPORT PROBLEM",
                        style: TextStyle(
                            color: CustomColors.primary,
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            elevation: 2,
                            primary: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            )),
                        onPressed: () {
                          final provider =
                              Provider.of<AppProvider>(context, listen: false);

                          if (provider.checkout!.fleet!.type == "trucks_cars") {
                            Navigator.push(
                                context,
                                PageTransition(
                                    child:
                                        ChecksTruckPage(checksTrucks, 0, true),
                                    type: PageTransitionType.slideInUp,
                                    duration: Duration(milliseconds: 500)));
                          } else {
                            Navigator.push(
                                context,
                                PageTransition(
                                    child: ChecksTrailerPage(
                                        checksTrailers, 0, true),
                                    type: PageTransitionType.slideInUp,
                                    duration: Duration(milliseconds: 500)));
                          }
                        },
                        child: Container(
                          width: double.infinity,
                          height: 50.0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "YES",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18.0,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            elevation: 2,
                            primary: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            )),
                        onPressed: () {
                          checkIn();
                        },
                        child: Container(
                          width: double.infinity,
                          height: 50.0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "NO",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18.0,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
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
    );
  }

  checkIn() {
    final provider = Provider.of<AppProvider>(context, listen: false);
    registerCheckIn(() {
      Navigator.push(
          context,
          PageTransition(
              child: ThanksPage(HomePage(), pushAndRemoveUntil: true),
              type: PageTransitionType.slideInUp,
              duration: Duration(milliseconds: 500)));
    }, provider.checkout!.id.toString(), context);
  }
}
