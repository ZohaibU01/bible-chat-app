import 'dart:io';

import 'package:bible_chat_app/MVC/controller/loginController.dart';
import 'package:bible_chat_app/MVC/controller/onboardingController.dart';
import 'package:bible_chat_app/components/spring_widget.dart';
import 'package:flutter/material.dart';
import 'package:bible_chat_app/constant/theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class Loginscreen extends StatelessWidget {
  Loginscreen({super.key});

  @override
  final onboardingcontroller = Get.put(Onboardingcontroller());
  final logincontroller = Get.put(Logincontroller());

  Widget build(BuildContext context) {
    return GetBuilder<ThemeHelper>(
        initState: (state) {},
        builder: (themecontroller) {
          return AnnotatedRegion(
            value: themecontroller.systemUiOverlayStylesplash,
            child: Scaffold(
              body: Container(
                  height: double.infinity,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: themecontroller.screenGradient,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(
                        "assets/images/bg.png",
                      ),
                    ),
                  ),
                  padding:
                      EdgeInsets.symmetric(horizontal: 25.sp, vertical: 20.sp),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Hero(
                              tag: 'appicon',
                              child: Container(
                                height: 120.sp,
                                width: 120.sp,
                                decoration: const BoxDecoration(
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: AssetImage(
                                          "assets/images/appicon.png",
                                        ))),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20.sp,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Welcome to",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 27.sp)),
                          ShaderMask(
                            shaderCallback: (bounds) => themecontroller
                                .yellowGradient
                                .createShader(bounds),
                            child: Text(
                              " Genesis!",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 27.sp,
                              ),
                            ),
                          )
                        ],
                      ),
                      // RichText(
                      //     text: TextSpan(children: [
                      //   TextSpan(
                      //       text: 'Welcome to',
                      // style: TextStyle(
                      //     color: Colors.white,
                      //     fontWeight: FontWeight.bold,
                      //     fontSize: 27.sp)),
                      //   TextSpan(
                      //       text: ' Genesis!',
                      //       style: TextStyle(
                      //           color: themecontroller.colorPrimaryyellow,
                      //           fontWeight: FontWeight.bold,
                      //           fontSize: 27.sp))
                      // ])),
                      SizedBox(
                        height: 10.sp,
                      ),
                      Text(
                        'Deepen your faith, one question\nat a time.',
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            overflow: TextOverflow.ellipsis,
                            color: Colors.white,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w100),
                      ),
                      SizedBox(
                        height: 20.sp,
                      ),
                      SpringWidget(
                        onTap: () async {
                          if (Platform.isIOS) {
                            await logincontroller.sign_in_with_apple(context);
                            await onboardingcontroller.getAllQuestions();
                          } else {
                            Fluttertoast.showToast(
                                msg: "This Function is not for Android");
                          }
                        },
                        child: Container(
                            decoration: BoxDecoration(
                                color: themecontroller.colorPrimarywhite,
                                // gradient: themecontroller.btnGradient,
                                borderRadius: BorderRadius.circular(10.sp)),
                            width: double.infinity,
                            alignment: Alignment.center,
                            child: ListTile(
                              titleAlignment: ListTileTitleAlignment.center,
                              title: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 20.sp,
                                  ),
                                  SvgPicture.asset(
                                    "assets/icons/apple.svg",
                                    height: 20.sp,
                                    width: 20.sp,
                                    color: Colors.black,
                                  ),
                                  SizedBox(
                                    width: 10.sp,
                                  ),
                                  Text(
                                    'Continue with Apple',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              trailing: Obx(
                                () => Visibility(
                                  visible:
                                      logincontroller.appleSignLoading.value,
                                  child: SizedBox(
                                      height: 10.sp,
                                      width: 10.sp,
                                      child: CircularProgressIndicator(
                                        color: Colors.black,
                                      )),
                                  replacement: Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    color: Colors.black,
                                    size: 15.sp,
                                  ),
                                ),
                              ),
                            )),
                      ),
                      SizedBox(
                        height: 10.sp,
                      ),
                      SpringWidget(
                        onTap: () async {
                          await logincontroller.signUpWithGoogle(context);
                          await onboardingcontroller.getAllQuestions();
                        },
                        child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: themecontroller.colorPrimarywhite,
                                    width: 2.sp),
                                // color: themecontroller.colorPrimary,
                                // gradient: themecontroller.btnGradient,
                                borderRadius: BorderRadius.circular(10.sp)),
                            width: double.infinity,
                            alignment: Alignment.center,
                            child: ListTile(
                              titleAlignment: ListTileTitleAlignment.center,
                              title: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 20.sp,
                                  ),
                                  SvgPicture.asset(
                                    "assets/icons/google.svg",
                                    color: Colors.white,
                                    height: 20.sp,
                                    width: 20.sp,
                                  ),
                                  SizedBox(
                                    width: 10.sp,
                                  ),
                                  Text(
                                    'Continue with Google',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              trailing: Obx(
                                () => Visibility(
                                  visible:
                                      logincontroller.GoogleSignLoading.value,
                                  child: SizedBox(
                                      height: 10.sp,
                                      width: 10.sp,
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                      )),
                                  replacement: Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    color: Colors.white,
                                    size: 15.sp,
                                  ),
                                ),
                              ),
                            )),
                      ),
                      SizedBox(
                        height: 10.sp,
                      ),
                      Text(
                        'By clicking continue with Apple you agree to our Terms\nof Service and Privacy Policy',
                        style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.7),
                            fontSize: 10.sp),
                        textAlign: TextAlign.center,
                      )
                    ],
                  )),
            ),
          );
        });
  }
}
