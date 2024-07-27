import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_page_transition/flutter_page_transition.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';
import 'package:wilcoerp/constants/colors.dart';
import 'package:wilcoerp/constants/globals.dart';
import 'package:wilcoerp/helpers/helpers.dart';
import 'package:wilcoerp/pages/checks_trailer_page.dart';
import 'package:wilcoerp/pages/checks_truck_page.dart';
import 'package:wilcoerp/pages/odometer_reading_page.dart';
import 'package:wilcoerp/pages/request_tool_page.dart';

class SelectToolsRequestPage extends StatefulWidget {
  SelectToolsRequestPage({super.key});

  @override
  State<SelectToolsRequestPage> createState() => _SelectToolsRequestPageState();
}

class _SelectToolsRequestPageState extends State<SelectToolsRequestPage> {
  final cSearch = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final searchField = TextFormField(
      autofocus: false,
      textInputAction: TextInputAction.search,
      controller: cSearch,
      keyboardType: TextInputType.text,
      readOnly: false,
      obscureText: false,
      style: TextStyle(fontSize: 18.0),
      //initialValue: Environment.localUsername(),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 18.0, 20.0, 18.0),
        hintText: "Search",
        hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
        fillColor: Colors.white,
        focusColor: Colors.grey,
        hoverColor: Colors.grey,
        filled: true,
        suffixIcon: InkWell(
          onTap: () {
            cSearch.text = "";
            FocusScope.of(context).unfocus();
          },
          child: Icon(
            FontAwesomeIcons.search,
            size: 20,
            color: Colors.grey.shade400,
          ),
        ),
        border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade300, width: 1.5),
            borderRadius: BorderRadius.circular(10.0)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade300, width: 1.5),
            borderRadius: BorderRadius.circular(10.0)),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade300, width: 1.5),
            borderRadius: BorderRadius.circular(10.0)),
        errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red.shade300, width: 1.5),
            borderRadius: BorderRadius.circular(10.0)),
        focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red.shade300, width: 1.5),
            borderRadius: BorderRadius.circular(10.0)),
      ),
      onFieldSubmitted: (val) {
        if (cSearch.text.trim() != "") {}
      },
    );

    return Scaffold(
        extendBody: true,
        appBar: getAppBar(context),
        body: Stack(
          children: [
            Positioned.fill(
                top: MediaQuery.of(context).padding.top + 90,
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          getItemTemplate("1139", "Martillo", "30 units"),
                          getItemTemplate("1139", "Martillo", "30 units"),
                          getItemTemplate("1139", "Martillo", "30 units"),
                          getItemTemplate("1139", "Martillo", "30 units"),
                          getItemTemplate("1139", "Martillo", "30 units"),
                          getItemTemplate("1139", "Martillo", "30 units"),
                          getItemTemplate("1139", "Martillo", "30 units"),
                          getItemTemplate("1139", "Martillo", "30 units"),
                          getItemTemplate("1139", "Martillo", "30 units"),
                          getItemTemplate("1139", "Martillo", "30 units"),
                          getItemTemplate("1139", "Martillo", "30 units"),
                          getItemTemplate("1139", "Martillo", "30 units"),
                          getItemTemplate("1139", "Martillo", "30 units"),
                          getItemTemplate("1139", "Martillo", "30 units"),
                          getItemTemplate("1139", "Martillo", "30 units"),
                        ],
                      ),
                    )
                  ],
                )),
            Positioned(
                left: 0,
                top: MediaQuery.of(context).padding.top - 20,
                height: 130,
                width: MediaQuery.of(context).size.width,
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                                child: Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: searchField,
                            )),
                            InkWell(
                              onTap: () async {
                                var res = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const SimpleBarcodeScannerPage(),
                                    ));
                                setState(() {
                                  if (res is String) {
                                    print(res);
                                  }
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(
                                  FontAwesomeIcons.camera,
                                  color: Colors.grey,
                                  size: 25,
                                ),
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 30,
                                width: 108,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30.0),
                                  color: Colors.grey.shade300,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Icon(
                                        Icons.check_circle,
                                        color: Colors.black,
                                        size: 18,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 9),
                                      child: Text("AVAILABLE",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: "",
                                              fontSize: 11,
                                              fontWeight: FontWeight.w900)),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 30,
                                width: 120,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30.0),
                                  color: Colors.grey.shade300,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Icon(
                                        FontAwesomeIcons.solidTimesCircle,
                                        color: CustomColors.primary,
                                        size: 18,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 9),
                                      child: Text("NOT AVAILABLE",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: "",
                                              fontSize: 11,
                                              fontWeight: FontWeight.w900)),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ))
          ],
        ));
  }

  Widget getItemTemplate(String num, String name, String stock) {
    return Card(
      color: Color.fromARGB(255, 233, 233, 233),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 12.0),
        child: Row(
          children: [
            Image.asset(
              'assets/images/martillo.png',
              height: 160,
              width: 160,
              fit: BoxFit.fitWidth,
            ),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 2),
                    child: Container(
                      child: Row(
                        children: [
                          Text(
                            "N:",
                            style: TextStyle(
                                fontFamily: "",
                                fontWeight: FontWeight.bold,
                                fontSize: 12),
                          ),
                          Flexible(
                            child: Text(
                              num,
                              style: TextStyle(
                                  fontFamily: "",
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 2),
                    child: Container(
                      child: Row(
                        children: [
                          Text(
                            "NAME:",
                            style: TextStyle(
                                fontFamily: "",
                                fontWeight: FontWeight.bold,
                                fontSize: 12),
                          ),
                          Flexible(
                            child: Text(
                              name,
                              style: TextStyle(
                                  fontFamily: "",
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 2),
                    child: Container(
                      child: Row(
                        children: [
                          Text(
                            "STOCK:",
                            style: TextStyle(
                                fontFamily: "",
                                fontWeight: FontWeight.bold,
                                fontSize: 12),
                          ),
                          Flexible(
                            child: Text(
                              stock,
                              style: TextStyle(
                                  fontFamily: "",
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          PageTransition(
                              child: RequestToolPage(),
                              type: PageTransitionType.slideInUp,
                              duration: Duration(milliseconds: 500)));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 30,
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.black,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 10),
                              child: Text("SELECT",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: "",
                                      fontSize: 12,
                                      fontWeight: FontWeight.w900)),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Icon(
                                Icons.arrow_right_alt,
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
