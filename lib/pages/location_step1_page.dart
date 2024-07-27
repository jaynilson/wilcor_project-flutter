import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_page_transition/flutter_page_transition.dart';
import 'package:wilcoerp/components/big_button_menus.dart';
import 'package:wilcoerp/constants/colors.dart';
import 'package:wilcoerp/constants/globals.dart';
import 'package:wilcoerp/helpers/helpers.dart';
import 'package:wilcoerp/pages/done_page.dart';
import 'package:wilcoerp/pages/location_step2_page.dart';
import 'package:wilcoerp/services/web_service.dart';
import 'package:provider/provider.dart';
import 'package:wilcoerp/providers/app.dart';

class LocationStep1Page extends StatefulWidget {
  Widget pageAfter;
  LocationStep1Page(this.pageAfter, {super.key});

  @override
  State<LocationStep1Page> createState() => _LocationStep1PageState();
}

class _LocationStep1PageState extends State<LocationStep1Page> {
  List<String> locations = [];

  @override
  void initState() {
    super.initState();
    load();
  }

  Future<Null> load() async {
    final provider = Provider.of<AppProvider>(context, listen: false);
    try {
      final data = await WebService(context).getLocations(provider.user.token ?? "");
      if (mounted) {
        setState(() {
          locations = data;
        });
      }
    } catch (e) {
      showErrorsDialog(context, e);
    }
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
                        "LOCATION",
                        style: TextStyle(
                            color: CustomColors.primary,
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: BigButtonMenus("social.png", "OTHER", () {
                        Navigator.push(
                            context,
                            PageTransition(
                                child: LocationStep2Page(widget.pageAfter),
                                type: PageTransitionType.slideInUp,
                                duration: Duration(milliseconds: 500)));
                      }),
                    ),
                    for (String location in locations.where((location) => location != null).toList())
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: BigButtonMenus("maps-and-flags.png", location, () {
                        goSetLocation(location);
                      }),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  goSetLocation(String placeName) {
    place = placeName;
    Navigator.push(
        context,
        PageTransition(
            child: DonePage(widget.pageAfter),
            type: PageTransitionType.slideInUp,
            duration: Duration(milliseconds: 500)));
  }
}
