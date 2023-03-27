import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Themes {
  final appDataTheme = ThemeData.light().copyWith(
    primaryColor: Colors.black,
    primaryColorLight: Colors.black,
    appBarTheme: AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      toolbarTextStyle: const TextTheme(
        headline2: TextStyle(
          color: Colors.black,
        ),
      ).bodyText2,
      titleTextStyle: const TextTheme(
        headline2: TextStyle(
          color: Colors.black,
        ),
      ).headline6,
    ),
    buttonColor: Colors.black,
  );

  final darkTheme = ThemeData.dark().copyWith(
      primaryColor: Colors.white,
      appBarTheme: AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle.light,
        toolbarTextStyle: const TextTheme(
          headline2: TextStyle(
            color: Colors.black,
          ),
        ).bodyText2,
        titleTextStyle: const TextTheme(
          headline2: TextStyle(
            color: Colors.black,
          ),
        ).headline6,
      ));
}
