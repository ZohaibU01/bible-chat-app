import 'package:bible_chat_app/MVC/view/onboarding/reminderScreen.dart';
import 'package:bible_chat_app/components/round_button.dart';
import 'package:bible_chat_app/constant/constants.dart';
import 'package:bible_chat_app/constant/navigation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../constant/theme.dart';

class TryAppScreen extends StatelessWidget {
  const TryAppScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeHelper>(
        initState: (state) {},
        builder: (themecontroller) {
          return Scaffold(
            body: Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.9),
                  ],
                ),
                image: const DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(
                      "assets/images/bg.png"), // Replace with actual background image
                ),
              ),
              child: Column(
                children: [
                  SizedBox(height: 100.sp),

                  // Title Text
                  Text(
                    'We want you to try\nGenesis for free.',
                    textAlign: TextAlign.center,
                    style: themecontroller.customTextStyle(
                        fontSize: 33.sp,
                        letterSpacingPercent: -3,
                        color: Colors.white,
                        fontWeight: FontWeight.w500),
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: Constants.screenPadding),
                    child: Container(
                      height: 250.sp,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.sp),
                        // boxShadow: [
                        //   BoxShadow(
                        //     color: Colors.black.withOpacity(0.3),
                        //     blurRadius: 20,
                        //     spreadRadius: 5,
                        //     offset: const Offset(0, 10),
                        //   ),
                        // ],
                        image: const DecorationImage(
                          fit: BoxFit.contain,
                          image: AssetImage(
                              "assets/images/p1.png"), // Replace with actual mockup
                          // "assets/images/p1.gif"), // Replace with actual mockup
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.sp,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.sp),
                    child: Text(
                      "based on spiritual growth data from 7322 users over 3 months",
                      style: TextStyle(color: Colors.white, fontSize: 10.sp),
                    ),
                  ),
                  // Phone Mockup Image
                  Spacer(),
                  Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      // Positioned(
                      //   child: Padding(
                      //     padding: const EdgeInsets.symmetric(
                      //         horizontal: Constants.screenPadding),
                      //     child: Container(
                      //       height: 550.sp,
                      //       width: double.infinity,
                      //       decoration: BoxDecoration(
                      //         borderRadius: BorderRadius.circular(20.sp),
                      //         // boxShadow: [
                      //         //   BoxShadow(
                      //         //     color: Colors.black.withOpacity(0.3),
                      //         //     blurRadius: 20,
                      //         //     spreadRadius: 5,
                      //         //     offset: const Offset(0, 10),
                      //         //   ),
                      //         // ],
                      //         image: const DecorationImage(
                      //           fit: BoxFit.contain,
                      //           image: AssetImage(
                      //               "assets/images/p1.png"), // Replace with actual mockup
                      //           // "assets/images/p1.gif"), // Replace with actual mockup
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 20.sp),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black.withOpacity(0.3),
                              Colors.black.withOpacity(0.5),
                              Colors.black.withOpacity(0.8),
                              Colors.black,
                              Colors.black,
                            ],
                          ),
                        ),
                        child: Column(
                          children: [
                            // No Payment Due Text
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.done,
                                    color: HexColor('#FFD700'),
                                    size: 25.sp), // Gold color
                                SizedBox(width: 5.sp),
                                Text(
                                  'No Payment Due Now',
                                  style: TextStyle(
                                      fontSize: 15.sp, color: Colors.white),
                                ),
                              ],
                            ),

                            SizedBox(height: 10.sp),

                            // Try for Free Button
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 20.sp,
                              ),
                              child: RoundButton(
                                // gradient: true,
                                margin: 0,
                                backgroundColor: Colors.white,
                                height: 45.sp,
                                borderRadius: 10.sp,
                                title: 'Try For Free',
                                // sufixicon: Icons.arrow_forward_ios,
                                iconColor: Colors.black,
                                borderColor: Colors.transparent,
                                borderWidth: 1.sp,
                                textColor: Colors.black,
                                onTap: () async {
                                  Navigation.getInstance
                                      .RightToLeft_PageNavigation(
                                          context, Reminderscreen());
                                },
                              ),
                            ),

                            SizedBox(height: 10.sp),

                            // Pricing Text
                            Text(
                              "7-days free, then \$49.99/yr (~\$4.17/mo)",
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: Colors.white.withOpacity(0.6),
                              ),
                            ),
                            SizedBox(
                              height: 20.sp,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),

                  // const Spacer(),

                  // Gradient Bottom Container
                ],
              ),
            ),
          );
        });
  }
}
