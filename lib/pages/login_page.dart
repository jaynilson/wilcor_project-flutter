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
  final cEmail = TextEditingController();
  final cPassword = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    final emailField = TextFormField(
      controller: cEmail,
      keyboardType: TextInputType.emailAddress,
      validator: (val) {
        if (val == null || val.isEmpty) {
          return 'Please enter your email';
        }
        if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(val)) {
          return 'Please enter a valid email';
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: "Email",
        prefixIcon: Icon(Icons.email),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
      ),
    );

    final passwordField = TextFormField(
      controller: cPassword,
      obscureText: !passwordVisible,
      validator: (val) {
        if (val == null || val.isEmpty) {
          return 'Please enter your password';
        }
        if (val.length < 2) {
          return 'Password must be at least 1 characters long';
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: "Password",
        prefixIcon: Icon(Icons.lock),
        suffixIcon: IconButton(
          icon: Icon(
            passwordVisible ? Icons.visibility : Icons.visibility_off,
          ),
          onPressed: () {
            setState(() {
              passwordVisible = !passwordVisible;
            });
          },
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
      ),
    );

    Widget btnLogin = ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      onPressed: processSignIn,
      child: Container(
        width: double.infinity,
        height: 35.0,
        child: Center(
          child: Text(
            "Login",
            style: TextStyle(color: Colors.white, fontSize: 14.0),
          ),
        ),
      ),
    );

    return Scaffold(
      backgroundColor: CustomColors.primary,
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
                          child: emailField,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: passwordField,
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
                                duration: Duration(milliseconds: 250),
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20.0),
                            child: Text(
                              "Forgot your password?",
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
            Image.asset(
              'assets/images/logo_white.png',
              height: 60,
            )
          ],
        ),
      ),
    );
  }

  processSignIn() async {
    if (formKey.currentState!.validate()) {
      simpleLoading(context, (BuildContext loadingContext) {
        final provider = Provider.of<AppProvider>(context, listen: false);
        WebService(context).signIn(cEmail.text, cPassword.text).then((user) async {
          await provider.setUser(user);

          initProcess(context, user, () {
            Navigator.pop(loadingContext);
            Navigator.pushAndRemoveUntil(
              context,
              PageTransition(
                child: HomePage(),
                type: PageTransitionType.slideInUp,
                duration: Duration(milliseconds: 250),
              ),
              (Route<dynamic> route) => false,
            );
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
