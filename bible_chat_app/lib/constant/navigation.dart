import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';

// import '../custom/fullscreen_Imageview.dart';

class Navigation {
  static Navigation? _instance;
  static Navigation get getInstance => _instance ??= Navigation();

  // card_navigation(BuildContext context, Widget childwidget) {
  //   return Navigator.push(
  //     context,
  //     PageTransition(
  //       type: PageTransitionType.bottomToTop,
  //       child: childwidget,
  //       isIos: true,
  //       duration: Duration(milliseconds: 500),
  //       reverseDuration: Duration(milliseconds: 400),
  //     ),
  //   );
  // }

  // RightToLeft_PageNavigation(BuildContext context, Widget childwidget) {
  //   return Navigator.push(
  //     context,
  //     PageTransition(
  //       type: PageTransitionType.rightToLeftWithFade,
  //       child: childwidget,
  //       isIos: false,
  //       duration: Duration(milliseconds: 500),
  //       reverseDuration: Duration(milliseconds: 400),
  //     ),
  //   );
  // }

  screenNavigation(BuildContext context, Widget childwidget) {
    return Navigator.push(
        context,
        Platform.isAndroid
            ? MaterialPageRoute(builder: (context) => childwidget)
            : CupertinoPageRoute(builder: (context) => childwidget));
  }

  RightToLeft_PageNavigation(BuildContext context, Widget childwidget) {
    return Navigator.push(
      context,
      PageTransition(
        type: PageTransitionType.fade,
        child: childwidget,
        isIos: false,
        duration: Duration(milliseconds: 500),
        reverseDuration: Duration(milliseconds: 200),
      ),
    );
  }

bottomToTop_PageNavigation(BuildContext context, Widget childwidget) {
    return Navigator.push(
      context,
      PageTransition(
        type: PageTransitionType.bottomToTop,
        child: childwidget,
        isIos: false,
        duration: Duration(milliseconds: 200),
        reverseDuration: Duration(milliseconds: 200),
      ),
    );
  }


  void pagePushAndReplaceNavigation(BuildContext context, Widget childWidget) {
    if (Platform.isAndroid) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => childWidget,
        ),
        (route) => false,
      );
    } else if (Platform.isIOS) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => childWidget,
        ),
        (route) => false,
      );
    }
  }

  void pagePushAndReplaceNavigationfade(BuildContext context, Widget childWidget) {
    // if (Platform.isIOS) {
    //   Navigator.pushAndRemoveUntil(
    //     context,
    //     CupertinoPageRoute(
    //       builder: (context) => childWidget,
    //     ),
    //     (route) => false,
    //   );
    // } else {
      Navigator.pushAndRemoveUntil(
        context,
        PageTransition(
          type: PageTransitionType.fade,
          child: childWidget,
          isIos: false,
          duration: Duration(milliseconds: 900),
          reverseDuration: Duration(milliseconds: 200),
        ),
        (route) => false,
      );
    }
  // }
}
