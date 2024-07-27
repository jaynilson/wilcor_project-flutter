import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_page_transition/flutter_page_transition.dart';
import 'package:provider/provider.dart';
import 'package:wilcoerp/components/big_button_menus.dart';
import 'package:wilcoerp/constants/colors.dart';
import 'package:wilcoerp/helpers/helpers.dart';
import 'package:wilcoerp/models/request_category.dart';
import 'package:wilcoerp/pages/maintenance_categories_page.dart';
import 'package:wilcoerp/pages/repair_categories_page.dart';
import 'package:wilcoerp/pages/select_trailers_page.dart';
import 'package:wilcoerp/pages/select_trucks_cars_page.dart';
import 'package:wilcoerp/providers/app.dart';
import 'package:wilcoerp/services/web_service.dart';

class ReportProblemCategoryPage extends StatefulWidget {
  const ReportProblemCategoryPage({super.key});

  @override
  State<ReportProblemCategoryPage> createState() =>
      _ReportProblemCategoryPageState();
}

class _ReportProblemCategoryPageState extends State<ReportProblemCategoryPage> {
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
                        "REPORT A PROBLEM",
                        style: TextStyle(
                            color: CustomColors.primary,
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: BigButtonMenus("gears.png", "MAINTENANCE", () {
                        process("maintenance");
                      }),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: BigButtonMenus("support.png", "REPAIR", () {
                        process("repair");
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

  process(String type) {
    simpleLoading(context, (BuildContext loadingContext) {
      final provider = Provider.of<AppProvider>(context, listen: false);
      WebService(context)
          .getRequestCategory(type, provider.user.token!)
          .then((data) async {
        Navigator.pop(loadingContext);

        if (type == "maintenance") {
          Navigator.push(
              context,
              PageTransition(
                  child: MaintenanceCategoriesPage(data),
                  type: PageTransitionType.slideInUp,
                  duration: Duration(milliseconds: 500)));
        } else if (type == "repair") {
          Navigator.push(
              context,
              PageTransition(
                  child: RepairCategoriesPage(data),
                  type: PageTransitionType.slideInUp,
                  duration: Duration(milliseconds: 500)));
        }
      }).catchError((e) {
        print("Error");
        print(e);
        Navigator.pop(loadingContext);
        showErrorsDialog(context, e);
      });
    });
  }
}
