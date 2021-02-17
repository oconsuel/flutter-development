import 'package:flutter/material.dart';
import 'package:lab_1/utils/constants.dart';

ThemeData basicTheme() => ThemeData(
    brightness: Brightness.dark,
    primaryColor: myFirstColor,
    textTheme: TextTheme(
      headline6: TextStyle(
        fontFamily: FontNameTitle,
        fontSize: MediumTextSize,
        color: Colors.purple,
      ),
      bodyText1: TextStyle(
        fontFamily: FontNameDefault,
        fontSize: BodyTextSize,
        color: Colors.green,
      ),
    ));
