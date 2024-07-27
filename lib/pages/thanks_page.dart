import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_page_transition/flutter_page_transition.dart';
import 'package:wilcoerp/components/fade_animation.dart';
import 'package:wilcoerp/constants/colors.dart';
import 'package:wilcoerp/helpers/helpers.dart';
import 'package:wilcoerp/pages/check_out_page.dart';

class ThanksPage extends StatefulWidget {
  Widget pageToGoAfter;
  bool pushAndRemoveUntil;
  ThanksPage(this.pageToGoAfter, {super.key, this.pushAndRemoveUntil = false});

  @override
  State<ThanksPage> createState() => _ThanksPageState();
}

class _ThanksPageState extends State<ThanksPage> {
  @override
  void initState() {
    super.initState();

    Timer(Duration(seconds: 2), () async {
      try {
        if (widget.pushAndRemoveUntil) {
          Navigator.pushAndRemoveUntil(
              context,
              PageTransition(
                  child: widget.pageToGoAfter,
                  type: PageTransitionType.slideInUp,
                  duration: Duration(milliseconds: 250)),
              (Route<dynamic> route) => false);
        } else {
          Navigator.pushReplacement(
              context,
              PageTransition(
                  child: widget.pageToGoAfter,
                  type: PageTransitionType.slideInUp,
                  duration: Duration(milliseconds: 500)));
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
      extendBody: true,
      appBar: getAppBar(context),
      body: Center(
        child: ListView(
          shrinkWrap: true,
          children: [
            Padding(
              padding: EdgeInsets.all(MediaQuery.of(context).size.width * .08),
              child: Center(
                child: FadeAnimation(
                  1,
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset('assets/images/corazon.png', width: 130),
                      Padding(
                        padding: const EdgeInsets.only(top: 25.0),
                        child: Text(
                          "THANKS",
                          style: TextStyle(
                              color: CustomColors.primary, fontSize: 25),
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
}
