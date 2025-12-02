import 'package:bible_chat_app/MVC/controller/homeController.dart';
import 'package:bible_chat_app/MVC/view/home/editprofileScreen.dart';
import 'package:bible_chat_app/components/Question_bottom_sheet.dart';
import 'package:bible_chat_app/components/image_widget.dart';

import 'package:bible_chat_app/components/spring_widget.dart';
import 'package:bible_chat_app/constant/constants.dart';
import 'package:bible_chat_app/constant/navigation.dart';
import 'package:bible_chat_app/data/mockData.dart';
import 'package:flutter/material.dart';
import 'package:bible_chat_app/constant/theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../helper/data_storage.dart';

class Profilescreen extends StatelessWidget {
  Profilescreen({super.key});

  @override
  final homecontroller = Get.put(Homecontroller());

  Widget build(BuildContext context) {
    return GetBuilder<ThemeHelper>(
        initState: (state) {},
        builder: (themecontroller) {
          return AnnotatedRegion(
            value: themecontroller.systemUiOverlayStyleForhome,
            child: Scaffold(
              backgroundColor: Colors.black,
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: themecontroller.bgcolor,
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(20.sp),
                              bottomLeft: Radius.circular(20.sp))),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: Constants.screenPadding,
                            horizontal: Constants.screenPadding),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 50.sp,
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: SpringWidget(
                                onTap: () {
                                  Get.back();
                                },
                                child: Icon(
                                  Icons.arrow_back_ios_new_rounded,
                                  color: themecontroller.backgoundcolor
                                      .withValues(alpha: 0.4),
                                ),
                              ),
                            ),
                            SpringWidget(
                              onTap: () {},
                              child: CircleAvatar(
                                backgroundColor:
                                    HexColor('#FFF021').withValues(alpha: 0.3),
                                radius: 70.sp,
                                child: Text(
                                  DataStroge.userName.value[0],
                                  style: TextStyle(
                                      color: HexColor('#FFF021'),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 60.sp),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5.sp,
                            ),
                            SpringWidget(
                              onTap: () {
                                Navigation.getInstance
                                    .RightToLeft_PageNavigation(
                                        context, EditProfileScreen());
                              },
                              child: Text(
                                "Edit Profile",
                                style: TextStyle(
                                    color: HexColor('#FFF021'),
                                    fontSize: 10.sp),
                              ),
                            ),
                            SizedBox(
                              width: 200.sp,
                              child: Center(
                                child: Obx(
                                  () => Text(
                                    '${DataStroge.userName.value}',
                                    maxLines: 1,
                                    softWrap: true,
                                    overflow: TextOverflow.ellipsis,
                                    style: themecontroller.customTextStyle(
                                        fontSize: 26.sp,
                                        letterSpacingPercent: -3,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20.sp,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Age range",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w100,
                                    fontSize: 15.sp,
                                  ),
                                ),
                                Obx(
                                  () => Text(
                                    DataStroge.userAgeRange.value == ''
                                        ? "not selected"
                                        : DataStroge.userAgeRange.value,
                                    style: TextStyle(
                                        color:
                                            Colors.white.withValues(alpha: 0.4),
                                        fontWeight: FontWeight.w100,
                                        fontSize: 15.sp),
                                  ),
                                )
                              ],
                            ),
                            Divider(
                              color: Colors.white.withValues(alpha: 0.2),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Email",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w100,
                                      fontSize: 15.sp),
                                ),
                                Obx(
                                  () => Text(
                                    DataStroge.userEmail.value == ''
                                        ? "Not Entered"
                                        : DataStroge.userEmail.value,
                                    style: TextStyle(
                                        color:
                                            Colors.white.withValues(alpha: 0.4),
                                        fontWeight: FontWeight.w100,
                                        fontSize: 15.sp),
                                  ),
                                )
                              ],
                            ),
                            Divider(
                              color: Colors.white.withValues(alpha: 0.2),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Denomination",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w100,
                                      fontSize: 15.sp),
                                ),
                                Obx(
                                  () => Text(
                                    DataStroge.userDenomination.value == ''
                                        ? "not selected"
                                        : DataStroge.userDenomination.value,
                                    style: TextStyle(
                                        color:
                                            Colors.white.withValues(alpha: 0.4),
                                        fontWeight: FontWeight.w100,
                                        fontSize: 15.sp),
                                  ),
                                )
                              ],
                            ),
                            Divider(
                              color: Colors.white.withValues(alpha: 0.2),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Church",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w100,
                                      fontSize: 15.sp),
                                ),
                                Obx(
                                  () => Text(
                                    DataStroge.userChurch.value == ''
                                        ? "not selected"
                                        : DataStroge.userChurch.value,
                                    style: TextStyle(
                                        color:
                                            Colors.white.withValues(alpha: 0.4),
                                        fontWeight: FontWeight.w100,
                                        fontSize: 15.sp),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: Constants.screenPadding),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 20.sp,
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Subscription",
                                style: themecontroller.customTextStyle(
                                    fontSize: 20.sp,
                                    letterSpacingPercent: -3,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(
                              height: 10.sp,
                            ),
                            ListTile(
                              minTileHeight: 15.sp,
                              leading: SvgPicture.asset(
                                "assets/icons/user.svg",
                                height: 17.sp,
                                width: 17.sp,
                              ),
                              minLeadingWidth: 10.sp,
                              title: Text(
                                "Membership ",
                                style: themecontroller.customTextStyle(
                                    fontSize: 13.sp,
                                    letterSpacingPercent: -3,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w200),
                              ),
                            ),
                            Divider(
                              color: Colors.white.withValues(alpha: 0.2),
                            ),
                            ListTile(
                              minTileHeight: 15.sp,
                              leading: SvgPicture.asset(
                                "assets/icons/user.svg",
                                height: 17.sp,
                                width: 17.sp,
                              ),
                              minLeadingWidth: 10.sp,
                              title: Text(
                                "Upgrade to Premium",
                                style: themecontroller.customTextStyle(
                                    fontSize: 13.sp,
                                    letterSpacingPercent: -3,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w200),
                              ),
                            ),
                            Divider(
                              color: Colors.white.withValues(alpha: 0.2),
                            ),
                            ListTile(
                              minTileHeight: 15.sp,
                              leading: SvgPicture.asset(
                                "assets/icons/user.svg",
                                height: 17.sp,
                                width: 17.sp,
                              ),
                              minLeadingWidth: 10.sp,
                              title: Text(
                                "Membership ",
                                style: themecontroller.customTextStyle(
                                    fontSize: 13.sp,
                                    letterSpacingPercent: -3,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w200),
                              ),
                            ),
                            Divider(
                              color: Colors.white.withValues(alpha: 0.2),
                            ),
                            SizedBox(
                              height: 20.sp,
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "About",
                                style: themecontroller.customTextStyle(
                                    fontSize: 20.sp,
                                    letterSpacingPercent: -3,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(
                              height: 10.sp,
                            ),
                            ListTile(
                              minTileHeight: 15.sp,
                              leading: SvgPicture.asset(
                                "assets/icons/user.svg",
                                height: 17.sp,
                                width: 17.sp,
                              ),
                              minLeadingWidth: 10.sp,
                              title: Text(
                                "Contact Us  ",
                                style: themecontroller.customTextStyle(
                                    fontSize: 13.sp,
                                    letterSpacingPercent: -3,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w200),
                              ),
                            ),
                            Divider(
                              color: Colors.white.withValues(alpha: 0.2),
                            ),
                            ListTile(
                              minTileHeight: 15.sp,
                              leading: SvgPicture.asset(
                                "assets/icons/user.svg",
                                height: 17.sp,
                                width: 17.sp,
                              ),
                              minLeadingWidth: 10.sp,
                              title: Text(
                                "Terms of Use",
                                style: themecontroller.customTextStyle(
                                    fontSize: 13.sp,
                                    letterSpacingPercent: -3,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w200),
                              ),
                            ),
                            Divider(
                              color: Colors.white.withValues(alpha: 0.2),
                            ),
                            ListTile(
                              minTileHeight: 15.sp,
                              leading: SvgPicture.asset(
                                "assets/icons/user.svg",
                                height: 17.sp,
                                width: 17.sp,
                              ),
                              minLeadingWidth: 10.sp,
                              title: Text(
                                "Privacy Policy",
                                style: themecontroller.customTextStyle(
                                    fontSize: 13.sp,
                                    letterSpacingPercent: -3,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w200),
                              ),
                            ),
                            Divider(
                              color: Colors.white.withValues(alpha: 0.2),
                            ),
                            SizedBox(
                              height: 20.sp,
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Account ",
                                style: themecontroller.customTextStyle(
                                    fontSize: 20.sp,
                                    letterSpacingPercent: -3,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(
                              height: 10.sp,
                            ),
                            ListTile(
                              minTileHeight: 15.sp,
                              leading: SvgPicture.asset(
                                "assets/icons/google.svg",
                                color: Colors.white,
                                height: 17.sp,
                                width: 17.sp,
                              ),
                              minLeadingWidth: 10.sp,
                              title: Text(
                                "Link account data",
                                style: themecontroller.customTextStyle(
                                    fontSize: 13.sp,
                                    letterSpacingPercent: -3,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w200),
                              ),
                            ),
                            Divider(
                              color: Colors.white.withValues(alpha: 0.2),
                            ),
                            ListTile(
                              minTileHeight: 15.sp,
                              leading: SvgPicture.asset(
                                "assets/icons/user.svg",
                                height: 17.sp,
                                width: 17.sp,
                              ),
                              minLeadingWidth: 10.sp,
                              title: Text(
                                "Manage your reminders",
                                style: themecontroller.customTextStyle(
                                    fontSize: 13.sp,
                                    letterSpacingPercent: -3,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w200),
                              ),
                            ),
                            Divider(
                              color: Colors.white.withValues(alpha: 0.2),
                            ),
                            ListTile(
                              minTileHeight: 15.sp,
                              leading: SvgPicture.asset(
                                "assets/icons/user.svg",
                                height: 17.sp,
                                width: 17.sp,
                              ),
                              minLeadingWidth: 10.sp,
                              title: Text(
                                "Change language",
                                style: themecontroller.customTextStyle(
                                    fontSize: 13.sp,
                                    letterSpacingPercent: -3,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w200),
                              ),
                            ),
                            Divider(
                              color: Colors.white.withValues(alpha: 0.2),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}

class HeaderWidget extends StatelessWidget {
  final String title;
  final String iconPath;
  final Color titleColor;
  final double titleSize;
  final FontWeight titleWeight;
  final Color iconColor;
  final double iconSize;

  const HeaderWidget({
    Key? key,
    this.title = 'God bless you.', // Default title
    this.iconPath = "assets/icons/user.svg", // Default icon path
    this.titleColor = Colors.white,
    this.titleSize = 20,
    this.titleWeight = FontWeight.bold,
    this.iconColor = Colors.white,
    this.iconSize = 20,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Constants.screenPadding.sp,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              color: titleColor,
              fontSize: titleSize.sp,
              fontWeight: titleWeight,
            ),
          ),
          SpringWidget(
            onTap: () {},
            child: SvgPicture.asset(
              iconPath,
              height: iconSize.sp,
              width: iconSize.sp,
              color: iconColor,
            ),
          ),
        ],
      ),
    );
  }
}
