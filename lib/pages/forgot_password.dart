import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:wilcoerp/components/fade_animation.dart';
import 'package:wilcoerp/constants/colors.dart';
import 'package:wilcoerp/helpers/helpers.dart';
import 'package:wilcoerp/providers/app.dart';
import 'package:wilcoerp/services/web_service.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextStyle style = TextStyle(fontSize: 18.0);
  final formKey = new GlobalKey<FormState>();

  final myControllerEmail = TextEditingController();

  bool passwordVisible = true;
  bool passwordVisibleRepeat = true;
  var secondsFormEleAnim = 0.7;
  var tabIndex = 0;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var tabs = <Widget>[
      Container(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: forgotForm(),
        ),
      )
    ];
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            child: Stack(
          children: <Widget>[
            // The containers in the background
            new Column(
              children: <Widget>[
                /*  FadeAnimation(
                  0.5,
                  Container(
                    height: MediaQuery.of(context).size.height * .40,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/background1.jpg'),
                            fit: BoxFit.cover)),
                  ),
                ),*/
                new Container(
                  height: MediaQuery.of(context).size.height * .60,
                  color: Colors.white,
                ),
              ],
            ),
            // The card widget with top padding,
            // incase if you wanted bottom padding to work,
            // set the `alignment` of container to Alignment.bottomCenter
            Center(
              child: new Container(
                alignment: Alignment.topCenter,
                constraints:
                    (kIsWeb) ? BoxConstraints(maxWidth: 600) : BoxConstraints(),
                padding: new EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * .30,
                    right: 20.0,
                    left: 20.0),
                child: new Container(
                  width: MediaQuery.of(context).size.width,
                  child: new Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    color: Colors.white,
                    elevation: 4.0,
                    child: DefaultTabController(
                        length: 1,
                        child: Column(
                          children: <Widget>[
                            Container(
                              margin: const EdgeInsets.only(top: 12.0),
                              height: 45,
                              color: Colors.transparent,
                              child: TabBar(
                                isScrollable: false,
                                tabs: [
                                  Tab(
                                    text: "¿Forgot your pin?",
                                    iconMargin: EdgeInsets.all(0),
                                    icon: null,
                                  )
                                ],
                                labelColor: Colors.grey[900],
                                labelStyle: TextStyle(fontSize: 18.0),
                                unselectedLabelColor: Colors.grey[400],
                                indicatorSize: TabBarIndicatorSize.label,
                                indicatorPadding: EdgeInsets.all(0),
                                indicatorColor: Colors.white,
                                labelPadding: EdgeInsets.only(top: 10),
                                onTap: (i) {
                                  setState(() {
                                    tabIndex = i;
                                    secondsFormEleAnim = 0;
                                  });
                                  FocusScope.of(context)
                                      .requestFocus(FocusNode());
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Container(
                                height: 2,
                                color: Colors.grey[100],
                              ),
                            ),
                            tabs[tabIndex]
                          ],
                        )),
                  ),
                ),
              ),
            ),
            AppBar(
                iconTheme: IconThemeData(
                  color: CustomColors.primary, //change your color here
                ),
                title: Text(""),
                backgroundColor: Colors.transparent,
                elevation: 0.0,
                centerTitle: true)
          ],
        )));
  }

  Widget forgotForm() {
    final emailField = TextFormField(
      controller: myControllerEmail,
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.emailAddress,
      validator: (val) {
        return validateEmail(val ?? "", context);
      },
      obscureText: false,
      style: style,
      //initialValue: Environment.localUsername(),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: "Your email",
        hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
        fillColor: Colors.white,
        focusColor: CustomColors.primary,
        filled: true,
        prefixIcon: Icon(FontAwesomeIcons.solidEnvelope, size: 20),
        border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade300, width: 2.0),
            borderRadius: BorderRadius.circular(10.0)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade300, width: 2.0),
            borderRadius: BorderRadius.circular(10.0)),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade300, width: 2.0),
            borderRadius: BorderRadius.circular(10.0)),
      ),
      onFieldSubmitted: (val) {
        sendResetPassword();
      },
    );

    final resButton = ButtonTheme(
      minWidth: 230.0,
      child: MaterialButton(
        color: CustomColors.primary,
        padding: EdgeInsets.fromLTRB(50.0, 10.0, 50.0, 10.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
          side: BorderSide.none,
        ),
        child: Row(
          // Replace with a Row for horizontal icon + text

          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
                padding: EdgeInsets.only(right: 8),
                child: Icon(FontAwesomeIcons.check,
                    size: 20, color: Colors.white)),
            Text(
              "Send",
              textAlign: TextAlign.center,
              style: style.copyWith(
                  color: Colors.white, fontWeight: FontWeight.bold),
            )
          ],
        ),
        onPressed: () {
          sendResetPassword();
        },
      ),
    );

    return Form(
      key: formKey,
      child: Column(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(top: 10.0),
            child: Center(
              child: FadeAnimation(
                  secondsFormEleAnim,
                  Text(
                    "Please enter your email address. You will receive your pin.",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 14),
                    textAlign: TextAlign.center,
                  )),
            ),
          ),
          FadeAnimation(
              secondsFormEleAnim + 0.2,
              Container(
                  child: emailField, margin: const EdgeInsets.only(top: 10.0))),
          FadeAnimation(
              secondsFormEleAnim + 0.4,
              Container(
                  child: resButton, margin: const EdgeInsets.only(top: 20.0)))
        ],
      ),
    );
  }

  sendResetPassword() {
    final form = formKey.currentState;
    if (form!.validate()) {
      form.save();

      simpleLoading(context, (BuildContext loadingContext) {
        final provider = Provider.of<AppProvider>(context, listen: false);
        WebService(context).resendPin(myControllerEmail.text).then((res) async {
          Navigator.pop(loadingContext);
          if (res) {
            successSendAlert();
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

  void successSendAlert() {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            content: Container(
                height: 380,
                child: Column(
                  children: <Widget>[
                    Image(
                      image: AssetImage('assets/images/lock_reset.png'),
                      width: 130,
                      height: 130,
                    ),
                    Container(
                      margin: EdgeInsets.all(15.0),
                      child: Text(
                        'Your pin has been sent',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 15.0),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(15.0),
                      child: Text(
                        'You will receive an email with your pin',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 15.0),
                      ),
                    ),
                    ButtonTheme(
                      minWidth: 230.0,
                      child: MaterialButton(
                        color: CustomColors.primary,
                        padding: EdgeInsets.fromLTRB(50.0, 10.0, 50.0, 10.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          side: BorderSide.none,
                        ),
                        child: Text(
                          "Ok",
                          textAlign: TextAlign.center,
                          style: style.copyWith(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                      ),
                    )
                  ],
                )),
          );
        });
  }
}
