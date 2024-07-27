import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_page_transition/flutter_page_transition.dart';
import 'package:provider/provider.dart';
import 'package:wilcoerp/constants/colors.dart';
import 'package:wilcoerp/constants/globals.dart';
import 'package:wilcoerp/helpers/helpers.dart';
import 'package:wilcoerp/models/checkout.dart';
import 'package:wilcoerp/pages/check_in_tools_options_page.dart';
import 'package:wilcoerp/providers/app.dart';

class CheckInToolsSelectPage extends StatefulWidget {
  const CheckInToolsSelectPage({super.key});

  @override
  State<CheckInToolsSelectPage> createState() => _CheckInToolsSelectPageState();
}

class _CheckInToolsSelectPageState extends State<CheckInToolsSelectPage> {
  @override
  Widget build(BuildContext context) {
    InputDecoration decorationFields = InputDecoration(
      contentPadding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
      hintText: "",
      hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
      fillColor: Colors.grey.shade300,
      focusColor: Colors.grey,
      hoverColor: Colors.grey,
      filled: true,
      border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade400, width: 0),
          borderRadius: BorderRadius.circular(10.0)),
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade400, width: 0),
          borderRadius: BorderRadius.circular(10.0)),
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade400, width: 0),
          borderRadius: BorderRadius.circular(10.0)),
      errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade400, width: 0),
          borderRadius: BorderRadius.circular(10.0)),
      focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade400, width: 0),
          borderRadius: BorderRadius.circular(10.0)),
    );
    final provider = Provider.of<AppProvider>(context, listen: false);
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
                child: Form(
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
                      Column(
                        children: provider.checkoutsTools.map((e) {
                          return getItemTemplate(e);
                        }).toList(),
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

  Widget getItemTemplate(CheckOut checkout) {
    return Card(
      color: Colors.grey.shade200,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            FadeInImage.assetNetwork(
              placeholder: "assets/images/loading-image1.gif",
              imageErrorBuilder: (context, error, stackTrace) {
                return Container();
              },
              image: imagesUrlTool + checkout.tool!.picture.toString() ?? "",
              height: 160,
              width: 130,
              fit: BoxFit.fitWidth,
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 3.0),
              child: Row(
                children: [
                  Text(
                    "N:",
                    style: TextStyle(),
                  ),
                  Text(checkout.tool!.id.toString())
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 3.0),
              child: Row(
                children: [
                  Text(
                    "NAME:",
                    style: TextStyle(),
                  ),
                  Text(checkout.tool!.title ?? "")
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 3.0),
              child: Row(
                children: [
                  Text(
                    "QUANTITY:",
                    style: TextStyle(),
                  ),
                  Text(checkout.quantity.toString())
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 3.0),
              child: Row(
                children: [
                  Text(
                    "IN USE:",
                    style: TextStyle(),
                  ),
                  Text(getTimeUse(checkout.created_at!))
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    elevation: 2,
                    primary: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    )),
                onPressed: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          child: CheckInToolsOptionsPage(checkout),
                          type: PageTransitionType.slideInUp,
                          duration: Duration(milliseconds: 500)));
                },
                child: Container(
                  width: double.infinity,
                  height: 50.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Flexible(
                        flex: 12,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Flexible(
                                  child: Text(
                                    "SELECT",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.0,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
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
}
