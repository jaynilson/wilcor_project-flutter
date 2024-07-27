import 'dart:async';
import 'dart:convert';

import 'package:wilcoerp/constants/colors.dart';
import 'package:wilcoerp/helpers/helpers.dart';
import 'package:wilcoerp/models/app_preferences.dart';
import 'package:wilcoerp/models/user.dart';
import 'package:wilcoerp/pages/home_page.dart';
import 'package:wilcoerp/pages/login_page.dart';
import 'package:wilcoerp/providers/app.dart';
import 'package:wilcoerp/components/fade_animation.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_page_transition/flutter_page_transition.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:provider/provider.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  int lagSeconds = 2;

  @override
  void dispose() {
    super.dispose();
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) async {
      SystemChrome.setEnabledSystemUIOverlays([]);

      _initProcess();
    });
  }

  _initProcess() async {
    final provider = Provider.of<AppProvider>(context, listen: false);

    Timer(Duration(seconds: lagSeconds), () async {
      try {
        UserModel user = await AppPreferences().getUser();

        try {
          if (user.id == null) {
            Navigator.pushAndRemoveUntil(
                context,
                PageTransition(
                    child: LoginPage(),
                    type: PageTransitionType.slideInUp,
                    duration: Duration(milliseconds: 250)),
                (Route<dynamic> route) => false);
          } else {
            await provider.setUser(user);

            initProcess(context, user, () {
              Navigator.pushAndRemoveUntil(
                  context,
                  PageTransition(
                      child: HomePage(),
                      type: PageTransitionType.slideInUp,
                      duration: Duration(milliseconds: 250)),
                  (Route<dynamic> route) => false);
            });
          }
        } catch (e) {
          Navigator.pushAndRemoveUntil(
              context,
              PageTransition(
                  child: LoginPage(),
                  type: PageTransitionType.slideInUp,
                  duration: Duration(milliseconds: 250)),
              (Route<dynamic> route) => false);
        }
      } catch (e) {
        print("error al cargar");
        print(e);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: CustomColors.primary,
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: FadeAnimation(
                      2,
                      Image.asset('assets/images/logo_white.png',
                          width: MediaQuery.of(context).size.width * .50)),
                ),
                SizedBox(
                  height: 20,
                ),
                JumpingDotsProgressIndicator(
                  fontSize: 50.0,
                  color: Colors.white,
                  numberOfDots: 4,
                  milliseconds: 150,
                ),
              ],
            ),
          ),
        ));
  }
}
