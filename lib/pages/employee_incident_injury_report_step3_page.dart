import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_page_transition/flutter_page_transition.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wilcoerp/components/bottom_sheet_pictures.dart';
import 'package:wilcoerp/components/select_picture_dialog_wec.dart';
import 'package:wilcoerp/constants/colors.dart';
import 'package:wilcoerp/constants/globals.dart';
import 'package:wilcoerp/helpers/helpers.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:wilcoerp/pages/done_page.dart';
import 'package:wilcoerp/pages/employee_incident_injury_report_step4_page.dart';
import 'package:wilcoerp/pages/home_page.dart';

class EmployeeIncidentInjuryReportStep3Page extends StatefulWidget {
  const EmployeeIncidentInjuryReportStep3Page({super.key});

  @override
  State<EmployeeIncidentInjuryReportStep3Page> createState() =>
      _EmployeeIncidentInjuryReportStep3PageState();
}

class _EmployeeIncidentInjuryReportStep3PageState
    extends State<EmployeeIncidentInjuryReportStep3Page> {
  final cDescription = TextEditingController();
  final formKey = new GlobalKey<FormState>();
  List<dynamic> pictureFiles = [];
  CarouselController buttonCarouselController = CarouselController();
  int currentImage = 0;
  PageController _pageController = PageController(initialPage: 0);
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
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        FontAwesomeIcons.camera,
                        color: CustomColors.primary,
                        size: 130,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 35.0),
                        child: Text(
                          "UPLOAD PHOTOS",
                          style: TextStyle(
                              color: CustomColors.primary,
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        ),
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
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              elevation: 2,
                              primary: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              )),
                          onPressed: () {
                            next();
                          },
                          child: Container(
                            width: double.infinity,
                            height: 50.0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "NEXT",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18.0,
                                    ),
                                    textAlign: TextAlign.center,
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

  next() async {
    report_employee_incident.add(
        {"question_text": "", "content": pictureFiles, "type": "pictures"});

    Navigator.push(
        context,
        PageTransition(
            child: EmployeeIncidentInjuryReportStep4Page(),
            type: PageTransitionType.slideInUp,
            duration: Duration(milliseconds: 500)));
  }
}
