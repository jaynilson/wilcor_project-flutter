import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_page_transition/flutter_page_transition.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:record_mp3/record_mp3.dart';
import 'package:voice_message_package/voice_message_package.dart';
import 'package:wilcoerp/constants/colors.dart';
import 'package:wilcoerp/constants/globals.dart';
import 'package:wilcoerp/helpers/helpers.dart';
import 'package:wilcoerp/models/fleet.dart';
import 'package:wilcoerp/pages/upload_photos_report_problem.dart';
import 'package:wilcoerp/providers/app.dart';
import 'package:wilcoerp/services/web_service.dart';

class DescriptionReportProblemPage extends StatefulWidget {
  const DescriptionReportProblemPage({super.key});

  @override
  State<DescriptionReportProblemPage> createState() =>
      _DescriptionReportProblemPageState();
}

class _DescriptionReportProblemPageState
    extends State<DescriptionReportProblemPage> {
  final cDescription = TextEditingController();
  final formKey = new GlobalKey<FormState>();
  bool isPlayingMsg = false, isRecording = false, isSending = false;
  String recordFilePath = "";
  @override
  Widget build(BuildContext context) {
    final descriptionField = TextFormField(
      textAlign: TextAlign.center,
      autofocus: false,
      expands: true,

      maxLines: null,
      textInputAction: TextInputAction.newline,
      controller: cDescription,
      keyboardType: TextInputType.multiline,
      readOnly: false,

      validator: (val) {
        return validateAny(val ?? "", context);
      },
      obscureText: false,
      style: TextStyle(fontSize: 15.0),
      //initialValue: Environment.localUsername(),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
        hintText: "MESSAGE",
        hintStyle: TextStyle(
          color: Color.fromARGB(255, 102, 102, 102),
          fontSize: 14,
        ),
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
      ),
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
                        'assets/images/search.png',
                        width: 180,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 35.0),
                        child: Text(
                          "DESCRIPTION",
                          style: TextStyle(
                              color: CustomColors.primary,
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(height: 100, child: descriptionField),
                      SizedBox(
                        height: 20,
                      ),
                      (isSending && isRecording == false)
                          ? FutureBuilder(
                              future: getFilePath(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<String> snapshot) {
                                if (snapshot.hasData) {
                                  return Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Expanded(
                                        child: Container(
                                          height: 70,
                                          child: VoiceMessage(
                                            audioSrc: snapshot.data,
                                            played:
                                                false, // To show played badge or not.
                                            me: true, // Set message side.
                                            onPlay:
                                                () {}, // Do something when voice played.
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                } else {
                                  return Container();
                                }
                              })
                          : Container(),
                      SizedBox(height: 30),
                      Row(
                        children: [
                          Flexible(
                            flex: 2,
                            child: Container(
                              margin: EdgeInsets.fromLTRB(5, 5, 10, 5),
                              decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                        color: isRecording == false
                                            ? Colors.white
                                            : Colors.black12,
                                        spreadRadius: 15)
                                  ],
                                  color: CustomColors.primary,
                                  shape: BoxShape.circle),
                              child: GestureDetector(
                                onLongPress: () {
                                  startRecord();
                                  setState(() {
                                    isRecording = true;
                                  });
                                },
                                onLongPressEnd: (details) {
                                  stopRecord();
                                  setState(() {
                                    isRecording = false;
                                  });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Container(
                                    width: 100,
                                    height: 50.0,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.mic,
                                          color: Colors.white,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 6,
                            child: Padding(
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
                            ),
                          ),
                        ],
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

  Future _loadFile(String url) async {
    /* final bytes = await readBytes(url);
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/audio.mp3');

    await file.writeAsBytes(bytes);
    if (await file.exists()) {
      setState(() {
        recordFilePath = file.path;
        isPlayingMsg = true;
        print(isPlayingMsg);
      });
      await play();
      setState(() {
        isPlayingMsg = false;
        print(isPlayingMsg);
      });
    }*/
  }

  Future<bool> checkPermission() async {
    if (!await Permission.microphone.isGranted) {
      PermissionStatus status = await Permission.microphone.request();
      if (status != PermissionStatus.granted) {
        return false;
      }
    }
    return true;
  }

  void startRecord() async {
    bool hasPermission = await checkPermission();
    if (hasPermission) {
      recordFilePath = await getFilePath();

      RecordMp3.instance.start(recordFilePath, (type) {
        setState(() {});
      });
    } else {}
    setState(() {});
  }

  void stopRecord() async {
    bool s = RecordMp3.instance.stop();
    if (s) {
      setState(() {
        isSending = true;
      });
      // await uploadAudio();

      setState(() {
        isPlayingMsg = false;
      });
    }
  }

  next() async {
    final form = formKey.currentState;
    if (form!.validate()) {
      form.save();
      global_description = cDescription.text;
      if (recordFilePath != "") {
        global_audio_record = File(recordFilePath);
      } else {
        global_audio_record = null;
      }

      Navigator.push(
          context,
          PageTransition(
              child: UploadPhotosReportProblemPage(),
              type: PageTransitionType.slideInUp,
              duration: Duration(milliseconds: 500)));
    }
  }

  Future<String> getFilePath() async {
    Directory storageDirectory = await getApplicationDocumentsDirectory();
    String sdPath = storageDirectory.path + "/record";
    var d = Directory(sdPath);
    if (!d.existsSync()) {
      d.createSync(recursive: true);
    }
    return sdPath + "/test.mp3";
  }
}
