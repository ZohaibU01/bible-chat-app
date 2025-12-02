import 'package:bible_chat_app/MVC/view/home/bibleSpeechScreen.dart';
import 'package:bible_chat_app/MVC/view/home/chatScreen.dart';
import 'package:bible_chat_app/MVC/view/home/homeScreen.dart';
import 'package:bible_chat_app/MVC/view/prayer/prayer_tab_screen.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constant/theme.dart';

class BottomNavBar extends StatefulWidget {
  final int? initialIndex;
  BottomNavBar({this.initialIndex});
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _currentIndex = 1;

  @override
  void initState() {
    super.initState();
    setState(() {
      _currentIndex = widget.initialIndex ?? _currentIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeHelper>(
        builder: (themeController) => AnnotatedRegion(
              value: themeController.systemUiOverlayStyleForhome,
              child: Scaffold(
                extendBody: true,
                // appBar: _currentIndex != 0
                //     ? CustomAppBar(
                //         Title: _PageTitle(_currentIndex), showShop: false)
                //     : null,
                // drawer: AppDrawer(),
                body: _buildPage(_currentIndex),
                bottomNavigationBar: Container(
                    decoration: BoxDecoration(
                      color: themeController.bottomNevcolor,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          offset: const Offset(0, 5),
                          blurRadius: 10,
                          spreadRadius: 0,
                        ),
                      ],
                      // borderRadius: BorderRadius.only(
                      //     topRight: Radius.circular(30),
                      //     topLeft: Radius.circular(30)),
                    ),
                    child: Material(
                      elevation: 0.0,
                      color: themeController.bottomNevcolor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0)),
                      child: BottomNavigationBar(
                        elevation: 0,
                        backgroundColor: Colors.transparent,
                        currentIndex: _currentIndex,
                        selectedIconTheme: IconThemeData(
                            color: themeController.colorPrimaryyellow),
                        unselectedIconTheme: IconThemeData(
                          color: themeController.bottomiconcolor,
                        ),
                        selectedItemColor: themeController.bottomiconcolor,
                        unselectedItemColor: themeController.bottomiconcolor,
                        selectedLabelStyle: TextStyle(
                            color: themeController.bottomiconcolor,
                            fontWeight: FontWeight.w600,
                            fontSize: 12.sp),
                        unselectedLabelStyle: TextStyle(
                            color: themeController.bottomiconcolor,
                            fontWeight: FontWeight.w500,
                            fontSize: 10.sp),
                        onTap: (index) {
                          setState(() {
                            _currentIndex = index;
                          });
                        },
                        type: BottomNavigationBarType.fixed,
                        items: <BottomNavigationBarItem>[
                          BottomNavigationBarItem(
                            icon: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: _currentIndex == 0
                                  ? SvgPicture.asset(
                                      "assets/icons/chat.svg",
                                      height: 17.sp,
                                      width: 17.sp,
                                      color: themeController.colorPrimaryyellow,
                                    )
                                  : SvgPicture.asset(
                                      "assets/icons/chat.svg",
                                      height: 15.sp,
                                      width: 15.sp,
                                      color: themeController.bottomiconcolor,
                                    ),
                            ),
                            label: 'Chat'.tr,
                          ),
                          BottomNavigationBarItem(
                            icon: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: _currentIndex == 1
                                  ? SvgPicture.asset(
                                      "assets/icons/home.svg",
                                      height: 17.sp,
                                      width: 17.sp,
                                      color: themeController.colorPrimaryyellow,
                                    )
                                  : SvgPicture.asset(
                                      "assets/icons/home.svg",
                                      height: 15.sp,
                                      width: 15.sp,
                                      color: themeController.bottomiconcolor,
                                    ),
                            ),
                            label: 'Home'.tr,
                          ),
                          BottomNavigationBarItem(
                            icon: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: _currentIndex == 2
                                  ? SvgPicture.asset(
                                      "assets/icons/prayer_tab_icon.svg",
                                      height: 17.sp,
                                      width: 17.sp,
                                      color: themeController.colorPrimaryyellow,
                                    )
                                  : SvgPicture.asset(
                                      "assets/icons/prayer_tab_icon.svg",
                                      height: 15.sp,
                                      width: 15.sp,
                                      color: themeController.bottomiconcolor,
                                    ),
                            ),
                            label: 'Prayer'.tr,
                          ),
                          BottomNavigationBarItem(
                            icon: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: _currentIndex == 3
                                  ? SvgPicture.asset(
                                      "assets/icons/bible.svg",
                                      height: 17.sp,
                                      width: 17.sp,
                                      color: themeController.colorPrimaryyellow,
                                    )
                                  : SvgPicture.asset(
                                      "assets/icons/bible.svg",
                                      height: 15.sp,
                                      width: 15.sp,

                                      color: themeController.bottomiconcolor,
                                      // color: Theme.of(context).disabledColor,
                                    ),
                            ),
                            label: 'Bible'.tr,
                          ),
                        ],
                      ),
                    )),
              ),
            ));
  }

  Widget _buildPage(int index) {
    switch (index) {
      case 0:
      return Chatscreen();
        
      case 1:
        return Homescreen();

      case 2:
        return PrayerTabScreen();
      case 3:
        return Biblespeechscreen();
      default:
        return Homescreen();
    }
  }
}
