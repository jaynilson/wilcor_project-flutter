import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_page_transition/flutter_page_transition.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';
import 'package:wilcoerp/constants/colors.dart';
import 'package:wilcoerp/constants/globals.dart';
import 'package:wilcoerp/helpers/helpers.dart';
import 'package:wilcoerp/models/fleet.dart';
import 'package:wilcoerp/models/tools.dart';
import 'package:wilcoerp/pages/checks_trailer_page.dart';
import 'package:wilcoerp/pages/checks_truck_page.dart';
import 'package:wilcoerp/pages/odometer_reading_page.dart';
import 'package:wilcoerp/providers/app.dart';
import 'package:wilcoerp/services/web_service.dart';

class SelectToolsPage extends StatefulWidget {
  Widget afterPage;
  String type;
  SelectToolsPage(this.afterPage, this.type, {super.key});

  @override
  State<SelectToolsPage> createState() => _SelectToolsPageState();
}

class _SelectToolsPageState extends State<SelectToolsPage> {
  final cSearch = TextEditingController();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();
  var _controllerScroll = ScrollController();

  num limit = 8;
  bool noMore = false;
  bool loading = false;
  bool showClean = false;
  List<ToolModel> tools = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _refreshIndicatorKey.currentState!.show();
    });

    _controllerScroll.addListener(() {
      if (_controllerScroll.position.atEdge) {
        if (_controllerScroll.position.pixels == 0) {
        } else {
          setState(() {
            loading = true;
          });

          loadMore();
        }
      }
    });
  }

  void dispose() {
    super.dispose();
    _controllerScroll.dispose();
  }

  Future<Null> loadMore() {
    setState(() {
      loading = true;
    });

    final provider = Provider.of<AppProvider>(context, listen: false);
    return WebService(context)
        .getTools(limit, tools.length, widget.type, context,
            provider.user.token ?? "",
            search: cSearch.text)
        .then((value) {
      if (value.length > 0) {
        if (mounted)
          setState(() {
            tools.addAll(value);
            noMore = false;
          });
      } else {
        noMore = true;
        print("entre a no hay más");
      }

      Timer(Duration(seconds: 1), () {
        WidgetsBinding.instance?.addPostFrameCallback((_) async {
          if (mounted)
            setState(() {
              loading = false;
            });
        });
      });
    }).catchError((e) {
      Timer(Duration(seconds: 1), () {
        if (mounted)
          setState(() {
            loading = false;
          });
      });
      showErrorsDialog(context, e);
    });
  }

  Future<Null> load() {
    final provider = Provider.of<AppProvider>(context, listen: false);
    print("TOKEN");
    print(provider.user.token);
    return WebService(context)
        .getTools(limit, 0, widget.type, context, provider.user.token ?? "",
            search: cSearch.text)
        .then((value) {
      if (mounted)
        setState(() {
          tools = value;
        });
    }).catchError((e) {
      showErrorsDialog(context, e);
    });
  }

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
            load();
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
        load();
      },
    );

    List<Widget> progressWidgets = tools.asMap().entries.map((tool) {
      ToolModel tmp = tool.value;
      return Visibility(
        visible: true,
        child: InkWell(
          onTap: () {
            _scrollDown();
          },
          child: getItemTemplate(tmp.n ?? "", tmp.title ?? "",
              tmp.stock.toString(), tmp.picture ?? "", tmp),
        ),
      );
    }).toList();

    progressWidgets.add(Visibility(
      visible: loading,
      child: Container(
        width: 30,
        height: 30,
        child: Align(
          alignment: Alignment.center,
          child: Container(
            height: 20,
            width: 20,
            child: CircularProgressIndicator(
                valueColor:
                    AlwaysStoppedAnimation<Color>(CustomColors.primary)),
          ),
        ),
      ),
    ));

    if (noMore) {
      progressWidgets.add(Visibility(
          visible: !loading,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Container(
                  height: 30,
                  child: Text(
                    "There are no more items to show.",
                    textAlign: TextAlign.center,
                  )),
            ),
          )));
    }

    return Scaffold(
        extendBody: true,
        appBar: getAppBar(context),
        body: Stack(
          children: [
            Positioned.fill(
                top: MediaQuery.of(context).padding.top + 40,
                child: RefreshIndicator(
                    color: CustomColors.primary,
                    key: _refreshIndicatorKey,
                    displacement: MediaQuery.of(context).size.height * .40,
                    onRefresh: load,
                    child: SingleChildScrollView(
                      controller: _controllerScroll,
                      physics: const BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics()),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            constraints: BoxConstraints(
                                minHeight: MediaQuery.of(context).size.height,
                                maxHeight: double.infinity),
                            child: (tools.length <= 0)
                                ? Center(
                                    child: Padding(
                                    padding: const EdgeInsets.all(30.0),
                                    child: Column(
                                      children: [
                                        Text(
                                          "There are no items to show",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 18),
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                  ))
                                : Align(
                                    alignment: Alignment.topCenter,
                                    child: Container(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10.0),
                                        child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            children: progressWidgets),
                                      ),
                                    ),
                                  ),
                          ),
                        ],
                      ),
                    ))),
            Positioned(
                left: 0,
                top: MediaQuery.of(context).padding.top - 20,
                height: 60,
                width: MediaQuery.of(context).size.width,
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
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
                                try {
                                  cSearch.text = res;
                                  load();
                                } catch (e) {}
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
                  ),
                ))
          ],
        ));
  }

  void _scrollDown() {
    _controllerScroll.animateTo(
      _controllerScroll.position.maxScrollExtent,
      duration: Duration(microseconds: 0),
      curve: Curves.fastOutSlowIn,
    );
  }

  Widget getItemTemplate(
      String num, String name, String stock, String picture, ToolModel tool) {
    return Card(
      color: Color.fromARGB(255, 233, 233, 233),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
        child: Row(
          children: [
            FadeInImage.assetNetwork(
              placeholder: "assets/images/loading-image1.gif",
              imageErrorBuilder: (context, error, stackTrace) {
                return Container();
              },
              image: imagesUrlTool + picture,
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
                      checkout_tool_selected = tool;
                      Navigator.push(
                          context,
                          PageTransition(
                              child: widget.afterPage,
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
                                      fontWeight: FontWeight.normal)),
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
