import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_page_transition/flutter_page_transition.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:wilcoerp/components/big_button_menus.dart';
import 'package:wilcoerp/components/bottom_sheet_pictures.dart';
import 'package:wilcoerp/components/select_picture_dialog_wec.dart';
import 'package:wilcoerp/constants/colors.dart';
import 'package:wilcoerp/constants/globals.dart';
import 'package:wilcoerp/helpers/helpers.dart';
import 'package:wilcoerp/models/failure_report.dart';
import 'package:wilcoerp/models/fleet.dart';
import 'package:wilcoerp/pages/auto_incident_step3_page.dart';
import 'package:wilcoerp/pages/auto_incident_step6_page.dart';
import 'package:wilcoerp/pages/select_trucks_cars_page.dart';
import 'package:wilcoerp/pages/utility_damage_step6_page.dart';
import 'package:wilcoerp/providers/app.dart';
import 'package:wilcoerp/services/web_service.dart';

class AlertFleetPage extends StatefulWidget {
  Function submitFailureReport;
  Function continueProcess;
  bool isCheckin;
  AlertFleetPage(this.submitFailureReport, this.continueProcess, this.isCheckin,
      {super.key});

  @override
  State<AlertFleetPage> createState() => _AlertFleetPageState();
}

class _AlertFleetPageState extends State<AlertFleetPage> {
  final cFailureDescription = TextEditingController();

  String photosTaken = "";
  String injuryToEitherParty = "";
  String didMedicsArrive = "";

  final cTime = TextEditingController();

  final formKey = new GlobalKey<FormState>();

  List<dynamic> pictureFiles = [];
  CarouselController buttonCarouselController = CarouselController();
  int currentImage = 0;
  PageController _pageController = PageController(initialPage: 0);

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

