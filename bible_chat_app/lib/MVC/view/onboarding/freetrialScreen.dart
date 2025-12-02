// import 'dart:async';
// import 'package:bible_chat_app/MVC/controller/onboardingController.dart';
// import 'package:bible_chat_app/MVC/view/onboarding/OneTimeOfferScreen.dart';
// import 'package:bible_chat_app/MVC/view/onboarding/analyzingGoal1_Screen.dart';
// import 'package:bible_chat_app/MVC/view/onboarding/reminderScreen.dart';
// import 'package:bible_chat_app/components/progressLineWidget.dart';
// import 'package:bible_chat_app/components/round_button.dart';
// import 'package:bible_chat_app/components/spring_widget.dart';
// import 'package:avatar_glow/avatar_glow.dart';
// import 'package:bible_chat_app/constant/navigation.dart';
// import 'package:flutter/material.dart';
// import 'package:bible_chat_app/constant/theme.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:get/get.dart';
// import 'package:hexcolor/hexcolor.dart';

// class Freetrialscreen extends StatelessWidget {
//   Freetrialscreen({super.key});

//   @override
//   final onboardingcontroller = Get.put(Onboardingcontroller());

//   Widget build(BuildContext context) {
//     return GetBuilder<ThemeHelper>(
//         initState: (state) {},
//         builder: (themecontroller) {
//           return AnnotatedRegion(
//             value: themecontroller.systemUiOverlayStylesplash,
//             child: Scaffold(
//               body: Container(
//                 height: double.infinity,
//                 width: double.infinity,
//                 decoration: BoxDecoration(
//                   gradient: themecontroller.screenGradient,
//                   image: DecorationImage(
//                     fit: BoxFit.cover,
//                     image: AssetImage(
//                       "assets/images/bg.png",
//                     ),
//                   ),
//                 ),
//                 child: Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 20.sp),
//                   child: Stack(
//                     children: [
//                       Column(
//                         // mainAxisAlignment: MainAxisAlignment.spaceAround,
//                         children: [
//                           SizedBox(
//                             height: 100.sp,
//                           ),
//                           Text('How your 7-day free trial works.',
//                               style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 25.sp,
//                                   fontWeight: FontWeight.bold)),
//                           SizedBox(
//                             height: 20.sp,
//                           ),
//                           Expanded(
//                               child: Stack(
//                             children: [
//                               Positioned(
//                                 top: 15.sp,
//                                 left: 15.sp,
//                                 child: Container(
//                                   height: 200.sp,
//                                   width: 5.sp,
//                                   decoration:
//                                       BoxDecoration(color: Colors.white),
//                                 ),
//                               ),
//                               Column(
//                                 children: [
//                                   planTile(
//                                     isglow: false,
//                                     circleColor: themecontroller.colorPrimaryyellow,
//                                     icon: "check.svg",
//                                     title: 'Find answers from the Bible',
//                                     subtitle:
//                                         'Use unlimited chats with our Bible chat feature.',
//                                   ),
//                                   planTile(
//                                     isglow: true,
//                                     circleColor: themecontroller.colorPrimaryyellow,
//                                     icon: "lock.svg",
//                                     title: 'Achieve Freedom from sin',
//                                     subtitle:
//                                         'We give you every tool you need to defeat sin',
//                                   ),
//                                   planTile(
//                                     isglow: false,
//                                     icon: "bell.svg",
//                                     title: 'Achieve Freedom from sin',
//                                     subtitle:
//                                         'We give you every tool you need to defeat sin',
//                                   ),
//                                   planTile(
//                                     isglow: false,
//                                     icon: "star.svg",
//                                     title:
//                                         'Deepen your understanding of Scripture',
//                                     subtitle:
//                                         'Explore our library of Bible study plans and Audio books',
//                                   )
//                                 ],
//                               ),
//                             ],
//                           )),
//                           Column(
//                             children: [
//                               Obx(
//                                 () => Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     planSelection(
//                                       onTap: () {
//                                         onboardingcontroller
//                                                 .isCheckedplan1.value =
//                                             !onboardingcontroller
//                                                 .isCheckedplan1.value;

