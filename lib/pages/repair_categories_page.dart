import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_page_transition/flutter_page_transition.dart';
import 'package:wilcoerp/components/big_button_menus.dart';
import 'package:wilcoerp/constants/colors.dart';
import 'package:wilcoerp/constants/globals.dart';
import 'package:wilcoerp/helpers/helpers.dart';
import 'package:wilcoerp/models/request_category.dart';
import 'package:wilcoerp/pages/description_report_problem.dart';

class RepairCategoriesPage extends StatefulWidget {
  List<RequestCategoryModel> requestCategories;
  RepairCategoriesPage(this.requestCategories, {super.key});

  @override
  State<RepairCategoriesPage> createState() => _RepairCategoriesPageState();
}

class _RepairCategoriesPageState extends State<RepairCategoriesPage> {
  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = widget.requestCategories.map((e) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: BigButtonMenus("support.png", (e.title ?? "").toUpperCase(), () {
          global_category = e.id;
          goToDescriptionReportProblem();
        }),
      );
    }).toList();

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
                        "REPAIR",
                        style: TextStyle(
                            color: CustomColors.primary,
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Column(children: widgets),
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

  goToDescriptionReportProblem() {
    Navigator.push(
        context,
        PageTransition(
            child: DescriptionReportProblemPage(),
            type: PageTransitionType.slideInUp,
            duration: Duration(milliseconds: 500)));
  }
}
