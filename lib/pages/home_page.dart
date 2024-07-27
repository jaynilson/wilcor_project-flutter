import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_page_transition/flutter_page_transition.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:wilcoerp/components/big_button_menus.dart';

import 'package:wilcoerp/constants/colors.dart';
import 'package:wilcoerp/constants/globals.dart';
import 'package:wilcoerp/helpers/helpers.dart';
import 'package:wilcoerp/pages/accident_report_type_page.dart';
import 'package:wilcoerp/pages/check_in_page.dart';
import 'package:wilcoerp/pages/check_out_page.dart';
import 'package:wilcoerp/pages/location_step1_page.dart';
import 'package:wilcoerp/pages/location_step2_page.dart';
import 'package:wilcoerp/pages/report_problem.dart';
import 'package:wilcoerp/pages/request_page.dart';
import 'package:wilcoerp/pages/tools_page.dart';
import 'package:wilcoerp/providers/app.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    registerLocation(context);
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppProvider>(context, listen: true);
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
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 25.0),
                      child: Text(
                        "WELCOME " + " " + (provider.user.name!.toUpperCase()),
                        style: TextStyle(
                            color: CustomColors.primary,
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: BigButtonMenus("checked.png", "CHECK-OUT", () {
                        interfacesToRegister = [];
                        if (provider.checkout == null) {
                          Navigator.push(
                              context,
                              PageTransition(
                                  child: LocationStep1Page(
                                    CheckOutPage(),
                                  ),
                                  type: PageTransitionType.slideInUp,
                                  duration: Duration(milliseconds: 500)));
                        } else {
                          showErrorsDialog(context, [
                            "You must first check-in to be able to check-out again."
                          ]);
                        }
                      }),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: BigButtonMenus("check-in.png", "CHECK-IN", () {
                        interfacesToRegister = [];
                        if (provider.checkout == null) {
                          showErrorsDialog(context,
                              ["To check-in you must first check-out."]);
                        } else {
                          Navigator.push(
                              context,
                              PageTransition(
                                  child: LocationStep1Page(CheckInPage()),
                                  type: PageTransitionType.slideInUp,
                                  duration: Duration(milliseconds: 500)));
                        }
                      }),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: BigButtonMenus("gears.png", "SERVICE REQUEST", () {
                        Navigator.push(
                            context,
                            PageTransition(
                                child: LocationStep1Page(ReportProblemPage()),
                                type: PageTransitionType.slideInUp,
                                duration: Duration(milliseconds: 500)));
                      }),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: BigButtonMenus("bump.png", "ACCIDENT REPORT", () {
                        Navigator.push(
                            context,
                            PageTransition(
                                child: AccidentReportTypePage(),
                                type: PageTransitionType.slideInUp,
                                duration: Duration(milliseconds: 500)));
                      }),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: BigButtonMenus("support.png", "TOOLS", () {
                        Navigator.push(
                            context,
                            PageTransition(
                                child: ToolsPage(),
                                type: PageTransitionType.slideInUp,
                                duration: Duration(milliseconds: 500)));
                      }),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: BigButtonMenus("faq.png", "REQUEST", () {
                        Navigator.push(
                            context,
                            PageTransition(
                                child: RequestPage(),
                                type: PageTransitionType.slideInUp,
                                duration: Duration(milliseconds: 500)));
                      }),
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
}
