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
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.purple)),
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.purple)),
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.purple)),
        errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.purple)),
        focusedErrorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.purple)),
      ),
    );
