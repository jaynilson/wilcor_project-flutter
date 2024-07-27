import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_page_transition/flutter_page_transition.dart';
import 'package:provider/provider.dart';
import 'package:wilcoerp/constants/colors.dart';
import 'package:wilcoerp/constants/globals.dart';
import 'package:wilcoerp/helpers/helpers.dart';
import 'package:wilcoerp/models/fleet.dart';
import 'package:wilcoerp/models/interface.dart';
import 'package:wilcoerp/pages/alert_fleet_page.dart';
import 'package:wilcoerp/pages/done_page.dart';
import 'package:wilcoerp/pages/home_page.dart';
import 'package:wilcoerp/pages/odometer_reading_page.dart';
import 'package:wilcoerp/pages/select_trucks_cars_page.dart';
import 'package:wilcoerp/providers/app.dart';
import 'package:wilcoerp/services/web_service.dart';

class ChecksTruckPage extends StatefulWidget {
  List<InterfaceModel> checks;
  int currentStep;
  bool fromCheckIn;
  ChecksTruckPage(this.checks, this.currentStep, this.fromCheckIn, {super.key});

  @override
  State<ChecksTruckPage> createState() => _ChecksTruckPageState();
}

class _ChecksTruckPageState extends State<ChecksTruckPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (getCheckByStep(widget.currentStep) == null) {
      return Container(
        child: Center(
          child: Text("No checks"),
        ),
      );
    }
    InterfaceModel check = getCheckByStep(widget.currentStep);
    if (check.widget == "check") {
      return Scaffold(
        extendBody: true,
        appBar: getAppBar(context),
        body: Center(
          child: ListView(
            shrinkWrap: true,
            children: [
              Padding(
                padding:
                    EdgeInsets.all(MediaQuery.of(context).size.width * .08),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      FadeInImage.assetNetwork(
                          placeholder: "assets/images/loading-image1.gif",
                          imageErrorBuilder: (context, error, stackTrace) {
                            return Container();
                          },
                          image: imagesUrlInterfaces + (check.picture ?? ""),
                          width: 180),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        check.title ?? "",
                        style: TextStyle(
                            color: CustomColors.primary, fontSize: 25),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          InkWell(
                            onTap: () {
                              if (check.critical == true) {
                                Navigator.push(
                                    context,
                                    PageTransition(
                                        child: AlertFleetPage(() {
                                          if (!widget.fromCheckIn) {
                                            Navigator.push(
                                                context,
                                                PageTransition(
                                                    child: SelectTrucksCarsPage(
                                                        ChecksTruckPage(
                                                            checksTrucks,
                                                            0,
                                                            widget
                                                                .fromCheckIn)),
                                                    type: PageTransitionType
                                                        .slideInUp,
                                                    duration: Duration(
                                                        milliseconds: 500)));
                                          } else {
                                            next(
                                                status: "false",
                                                is_critical: "true");
                                          }
                                        }, () {
                                          next(
                                              status: "false",
                                              is_critical: "true");
                                        }, widget.fromCheckIn),
                                        type: PageTransitionType.slideInUp,
                                        duration: Duration(milliseconds: 500)));
                              } else {
                                next(status: "false", is_critical: "false");
                              }
                            },
                            child: Column(
                              children: [
                                Image.asset(
                                  'assets/images/borrar.png',
                                  width: 55,
                                  color: CustomColors.primary,
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  "PROBLEM FOUND",
                                  style: TextStyle(
                                      color: CustomColors.primary,
                                      fontSize: 10),
                                  textAlign: TextAlign.center,
                                )
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
                              next(status: "true", is_critical: "false");
                            },
                            child: Column(
                              children: [
                                Image.asset(
                                  'assets/images/correcto.png',
                                  width: 55,
                                  color: CustomColors.primary,
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  "NO PROBLEM \n DOESN'T APPLY",
                                  style: TextStyle(
                                    color: CustomColors.primary,
                                    fontSize: 10,
                                  ),
                                  textAlign: TextAlign.center,
                                )
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
    } else if (check.widget == "OdometerReadingPage") {
      return OdometerReadingPage(next);
    } else {
      return Container();
    }
  }

  dynamic getCheckByStep(int step) {
    dynamic check = null;

    widget.checks.forEach((elem) {
      if (elem.order == step) {
        check = elem;
      }
    });
    return check;
  }

  next({String status = "", String is_critical = ""}) {
    if (status != "" && is_critical != "")
      setCheck(
          getCheckByStep(widget.currentStep).id.toString(),
          status,
          is_critical,
          (widget.fromCheckIn) ? "check_in_fleet" : "check_out_fleet");

    if (getCheckByStep(widget.currentStep + 1) != null) {
      Navigator.push(
          context,
          PageTransition(
              child: ChecksTruckPage(
                  widget.checks, widget.currentStep + 1, widget.fromCheckIn),
              type: PageTransitionType.slideInUp,
              duration: Duration(milliseconds: 500)));
    } else {
      if (widget.fromCheckIn) {
        final provider = Provider.of<AppProvider>(context, listen: false);
        registerCheckIn(() {
          Navigator.push(
              context,
              PageTransition(
                  child: DonePage(
                    HomePage(),
                    pushAndRemoveUntil: true,
                  ),
                  type: PageTransitionType.slideInUp,
                  duration: Duration(milliseconds: 500)));
        }, provider.checkout!.id.toString(), context);
      } else {
        registerCheckOut(() {
          Navigator.push(
              context,
              PageTransition(
                  child: DonePage(
                    HomePage(),
                    pushAndRemoveUntil: true,
                  ),
                  type: PageTransitionType.slideInUp,
                  duration: Duration(milliseconds: 500)));
        }, context);
      }
    }
  }
}
