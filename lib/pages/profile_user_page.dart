import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_page_transition/flutter_page_transition.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:snack/snack.dart';

import 'package:wilcoerp/components/select_picture_dialog_wec.dart';
import 'package:wilcoerp/constants/colors.dart';
import 'package:wilcoerp/helpers/helpers.dart';
import 'package:wilcoerp/models/asset.dart';
import 'package:wilcoerp/models/user.dart';
import 'package:wilcoerp/providers/app.dart';
import 'package:wilcoerp/services/web_service.dart';

class ProfileUserPage extends StatefulWidget {
  const ProfileUserPage({Key? key}) : super(key: key);

  @override
  _ProfileUserPageState createState() => _ProfileUserPageState();
}

class _ProfileUserPageState extends State<ProfileUserPage> {
  final cEmail = TextEditingController();
  final cName = TextEditingController();
  final cLastName = TextEditingController();
  final cTel = TextEditingController();
  final cAddress = TextEditingController();

  final formKey = new GlobalKey<FormState>();
  late String citySelected;

  dynamic imageSelected = null;
  dynamic birdate = null;

  @override
  void initState() {
    super.initState();
    final provider = Provider.of<AppProvider>(context, listen: false);
    cEmail.text = provider.user.email ?? "";
    cName.text = formatFirstUpper(provider.user.name ?? "");
    cLastName.text = formatFirstUpper(provider.user.last_name ?? "");
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppProvider>(context, listen: true);
    cEmail.text = provider.user.email ?? "";
    cTel.text = provider.user.tel ?? "";
    cName.text = formatFirstUpper(provider.user.name ?? "");
    cLastName.text = formatFirstUpper(provider.user.last_name ?? "");
    UserModel user = provider.user;

    final nameField = TextFormField(
      autofocus: false,
      autocorrect: false,
      controller: cName,
      keyboardType: TextInputType.text,
      validator: (val) {
        return validateAny(val ?? "", context);
      },
      obscureText: false,
      style: TextStyle(fontSize: 18.0),
      //initialValue: Environment.localUsername(),
      decoration: InputDecoration(
        labelText: 'Name',
        labelStyle: TextStyle(color: Colors.grey),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: CustomColors.primary),
        ),
        border: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
      ),
    );

    final lastNameField = TextFormField(
      autofocus: false,
      autocorrect: false,
      controller: cLastName,
      keyboardType: TextInputType.text,
      validator: (val) {
        return validateAny(val ?? "", context);
      },
      obscureText: false,
      style: TextStyle(fontSize: 18.0),
      //initialValue: Environment.localUsername(),
      decoration: InputDecoration(
        labelText: 'Last name',
        labelStyle: TextStyle(color: Colors.grey),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: CustomColors.primary),
        ),
        border: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
      ),
    );

    final addressField = TextFormField(
      autofocus: false,
      autocorrect: false,
      controller: cAddress,
      keyboardType: TextInputType.text,
      validator: (val) {
        return validateAny(val ?? "", context);
      },
      obscureText: false,
      style: TextStyle(fontSize: 18.0),
      //initialValue: Environment.localUsername(),
      decoration: InputDecoration(
        labelText: 'Address',
        labelStyle: TextStyle(color: Colors.grey),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: CustomColors.primary),
        ),
        border: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
      ),
    );

    final emailField = TextFormField(
      autofocus: false,
      autocorrect: false,
      controller: cEmail,
      keyboardType: TextInputType.emailAddress,
      validator: (val) {
        return validateEmail(val ?? "", context);
      },
      obscureText: false,
      style: TextStyle(fontSize: 18.0),
      //initialValue: Environment.localUsername(),
      decoration: InputDecoration(
        labelText: 'Email',
        labelStyle: TextStyle(color: Colors.grey),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: CustomColors.primary),
        ),
        border: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
      ),
    );

    final telField = TextFormField(
      autofocus: false,
      autocorrect: false,
      controller: cTel,
      keyboardType: TextInputType.phone,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly
      ],
      maxLength: 15,
      validator: (val) {
        return validateAny(val ?? "", context);
      },
      obscureText: false,
      style: TextStyle(fontSize: 18.0),
      //initialValue: Environment.localUsername(),
      decoration: InputDecoration(
        labelText: 'Phone',
        labelStyle: TextStyle(color: Colors.grey),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: CustomColors.primary),
        ),
        border: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: CustomColors.primary, //change your color here
        ),
        title: Text("Editar"),
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
        actions: [
          InkWell(
            onTap: () {
              logout(context);
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: Icon(Icons.logout_outlined, color: CustomColors.primary),
            ),
          )
        ],
      ),
      body: Form(
        key: formKey,
        child: ListView(
          children: [
            Center(
              child: Container(
                constraints:
                    kIsWeb ? BoxConstraints(maxWidth: 600) : BoxConstraints(),
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 35.0,
                    right: 35.0,
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 50,
                      ),
                      Container(
                        width: 160,
                        height: 160,
                        child: Stack(
                          children: [
                            Positioned.fill(
                              child: Visibility(
                                visible: imageSelected == null,
                                child: Container(
                                  height: 160,
                                  width: 160,
                                  decoration: new BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius: new BorderRadius.all(
                                        Radius.circular(10.0)),
                                  ),
                                  child: (user.picture != null &&
                                          user.picture != "")
                                      ? ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          child: FadeInImage.assetNetwork(
                                            placeholder:
                                                "assets/images/loading-image1.gif",
                                            image: getImageUrl(user.picture!),
                                            fit: BoxFit.cover,
                                          ),
                                        )
                                      : Container(
                                          decoration: new BoxDecoration(
                                              color: Colors.transparent,
                                              borderRadius:
                                                  new BorderRadius.all(
                                                      Radius.circular(45.0))),
                                          child: Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Image.asset(
                                              "assets/images/avatar.png",
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                ),
                              ),
                            ),
                            Positioned.fill(
                                child: (imageSelected != null)
                                    ? Container(
                                        width: 160,
                                        height: 160,
                                        decoration: BoxDecoration(
                                          borderRadius: new BorderRadius.all(
                                              Radius.circular(10.0)),
                                          image: (imageSelected is Uint8List)
                                              ? DecorationImage(
                                                  image: MemoryImage(
                                                      imageSelected),
                                                  fit: BoxFit.cover,
                                                )
                                              : DecorationImage(
                                                  image:
                                                      FileImage(imageSelected)),
                                        ),
                                      )
                                    : Container()),
                            Positioned.fill(
                                child: InkWell(
                              onTap: () {
                                showTakePicture();
                              },
                              child: Container(
                                width: 160,
                                height: 160,
                                decoration: new BoxDecoration(
                                    color: (imageSelected != null)
                                        ? Colors.transparent
                                        : Colors.black.withAlpha(80),
                                    borderRadius: new BorderRadius.all(
                                        Radius.circular(10.0))),
                                child: Align(
                                  alignment: Alignment.bottomRight,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(
                                      FontAwesomeIcons.camera,
                                      color: Colors.white,
                                      size: 25,
                                    ),
                                  ),
                                ),
                              ),
                            ))
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: nameField,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: lastNameField,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: emailField,
                      ),

                      //----------------------------new

                      //new
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15.0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              elevation: 2,
                              primary: CustomColors.primary,
                              shape: StadiumBorder()),
                          onPressed: () {
                            processUpdate();
                          },
                          child: Container(
                            width: double.infinity,
                            height: 35.0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Save",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15.0),
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

  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.blue;
    }
    return CustomColors.primary;
  }

  showTakePicture() async {
    await showDialog(
        context: context,
        builder: (contextDialog) {
          return SelectPictureDialogWec(
            "Select image",
            (contextDialogd, image) {
              Navigator.pop(contextDialog);
              callbackShowTakePicture(contextDialogd, image);
            },
            useBtnCancel: true,
          );
        });
  }

  Future callbackShowTakePicture(contextDialog, image) async {
    if (image == null) return;
    try {
      final XFile? imageFile = await ImagePicker().pickImage(
          source:
              (image == "camera") ? ImageSource.camera : ImageSource.gallery);
      if (imageFile != null) {
        File file = await File(imageFile.path);
        setState(() {
          this.imageSelected = file;
        });
      }
      Navigator.pop(contextDialog);
    } catch (e) {
      Navigator.pop(contextDialog);
    }
  }

  processUpdate() async {
    final form = formKey.currentState;

    if (form!.validate()) {
      form.save();

      simpleLoading(context, (BuildContext loadingContext) {
        final provider = Provider.of<AppProvider>(context, listen: false);
        WebService(context)
            .updateProfileEmployee(
                provider.user.id.toString(),
                cName.text,
                cLastName.text,
                cEmail.text,
                imageSelected,
                provider.user.token ?? "")
            .then((data) async {
          Navigator.pop(loadingContext);
          provider.setUser(data);
          SnackBar(
                  content: Text("Se ha guardado con éxito",
                      style: TextStyle(
                        color: Colors.white,
                      )),
                  elevation: 100,
                  duration: Duration(seconds: 2),
                  backgroundColor: CustomColors.primary)
              .show(context);
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
