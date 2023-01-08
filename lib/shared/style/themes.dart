import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

ThemeData darkMode = ThemeData(
  inputDecorationTheme: const InputDecorationTheme(
      iconColor: Colors.white, labelStyle: TextStyle(color: Colors.white)),
  textTheme: const TextTheme(
    bodyText2: TextStyle(
      color: Colors.grey,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    ),
    headline3: TextStyle(
      color: Colors.grey,
      fontSize: 22.0,
      fontWeight: FontWeight.bold,
    ),
    headline4: TextStyle(
      color: Colors.pink,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    ),
    subtitle1: TextStyle(
      color: Colors.black,
      fontSize: 14.0,
      fontWeight: FontWeight.bold,
    ),
    headline6: TextStyle(
      color: Colors.grey,
      fontSize: 22.0,
      fontWeight: FontWeight.bold,
    ),
    bodyText1: TextStyle(
      color: Colors.grey,
      fontSize: 25.0,
      fontWeight: FontWeight.bold,
    ),
    headline5: TextStyle(
      color: Colors.pink,
      fontSize: 40.0,
      fontWeight: FontWeight.bold,
    ),
  ),
  scaffoldBackgroundColor: HexColor('333236'),
  primarySwatch: Colors.pink,
  floatingActionButtonTheme:
      const FloatingActionButtonThemeData(backgroundColor: Colors.pink),
  appBarTheme: AppBarTheme(
      titleSpacing: 20.0,
      iconTheme: const IconThemeData(
        color: Colors.pink,
        size: 30.0,
      ),
      titleTextStyle: const TextStyle(
          color: Colors.grey, fontSize: 20.0, fontWeight: FontWeight.bold),
// backwardsCompatibility: false,
      backgroundColor: HexColor('333236'),
      elevation: 0.0,
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: HexColor('333236'),
          statusBarIconBrightness: Brightness.light)),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.pink,
      elevation: 20.0,
      backgroundColor: HexColor('333236'),
      unselectedItemColor: Colors.grey),
  drawerTheme: DrawerThemeData(
    backgroundColor: HexColor('333236')
  ),
);

ThemeData lightTheme = ThemeData(
  fontFamily: 'MyFont',
  textTheme: const TextTheme(
    bodyText1: TextStyle(
      color: Colors.pink,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    ),
    bodyText2: TextStyle(
      color: Colors.black,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    ),
    headline3: TextStyle(
      color: Colors.white,
      fontSize: 22.0,
      fontWeight: FontWeight.bold,
    ),
    headline4: TextStyle(
      color: Colors.pink,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    ),
    subtitle1: TextStyle(
      color: Colors.black,
      fontSize: 14.0,
      fontWeight: FontWeight.bold,
    ),

    headline5: TextStyle(
        color: Colors.pink, fontSize: 40.0, fontWeight: FontWeight.bold),
  ),
  primarySwatch: Colors.pink,
  floatingActionButtonTheme:
      FloatingActionButtonThemeData(backgroundColor: Colors.pink[700]),
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
      titleSpacing: 20.0,
      iconTheme: IconThemeData(
        color: Colors.grey,
        size: 30.0,
      ),
      titleTextStyle: TextStyle(
        color: Colors.pink,
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
      ),
      backgroundColor: Colors.white,
      elevation: 0.0,
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark)),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.pink,
      elevation: 20.0),
);
