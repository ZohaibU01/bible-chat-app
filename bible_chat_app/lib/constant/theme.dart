import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

class ThemeHelper extends GetxController {
  RxBool isDarkTheme = false.obs;

  static const colortoast = Color.fromRGBO(88, 156, 253, 1);
  static const colortoasttext = Color.fromARGB(255, 212, 164, 164);

  final colorPrimary = HexColor('#038CFC');
  final colorPrimaryyellow = HexColor('#FFF021');

  final colorPrimaryBlue = Color(0xff107fda);
  final colorPrimarywhite = Colors.white;
  final colorSecondaryBlue = Color(0xff004E92);
  final colorPrimaryDarkBlue = HexColor('#141C6B');
  final colorNavyBlue = HexColor('#161936');
  final greenheadingColor = HexColor('#14ae5c');

  final colorDarkSecondaryBlue = Color.fromARGB(255, 9, 10, 16);
  final colorLightSecondaryBlue = Color(0xff444989);

  final bottomiconcolor = const Color.fromARGB(255, 212, 212, 212);
  final bordercolor = Color.fromARGB(255, 231, 231, 231);
  final textfiledecolor = Color.fromARGB(255, 255, 255, 255);
  final textcolor = const Color(0xff101828);
  final backgoundcolor = Color.fromARGB(255, 255, 255, 255);
  final bgcolor = HexColor('#101010');
  final ContainerColor = HexColor('#1D1D1D');
  final bottomNevcolor = HexColor('#000000');
  final colorwhite = const Color(0xffffffff);

  final screenGradient = LinearGradient(
    colors: [
      Color(0xff7ab4ff),
      Color(0xff107fda),
      Color(0xff080b3a),
      Color(0xff000000)
    ],
    stops: [0, 0.3, 1, 1],
    begin: Alignment.bottomRight,
    end: Alignment.topLeft,
  );

  final yellowGradient = LinearGradient(
    colors: [Color(0xfffff021), Color(0xffffefd0)],
    stops: [0, 1],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  final btnGradient = LinearGradient(
    colors: [Color(0xff3ea8ff), Color(0xff76c1ff)],
    stops: [0, 1],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  // LinearGradient(
  //   colors: [Color(0xff80aff9), Color(0xffa8b6f5), Color(0xffaed1f9)],
  //   stops: [0, 0.5, 1],
  //   begin: Alignment.centerLeft,
  //   end: Alignment.centerRight,
  // );

  final backgroundGradient = const LinearGradient(
    colors: [
      Color.fromARGB(255, 248, 94, 86),
      Color.fromARGB(255, 242, 96, 89),

      Color.fromARGB(255, 243, 100, 95),
      Color.fromARGB(255, 248, 105, 110),
      // Color.fromARGB(255, 250, 103, 96),
      // Color.fromARGB(255, 255, 123, 116),
      // Color(0xFFf7746c),
      // Color.fromARGB(255, 250, 125, 119),
    ],
    stops: [
      0.5,
      0.4,
      0.6,
      0.9,
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  SystemUiOverlayStyle get systemUiOverlayStylesplash => SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.black,
        statusBarBrightness:
            isDarkTheme.value ? Brightness.dark : Brightness.light,
        statusBarIconBrightness:
            isDarkTheme.value ? Brightness.dark : Brightness.light,
        systemNavigationBarIconBrightness:
            isDarkTheme.value ? Brightness.dark : Brightness.light,
      );

  SystemUiOverlayStyle get systemUiOverlayStyleForwelcomeScreen =>
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: HexColor('#3498DB'),
        statusBarBrightness:
            isDarkTheme.value ? Brightness.dark : Brightness.light,
        statusBarIconBrightness:
            isDarkTheme.value ? Brightness.light : Brightness.dark,
        systemNavigationBarIconBrightness:
            isDarkTheme.value ? Brightness.dark : Brightness.light,
      );

  SystemUiOverlayStyle get systemUiOverlayStyleForbibleScreen =>
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: HexColor('#000428'),
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarIconBrightness: Brightness.light,
      );

  SystemUiOverlayStyle get systemUiOverlayStyleForhome => SystemUiOverlayStyle(
        statusBarColor: HexColor('#101010'),
        systemNavigationBarColor: HexColor('#000000'),
        statusBarBrightness:
            isDarkTheme.value ? Brightness.dark : Brightness.light,
        statusBarIconBrightness:
            isDarkTheme.value ? Brightness.dark : Brightness.light,
        systemNavigationBarIconBrightness:
            isDarkTheme.value ? Brightness.dark : Brightness.light,
      );

  SystemUiOverlayStyle get systemUiOverlayStyleForChat => SystemUiOverlayStyle(
        statusBarColor: HexColor('#1D1D1D'),
        systemNavigationBarColor: HexColor('#1D1D1D'),
        statusBarBrightness:
            isDarkTheme.value ? Brightness.dark : Brightness.light,
        statusBarIconBrightness:
            isDarkTheme.value ? Brightness.dark : Brightness.light,
        systemNavigationBarIconBrightness:
            isDarkTheme.value ? Brightness.dark : Brightness.light,
      );

  TextStyle customTextStyle({
    required double fontSize,
    required double letterSpacingPercent,
    Color color = Colors.black,
    FontWeight fontWeight = FontWeight.normal,
  }) {
    return TextStyle(
      fontSize: fontSize,
      letterSpacing: fontSize * (letterSpacingPercent / 100), // Dynamic spacing
      color: color,
      fontWeight: fontWeight,
    );
  }
}
