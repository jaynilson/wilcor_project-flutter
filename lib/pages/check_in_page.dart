import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_page_transition/flutter_page_transition.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:wilcoerp/constants/colors.dart';
import 'package:wilcoerp/constants/globals.dart';
import 'package:wilcoerp/helpers/helpers.dart';
import 'package:wilcoerp/models/fleet.dart';
import 'package:wilcoerp/pages/confirm_report_problem.dart';
import 'package:wilcoerp/pages/home_page.dart';
import 'package:wilcoerp/pages/odometer_reading_page.dart';
import 'package:wilcoerp/providers/app.dart';

class CheckInPage extends StatefulWidget {
  CheckInPage({super.key});

  @override
  State<CheckInPage> createState() => _CheckInPageState();
}

class _CheckInPageState extends State<CheckInPage> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppProvider>(context, listen: true);
    FleetModel? fleet = provider.checkout!.fleet;

    if (fleet == null) {
      print("es nullo");
    } else {
      print("No es nulo");
    }

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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 25.0),
                      child: Text(
                        "CHECK-IN",
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
                              imageErrorBuilder: (context, error, stackTrace) {
                                return Container();
                              },
                              image: imagesUrlFleet + fleet!.picture!,
                              width: MediaQuery.of(context).size.width,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 3.0),
                              child: Row(
                                children: [
                                  Text(
                                    "N: ",
                                    style: TextStyle(),
                                  ),
                                  Text(fleet.n ?? "")
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 3.0),
                              child: Row(
                                children: [
                                  Text(
                                    "MODEL: ",
                                    style: TextStyle(),
                                  ),
                                  Text((fleet.model ?? "").toUpperCase())
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 3.0),
                              child: Row(
                                children: [
                                  Text(
                                    "LICENCE PLATE: ",
                                    style: TextStyle(),
                                  ),
                                  Text(
                                      (fleet.licence_plate ?? "").toUpperCase())
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 3.0),
                              child: Row(
                                children: [
                                  Text(
                                    "YEAR: ",
                                    style: TextStyle(),
                                  ),
                                  Text((fleet.year ?? "").toUpperCase())
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 3.0),
                              child: Row(
                                children: [
                                  Text(
                                    " IN USE:",
                                    style: TextStyle(),
                                  ),
                                  Text(getTimeUse(
                                      provider.checkout!.created_at!))
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pushReplacement(
                                context,
                                PageTransition(
                                    child: HomePage(),
                                    type: PageTransitionType.slideInUp,
                                    duration: Duration(milliseconds: 500)));
                          },
                          child: Column(
                            children: [
                              Image.asset(
                                'assets/images/borrar.png',
                                width: 55,
                                color: CustomColors.primary,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 60,
                          width: 4,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: CustomColors.primary,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                PageTransition(
                                    child:
                                        OdometerReadingPage(goToReportProblem),
                                    type: PageTransitionType.slideInUp,
                                    duration: Duration(milliseconds: 500)));
                          },
                          child: Column(
                            children: [
                              Image.asset(
                                'assets/images/correcto.png',
                                width: 55,
                                color: CustomColors.primary,
                              ),
                            ],
                          ),
                        )
                      ],
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

  getTimeUse(DateTime startDate) {
    var endDate = DateTime.now();
    print(startDate);
    print(endDate);
    Duration duration = endDate.difference(startDate);

    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  goToReportProblem() {
    Navigator.push(
        context,
        PageTransition(
            child: ConfirmReportProblem(),
            type: PageTransitionType.slideInUp,
            duration: Duration(milliseconds: 500)));
  }
}