    final failureReportDescriptionField = TextFormField(
      autofocus: false,
      textInputAction: TextInputAction.next,
      controller: cFailureDescription,
      keyboardType: TextInputType.multiline,
      maxLines: null,
      expands: true,
      readOnly: false,
      validator: (val) {
        return validateAny(val ?? "", context);
      },
      obscureText: false,
      style: TextStyle(fontSize: 18.0),
      //initialValue: Environment.localUsername(),
      decoration: decorationFields,
      onFieldSubmitted: (val) {},
    );

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
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/borrar.png',
                        width: 100,
                        color: CustomColors.primary,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 18.0),
                        child: Text(
                          "ALERT!",
                          style: TextStyle(
                              color: CustomColors.primary, fontSize: 25),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      (pictureFiles.length > 0)
                          ? Card(
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          showTakePicture();
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            height: 40,
                                            width: 80,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              color: Colors.black,
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      vertical: 8.0,
                                                      horizontal: 10),
                                                  child: Text("Add",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontFamily: "",
                                                          fontSize: 12,
                                                          fontWeight: FontWeight
                                                              .normal)),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 8.0),
                                                  child: Icon(
                                                    Icons.add,
                                                    color: Colors.white,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Visibility(
                                      visible: pictureFiles.length > 0,
                                      child: Text(
                                          "${currentImage + 1}/${pictureFiles.length}")),
                                  Container(
                                    height: MediaQuery.of(context).size.height *
                                        .30,
                                    width: MediaQuery.of(context).size.width,
                                    child: (pictureFiles.length <= 0)
                                        ? Center(
                                            child: InkWell(
                                            onTap: () {
                                              showTakePicture();
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                  "Tap for select photos",
                                                  textAlign: TextAlign.center),
                                            ),
                                          ))
                                        : CarouselSlider(
                                            carouselController:
                                                buttonCarouselController,
                                            items: pictureFiles
                                                .asMap()
                                                .entries
                                                .map((picture) {
                                              return Stack(
                                                children: [
                                                  Positioned.fill(
                                                      child: InkWell(
                                                    onTap: () {
                                                      BottomSheetPictures(
                                                              context,
                                                              picture.key,
                                                              pictureFiles)
                                                          .showBottomSheetPictures();
                                                    },
                                                    child: Image.file(
                                                      picture.value,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  )),
                                                  Positioned(
                                                      left: 2,
                                                      top: 2,
                                                      height: 30,
                                                      width: 30,
                                                      child: InkWell(
                                                        onTap: () {
                                                          setState(() {
                                                            pictureFiles
                                                                .removeAt(
                                                                    picture
                                                                        .key);
                                                          });
                                                        },
                                                        child: CircleAvatar(
                                                          backgroundColor:
                                                              Colors
                                                                  .black
                                                                  .withAlpha(
                                                                      60),
                                                          child: Icon(
                                                            Icons.close,
                                                            color: Colors.white,
                                                            size: 20,
                                                          ),
                                                        ),
                                                      )),
                                                  Positioned(
                                                    width: 20,
                                                    height: 20,
                                                    right: 5,
                                                    top: 5,
                                                    child: InkWell(
                                                        onTap: () {
                                                          BottomSheetPictures(
                                                                  context,
                                                                  picture.key,
                                                                  pictureFiles)
                                                              .showBottomSheetPictures();
                                                        },
                                                        child: Icon(
                                                          FontAwesomeIcons
                                                              .expandAlt,
                                                          color: Colors
                                                              .grey.shade400,
                                                        )),
                                                  )
                                                ],
                                              );
                                            }).toList(),
                                            options: CarouselOptions(
                                                enlargeCenterPage: true,
                                                disableCenter: false,
                                                autoPlay: true,
                                                onPageChanged:
                                                    (int index, rason) {
                                                  setState(() {
                                                    currentImage = index;
                                                  });
                                                }),
                                          ),
                                  ),
                                  /* Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 0, vertical: 8),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        buttonCarouselController.previousPage();
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Icon(
                                          Icons.keyboard_arrow_left,
                                          size: 38,
                                          color: CustomColors.primary,
                                        ),
                                      ),
                                    ),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.min,
                                        children: pictureFiles
                                            .asMap()
                                            .entries
                                            .map((picture) {
                                          return Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 5, vertical: 2),
                                            child: Container(
                                              height: 8.0,
                                              width: 8.0,
                                              decoration: new BoxDecoration(
                                                color: (currentImage ==
                                                        picture.key)
                                                    ? CustomColors.primary
                                                    : Colors.grey,
                                                shape: BoxShape.circle,
                                              ),
                                            ),
                                          );
                                        }).toList()),
                                    InkWell(
                                      onTap: () {
                                        buttonCarouselController.nextPage();
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Icon(
                                          Icons.keyboard_arrow_right,
                                          size: 38,
                                          color: CustomColors.primary,
                                        ),
                                      ),
                                    )
                                  ]),
                            ),*/

                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: InkWell(
                                          onTap: () {
                                            showTakePicture();
                                          },
                                          child: Column(
                                            children: [],
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            )
                          : InkWell(
                              onTap: () {
                                showTakePicture();
                              },
                              child: Container(
                                height: 130,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: Colors.grey.shade300,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 8.0),
                                      child: Icon(
                                        Icons.photo,
                                        color: Colors.grey.shade700,
                                        size: 50,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Text(
                              "DESCRIPTION",
                              style: TextStyle(color: Colors.grey.shade600),
                            ),
                          ),
                          Container(
                              height: 100,
                              width: MediaQuery.of(context).size.width,
                              child: failureReportDescriptionField),
                        ],
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            elevation: 2,
                            primary: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            )),
                        onPressed: () {
                          process();
                        },
                        child: Container(
                          width: double.infinity,
                          height: 55.0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Flexible(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
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
                                            (!widget.isCheckin)
                                                ? "SUBMIT AND SELECT ANOTHER VEHICLE"
                                                : "SUBMIT AND CANCEL CHECK IN",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 13.0,
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
                      SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            elevation: 2,
                            primary: CustomColors.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            )),
                        onPressed: () {
                          widget.continueProcess();
                        },
                        child: Container(
                          width: double.infinity,
                          height: 55.0,
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
                                            "CONTINUE",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 13.0,
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

  showTakePicture() async {
    await showDialog(
        context: context,
        builder: (contextDialog) {
          return SelectPictureDialogWec(
            "Select photos",
            (contextDialog, image) {
              Navigator.pop(contextDialog);
              if (image == "gallery") {
                callbackShowSelectPictures(contextDialog);
              } else {
                callbackShowTakePicture(contextDialog);
              }
            },
            useBtnCancel: true,
          );
        });
  }

  Future callbackShowSelectPictures(contextDialog) async {
    simpleLoading(context, (BuildContext loadingContext) async {
      try {
        final imageFiles = await ImagePicker().pickMultiImage();
        if (imageFiles == null) {
          Navigator.pop(loadingContext);
          return;
        }
        await Future.forEach(imageFiles, (XFile element) async {
          if (element != null) {
            final file = await File(element.path);
            pictureFiles.add(file);
          }
        });
        setState(() {
          pictureFiles = pictureFiles;
        });
        Navigator.pop(loadingContext);
      } catch (e) {
        Navigator.pop(loadingContext);
        print(e);
      }
    });
  }

  Future callbackShowTakePicture(contextDialog) async {
    simpleLoading(context, (BuildContext loadingContext) async {
      try {
        final imageFile =
            await ImagePicker().pickImage(source: ImageSource.camera);
        if (imageFile == null) {
          Navigator.pop(loadingContext);
          return;
        }
        final file = await File(imageFile.path);
        setState(() {
          pictureFiles.add(file);
        });
        Navigator.pop(loadingContext);
      } catch (e) {}
    });
  }

  process() async {
    final form = formKey.currentState;
    if (form!.validate()) {
      simpleLoading(context, (BuildContext loadingContext) {
        final provider = Provider.of<AppProvider>(context, listen: false);

        WebService(context)
            .employeeFailureReportFleetInsert(
          (widget.isCheckin)
              ? provider.checkout!.fleet!.id.toString()
              : (checkout_fleet as FleetModel).id.toString(),
          provider.user.id.toString(),
          "fleet",
          cFailureDescription.text,
          provider.user.token ?? "",
        )
            .then((res) async {
          FailureReportModel failureReportModel = res;

          for (var i = 0; i < pictureFiles.length; i++) {
            await WebService(context).uploadAsset(
                "failure_report",
                failureReportModel.id.toString(),
                pictureFiles[i],
                provider.user.token.toString());
          }

          Navigator.pop(loadingContext);
          widget.submitFailureReport();
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
