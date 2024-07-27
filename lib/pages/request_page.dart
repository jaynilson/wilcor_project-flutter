import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_page_transition/flutter_page_transition.dart';
import 'package:wilcoerp/components/big_button_menus.dart';
import 'package:wilcoerp/helpers/helpers.dart';
import 'package:wilcoerp/pages/auto_incident_step2_page.dart';
import 'package:wilcoerp/pages/request_equipment_page.dart';
import 'package:wilcoerp/pages/request_tool_page.dart';
import 'package:wilcoerp/pages/request_trailer_page.dart';
import 'package:wilcoerp/pages/request_trucks_page.dart';
import 'package:wilcoerp/pages/select_equipment_page.dart';
import 'package:wilcoerp/pages/select_equipment_request_page.dart';
import 'package:wilcoerp/pages/select_tools_page.dart';
import 'package:wilcoerp/pages/select_tools_request_page.dart';
import 'package:wilcoerp/pages/select_trailers_page.dart';
import 'package:wilcoerp/pages/select_trailers_request_page.dart';
import 'package:wilcoerp/pages/select_trucks_cars_page.dart';
import 'package:wilcoerp/pages/select_trucks_cars_request_page.dart';
import 'package:wilcoerp/pages/tools_categories_request_page.dart';

import '../constants/colors.dart';

class RequestPage extends StatefulWidget {
  const RequestPage({super.key});

  @override
  State<RequestPage> createState() => _RequestPageState();
}

class _RequestPageState extends State<RequestPage> {
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
                        "REQUEST",
                        style: TextStyle(
                            color: CustomColors.primary,
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child:
                          BigButtonMenus("pickup-truck.png", "VEHICLES", () {
                        Navigator.push(
                            context,
                            PageTransition(
                                child:
                                    SelectTrucksCarsPage(RequestTrucksPage()),
                                type: PageTransitionType.slideInUp,
                                duration: Duration(milliseconds: 500)));
                      }),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child:
                          BigButtonMenus("delivery-truck.png", "TRAILERS", () {
                        Navigator.push(
                            context,
                            PageTransition(
                                child: SelectTrailersPage(RequestTrailerPage()),
                                type: PageTransitionType.slideInUp,
                                duration: Duration(milliseconds: 500)));
                      }),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: BigButtonMenus("crane.png", "EQUIPMENT", () {
                        Navigator.push(
                            context,
                            PageTransition(
                                child:
                                    SelectEquipmentPage(RequestEquipmentPage()),
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
                                child: ToolsCategoriesRequestPage(),
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

  goLocationStep1() {
    /*Navigator.push(
        context,
        PageTransition(
            child: LocationStep1Page(LocationStep2Page()),
            type: PageTransitionType.slideInUp,
            duration: Duration(milliseconds: 500)));*/
  }
}
