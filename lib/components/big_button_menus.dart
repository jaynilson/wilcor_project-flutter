import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:wilcoerp/constants/colors.dart';

class BigButtonMenus extends StatelessWidget {
  String image;
  String title;
  Function callback;
  Color customColor;
  BigButtonMenus(this.image, this.title, this.callback,
      {this.customColor = CustomColors.primary, super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          elevation: 2,
          primary: this.customColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          )),
      onPressed: () {
        this.callback();
      },
      child: Container(
        width: double.infinity,
        height: 70.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Flexible(
                flex: 2,
                child: Image.asset(
                  'assets/images/' + this.image,
                  width: 50,
                  color: Colors.white,
                )),
            Flexible(
              flex: 12,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Flexible(
                        child: Text(
                          this.title,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
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
    );
  }
}
