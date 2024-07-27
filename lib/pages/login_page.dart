import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_page_transition/flutter_page_transition.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:wilcoerp/constants/colors.dart';
import 'package:wilcoerp/helpers/helpers.dart';
import 'package:wilcoerp/pages/forgot_password.dart';
import 'package:wilcoerp/pages/home_page.dart';
import 'package:wilcoerp/providers/app.dart';
import 'package:wilcoerp/services/web_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final cPin = TextEditingController();
  final formKey = new GlobalKey<FormState>();
  bool pinVisible = true;

  @override
  Widget build(BuildContext context) {
    final pinField = TextFormField(
        inputFormatters: [
          FilteringTextInputFormatter.deny(RegExp('[ ]')),
        ],
        validator: (val) {
          return validatePin(val ?? "", context);
        },
        onFieldSubmitted: (val) {
          processSignIn();
        },
        controller: cPin,
        obscureText: pinVisible,
        style: TextStyle(fontSize: 18.0),
        //initialValue: Environment.localPassword(),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "PIN",
          hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
          fillColor: Colors.white,
          filled: true,
          suffixIcon: IconButton(
            icon: Icon(
              pinVisible ? Icons.visibility : Icons.visibility_off,
            ),
            onPressed: () {
              setState(() {
                pinVisible = !pinVisible;
              });
            },
          ),
          border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade500, width: 2.0),
              borderRadius: BorderRadius.circular(10.0)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade500, width: 2.0),
              borderRadius: BorderRadius.circular(10.0)),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade500, width: 2.0),
              borderRadius: BorderRadius.circular(10.0)),
        ));

    Widget btnLogin = ElevatedButton(
      style: ElevatedButton.styleFrom(
          elevation: 2,
          primary: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          )),
      onPressed: () {
        processSignIn();
      },
      child: Container(
        width: double.infinity,
        height: 35.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Login",
              style: TextStyle(color: Colors.white, fontSize: 14.0),
            ),
          ],
        ),
      ),
    );

    return Scaffold(
      backgroundColor: CustomColors.primary,
      extendBody: true,
      body: Center(
          child: ListView(
        shrinkWrap: true,
        children: [
          Padding(
            padding: EdgeInsets.all(MediaQuery.of(context).size.width * .08),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        child: Image.asset(
                          'assets/images/user_black.png',
                          width: 100,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: pinField,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: btnLogin,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              PageTransition(
                                  child: ForgotPassword(),
                                  type: PageTransitionType.slideInRight,
                                  duration: Duration(milliseconds: 250)));
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20.0),
                          child: Text(
                            "Forgot your PIN?",
                            style: TextStyle(
                              color: Colors.grey,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 0,
          ),
          Image.asset(
            'assets/images/logo_white.png',
            height: 60,
          )
        ],
      )),
    );
  }

  processSignIn() async {
    final form = formKey.currentState;
    if (form!.validate()) {
      form.save();

      simpleLoading(context, (BuildContext loadingContext) {
        final provider = Provider.of<AppProvider>(context, listen: false);
        WebService(context).signIn(cPin.text).then((user) async {
          await provider.setUser(user);

          initProcess(context, user, () {
            Navigator.pop(loadingContext);
            Navigator.pushAndRemoveUntil(
                context,
                PageTransition(
                    child: HomePage(),
                    type: PageTransitionType.slideInUp,
                    duration: Duration(milliseconds: 250)),
                (Route<dynamic> route) => false);
          });
        }).catchError((e) {
          print("Error");
          print(e);
          Navigator.pop(loadingContext);
          showErrorsDialog(context, e);
        });
      });
    }
  }
}
