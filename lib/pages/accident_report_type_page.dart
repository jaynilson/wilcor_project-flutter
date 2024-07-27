import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_page_transition/flutter_page_transition.dart';
import 'package:wilcoerp/components/big_button_menus.dart';
import 'package:wilcoerp/constants/colors.dart';
import 'package:wilcoerp/helpers/helpers.dart';
import 'package:wilcoerp/pages/auto_incident_step1_page.dart';
import 'package:wilcoerp/pages/employee_incident_injury_report_step1_page.dart';
import 'package:wilcoerp/pages/utility_damage_step1_page.dart';

class AccidentReportTypePage extends StatefulWidget {
  const AccidentReportTypePage({super.key});

  @override
  State<AccidentReportTypePage> createState() => _AccidentReportTypePageState();
}

class _AccidentReportTypePageState extends State<AccidentReportTypePage> {
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
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 25.0),
                      child: Text(
                        "ACCIDENT REPORT",
                        style: TextStyle(
                          color: CustomColors.primary,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: BigButtonMenus(
                          "accidente.png", "EMPLOYEE INCIDENT", () {
                        Navigator.push(
                            context,
                            PageTransition(
                                child: EmployeeIncidentInjuryReportStep1Page(),
                                type: PageTransitionType.slideInUp,
                                duration: Duration(milliseconds: 500)));
                      }),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: BigButtonMenus("alerta.png", "UTILITY DAMAGE", () {
                        Navigator.push(
                            context,
                            PageTransition(
                                child: UtilityDamageStep1Page(),
                                type: PageTransitionType.slideInUp,
                                duration: Duration(milliseconds: 500)));
                      }),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: BigButtonMenus("bump.png", "AUTO INCIDENT", () {
                        Navigator.push(
                            context,
                            PageTransition(
                                child: AutoIncidentStep1Page(),
                                type: PageTransitionType.slideInUp,
                                duration: Duration(milliseconds: 500)));
                      }),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: BigButtonMenus("go-back-arrow.png", "BACK", () {
                        Navigator.pop(context);
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
