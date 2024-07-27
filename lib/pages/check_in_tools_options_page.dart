import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_page_transition/flutter_page_transition.dart';
import 'package:provider/provider.dart';
import 'package:wilcoerp/constants/colors.dart';
import 'package:wilcoerp/constants/globals.dart';
import 'package:wilcoerp/helpers/helpers.dart';
import 'package:wilcoerp/models/checkout.dart';
import 'package:wilcoerp/pages/damage_page.dart';
import 'package:wilcoerp/pages/done_page.dart';
import 'package:wilcoerp/pages/home_page.dart';
import 'package:wilcoerp/pages/lost_stolen_page.dart';
import 'package:wilcoerp/pages/upload_photos_tools_page.dart';
import 'package:wilcoerp/providers/app.dart';
import 'package:wilcoerp/services/web_service.dart';

class CheckInToolsOptionsPage extends StatefulWidget {
  CheckOut checkOut;

  CheckInToolsOptionsPage(this.checkOut, {super.key});

  @override
  State<CheckInToolsOptionsPage> createState() =>
      _CheckInToolsOptionsPageState();
}

class _CheckInToolsOptionsPageState extends State<CheckInToolsOptionsPage> {
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
                      Card(
                        color: Colors.grey.shade200,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              FadeInImage.assetNetwork(
                                placeholder: "assets/images/loading-image1.gif",
                                imageErrorBuilder:
                                    (context, error, stackTrace) {
                                  return Container();
                                },
                                image: imagesUrlTool +
                                        widget.checkOut.tool!.picture
                                            .toString() ??
                                    "",
                                height: 160,
                                width: 130,
                                fit: BoxFit.fitWidth,
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
                                      "N:",
                                      style: TextStyle(),
                                    ),
                                    Text(widget.checkOut.tool!.n.toString())
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 3.0),
                                child: Row(
                                  children: [
                                    Text(
                                      "NAME:",
                                      style: TextStyle(),
                                    ),
                                    Text(widget.checkOut.tool!.title.toString())
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 3.0),
                                child: Row(
                                  children: [
                                    Text(
                                      "QUANTITY:",
                                      style: TextStyle(),
                                    ),
                                    Text(widget.checkOut.quantity.toString() +
                                        " units")
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 3.0),
                                child: Row(
                                  children: [
                                    Text(
                                      "IN USE:",
                                      style: TextStyle(),
                                    ),
                                    Text(
                                        getTimeUse(widget.checkOut.created_at!))
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 18.0, vertical: 8),
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
                                    child: UploadPhotosToolsPage((pictures) {
                                      checkin(pictures);
                                    }),
                                    type: PageTransitionType.slideInUp,
                                    duration: Duration(milliseconds: 500)));
                          },
                          child: Container(
                            width: double.infinity,
                            height: 60.0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Flexible(
                                  flex: 12,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Flexible(
                                            child: Text(
                                              "CHECK-IN",
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
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 18.0, vertical: 8),
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
                                    child: DamagePage(widget.checkOut),
                                    type: PageTransitionType.slideInUp,
                                    duration: Duration(milliseconds: 500)));
                          },
                          child: Container(
                            width: double.infinity,
                            height: 60.0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Flexible(
                                  flex: 12,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Flexible(
                                            child: Text(
                                              "DAMAGED",
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
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 18.0, vertical: 8),
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
                                    child: LostStolenPage(widget.checkOut),
                                    type: PageTransitionType.slideInUp,
                                    duration: Duration(milliseconds: 500)));
                          },
                          child: Container(
                            width: double.infinity,
                            height: 60.0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Flexible(
                                  flex: 12,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Flexible(
                                            child: Text(
                                              "LOST/STOLEN",
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
                      ),
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

  checkin(pictures) {
    simpleLoading(context, (BuildContext loadingContext) {
      final provider = Provider.of<AppProvider>(context, listen: false);
      WebService(context)
          .checkInTool(
              provider.user.id.toString(),
              widget.checkOut.tool!.id.toString(),
              widget.checkOut.id.toString(),
              provider.user.token ?? "")
          .then((data) async {
        for (var i = 0; i < pictures.length; i++) {
          await WebService(context).uploadAsset(
              "check_in_tools",
              data["id"].toString(),
              pictures[i],
              provider.user.token.toString());
        }

        List<CheckOut> checkouts = await WebService(context)
            .getCheckoutTool(provider.user.token ?? "", provider.user.id!);
        provider.setCheckoutsTools(checkouts);
        Navigator.pop(loadingContext);
        Navigator.push(
            context,
            PageTransition(
                child: DonePage(
                  HomePage(),
                  pushAndRemoveUntil: true,
                ),
                type: PageTransitionType.slideInUp,
                duration: Duration(milliseconds: 500)));
      }).catchError((e) {
        print("Error");
        print(e);
        Navigator.pop(loadingContext);
        showErrorsDialog(context, e);
      });
    });
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