//                                         onboardingcontroller
//                                             .isCheckedplan2.value = false;
//                                       },
//                                       value: onboardingcontroller
//                                           .isCheckedplan1.value,
//                                       planName: 'Monthly',
//                                       Price: '\$9.99/mo',
//                                     ),
//                                     SizedBox(
//                                       width: 10.sp,
//                                     ),
//                                     planSelection(
//                                       onTap: () {
//                                         onboardingcontroller
//                                                 .isCheckedplan2.value =
//                                             !onboardingcontroller
//                                                 .isCheckedplan2.value;
//                                         onboardingcontroller
//                                             .isCheckedplan1.value = false;
//                                       },
//                                       value: onboardingcontroller
//                                           .isCheckedplan2.value,
//                                       planName: 'Yearly',
//                                       Price: '\$49.99/yr',
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               SizedBox(
//                                 height: 30.sp,
//                               ),
//                               RoundButton(
//                                 gradient: false,
//                                 margin: 0,
//                                 backgroundColor: HexColor('#038CFC'),
//                                 height: 45.sp,
//                                 borderRadius: 10.sp,
//                                 title: 'Start my Journey',
//                                 borderColor: Colors.transparent,
//                                 borderWidth: 1.sp,
//                                 iconColor: themecontroller.colorwhite,
//                                 textColor: Colors.black.withOpacity(0.8),
//                                 onTap: () async {
//                                   Navigation.getInstance
//                                   .RightToLeft_PageNavigation(
//                                       context, Onetimeofferscreen());
//                                 },
//                               ),
//                               SizedBox(
//                                 height: 10.sp,
//                               ),
//                               Text(
//                                 "Just \$9.99 per month",
//                                 style: TextStyle(
//                                     fontSize: 12.sp,
//                                     color: Colors.white.withValues(alpha: 0.6)),
//                               )
//                             ],
//                           ),
//                           SizedBox(
//                             height: 40.sp,
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           );
//         });
//   }
// }

// class planSelection extends StatelessWidget {
//   const planSelection({
//     super.key,
//     required this.Price,
//     required this.planName,
//     required this.value,
//     required this.onTap,
//   });
//   final String planName;
//   final String Price;
//   final bool value;
//   final Function() onTap;
//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: SpringWidget(
//         onTap: onTap,
//         child: AnimatedContainer(
//           duration: Duration(milliseconds: 200),
//           decoration: BoxDecoration(
//               color: value
//                   ? Colors.white.withValues(alpha: 0.2)
//                   : Colors.black.withValues(alpha: 0.1),
//               borderRadius: BorderRadius.circular(20.sp),
//               border: Border.all(width: 2.sp, color: Colors.white)),
//           padding: EdgeInsets.symmetric(horizontal: 10.sp, vertical: 15.sp),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.end,
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     planName,
//                     style: TextStyle(color: Colors.white),
//                   ),
//                   Visibility(
//                     visible: value,
//                     replacement: Container(
//                       width: 25.sp,
//                       height: 25.sp,
//                       decoration: BoxDecoration(
//                           shape: BoxShape.circle,
//                           border: Border.all(width: 2.sp, color: Colors.white)),
//                     ),
//                     child: CircleAvatar(
//                       backgroundColor: HexColor('#FFCA35'),
//                       radius: 12.sp,
//                       child: Icon(
//                         Icons.done,
//                         color: Colors.black,
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//               SizedBox(
//                 height: 5.sp,
//               ),
//               Text(
//                 Price,
//                 style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white,
//                     fontSize: 18.sp),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class planTile extends StatelessWidget {
//   planTile({
//     super.key,
//     required this.title,
//     required this.subtitle,
//     required this.icon,
//     this.circleColor = Colors.white,
//     required this.isglow,
//   });

//   final String title;
//   final String subtitle;
//   final String icon;
//   final Color circleColor;
//   final bool isglow;
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(top: 10),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Visibility(
//             visible: isglow,
//             child: AvatarGlow(
//               startDelay: const Duration(seconds: 1),
//               glowShape: BoxShape.circle,
//               glowColor: circleColor,
//               duration: const Duration(seconds: 3),

//               curve: Curves.easeInOut,
//               child: CircleAvatar(
//                 backgroundColor: circleColor,
//                 child: SvgPicture.asset(
//                   "assets/icons/${icon}",
//                   height: 12.sp,
//                   width: 12.sp,
//                   color: Colors.black,
//                 ),
//               ),
//             ),
//             replacement: CircleAvatar(
//               backgroundColor: circleColor,
//               child: SvgPicture.asset(
//                 "assets/icons/${icon}",
//                 height: 12.sp,
//                 width: 12.sp,
//                 color: Colors.black,
//               ),
//             ),
//           ),
//           SizedBox(
//             width: 10.sp,
//           ),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               SizedBox(
//                 width: 250.sp,
//                 child: Text(
//                   title,
//                   style: TextStyle(
//                       fontSize: 15.sp,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white),
//                 ),
//               ),
//               SizedBox(
//                 width: 270.sp,
//                 child: Text(
//                   subtitle,
//                   style: TextStyle(fontSize: 12.sp, color: Colors.white),
//                 ),
//               ),
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }
