import 'package:bible_chat_app/MVC/controller/onboardingController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:bible_chat_app/components/small_loader.dart';
import 'package:bible_chat_app/components/spring_widget.dart';
import 'package:bible_chat_app/constant/constants.dart';
import 'package:bible_chat_app/constant/theme.dart';
import 'package:bible_chat_app/helper/getx_helper.dart';
import 'package:get/get.dart';

import '../MVC/controller/loginController.dart';

class Denominationbottomsheet extends StatelessWidget {
  Denominationbottomsheet({
    Key? key,
  }) : super(key: key);
  @override
  static Future show(BuildContext context) {
    final themecontroller = Get.put(ThemeHelper());

    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: themecontroller.bgcolor,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50), topRight: Radius.circular(50))),
      builder: (context) {
        return Denominationbottomsheet();
      },
    );
  }

  final loginController = Get.put(Logincontroller());
  final onboardingcontroller = Get.put(Onboardingcontroller());
  final controllersProvider = Get.put(GetxControllersProvider());
  Widget build(BuildContext context) {
    return GetBuilder<ThemeHelper>(builder: (themecontroller) {
      return AnnotatedRegion(
        value: themecontroller.systemUiOverlayStyleForwelcomeScreen,
        child: Container(
          height: MediaQuery.of(context).size.height * 0.80,
          decoration: BoxDecoration(
              // gradient: themecontroller.containerGradient,
              color: themecontroller.ContainerColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50), topRight: Radius.circular(50))),
          padding: const EdgeInsets.symmetric(
            vertical: 6,
            horizontal: 6,
          ),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: Constants.screenPadding,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const TextButton(
                      onPressed: null,
                      child: SizedBox(),
                    ),
                    Text(
                      "Select Denomination",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(right: 30),
                          child: Icon(
                            Icons.close,
                            color: Colors.white,
                          ),
                        ))
                  ],
                ),
                const SizedBox(height: 10),
                Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: Constants.screenPadding),
                    child: Column(
                      children: onboardingcontroller.questions
                          .firstWhere(
                            (e) => e.id == 1,
                          )
                          .options!
                          .asMap()
                          .entries
                          .map((entry) {
                        int index = entry.key;
                        var e = entry.value;

                        return TweenAnimationBuilder(
                          duration: Duration(
                              milliseconds:
                                  300 + (index * 100)), // Staggered delay
                          tween: Tween<Offset>(
                              begin: Offset(1.5, 0), end: Offset(0, 0)),
                          curve: Curves.easeOut,
                          builder: (context, Offset offset, child) {
                            return Transform.translate(
                              offset: offset *
                                  MediaQuery.of(context)
                                      .size
                                      .width, // Apply translation
                              child: SpringWidget(
                                onTap: () {
                                  onboardingcontroller
                                      .Selected_denomination.value = e.id;
                                  loginController.UserDenominationController
                                      .value.text = e.optionText;
                                  Get.back();
                                },
                                child: Obx(
                                  () => AnimatedContainer(
                                    duration: Duration(milliseconds: 400),
                                    height: 60.sp,
                                    width: double.infinity,
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 20.sp, vertical: 5.sp),
                                    decoration: BoxDecoration(
                                      color: onboardingcontroller
                                                  .Selected_denomination
                                                  .value ==
                                              e.id
                                          ? Colors.white
                                          : Colors.white.withValues(alpha: 0.1),
                                      borderRadius:
                                          BorderRadius.circular(16.sp),
                                    ),
                                    child: Center(
                                      child: Text(
                                        e.optionText,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: onboardingcontroller
                                                      .Selected_denomination
                                                      .value ==
                                                  e.id
                                              ? Colors.black
                                              : Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14.sp,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      }).toList(),
                    ))
              ],
            ),
          ),
        ),
      );
    });
  }
}
