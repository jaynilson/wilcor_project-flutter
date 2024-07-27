import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_page_transition/flutter_page_transition.dart';
import 'package:wilcoerp/components/big_button_menus.dart';
import 'package:wilcoerp/constants/colors.dart';
import 'package:wilcoerp/constants/globals.dart';
import 'package:wilcoerp/helpers/helpers.dart';
import 'package:wilcoerp/pages/check_out_tools_page.dart';
import 'package:wilcoerp/pages/request_tool_page.dart';
import 'package:wilcoerp/pages/select_tools_page.dart';

class ToolsCategoriesRequestPage extends StatefulWidget {
  const ToolsCategoriesRequestPage({super.key});

  @override
  State<ToolsCategoriesRequestPage> createState() =>
      _ToolsCategoriesRequestPageState();
}

class _ToolsCategoriesRequestPageState
    extends State<ToolsCategoriesRequestPage> {
  @override
  void initState() {
    super.initState();
    registerLocation(context);
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 25.0),
                      child: Text(
                        "TOOLS CATEGORIES",
                        style: TextStyle(
                            color: CustomColors.primary,
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: BigButtonMenus("support.png", "PPE", () {
                        Navigator.push(
                            context,
                            PageTransition(
                                child:
                                    SelectToolsPage(RequestToolPage(), "ppe"),
                                type: PageTransitionType.slideInUp,
                                duration: Duration(milliseconds: 500)));
                      }),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: BigButtonMenus("support.png", "CONSUMABLES", () {
                        Navigator.push(
                            context,
                            PageTransition(
                                child: SelectToolsPage(
                                    RequestToolPage(), "consumables"),
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
