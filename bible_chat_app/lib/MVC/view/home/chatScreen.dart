import 'package:bible_chat_app/MVC/controller/homeController.dart';
import 'package:bible_chat_app/components/Question_bottom_sheet.dart';
import 'package:bible_chat_app/components/image_widget.dart';

import 'package:bible_chat_app/components/spring_widget.dart';
import 'package:bible_chat_app/constant/constants.dart';
import 'package:bible_chat_app/data/mockData.dart';
import 'package:flutter/material.dart';
import 'package:bible_chat_app/constant/theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

class Chatscreen extends StatelessWidget {
  Chatscreen({super.key});

  @override
  final homecontroller = Get.put(Homecontroller());

  Widget build(BuildContext context) {
    return GetBuilder<ThemeHelper>(
        initState: (state) {},
        builder: (themecontroller) {
          return AnnotatedRegion(
            value: themecontroller.systemUiOverlayStyleForhome,
            child: Scaffold(
              backgroundColor: themecontroller.bgcolor,
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 50.sp,
                    ),
                    HeaderWidget(),
                    SizedBox(
                      height: 30.sp,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: Constants.screenPadding.sp),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.sp),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage("assets/images/todayVerse.png"),
                            colorFilter: ColorFilter.mode(
                              Colors.black
                                  .withOpacity(0.5), // Adjust opacity as needed
                              BlendMode
                                  .darken, // Or use `BlendMode.overlay`, `multiply`, etc.
                            ),
                          ),
                        ),
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                        child: Column(
                          children: [
                            Text(
                              "Today’s Verse",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25.sp,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 20.sp,
                            ),
                            Text(
                              "The Lord is not slack concerning His promise, as some count slackness, but is longsuffering toward us, not willing that any should perish but that all should come to repentance.",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 11.sp,
                              ),
                            ),
                            SizedBox(
                              height: 20.sp,
                            ),
                            Text(
                              "2 Peter 3:9",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.bold),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 40, vertical: 10),
                              child: Row(
                                children: [
                                  Expanded(
                                      child: SpringWidget(
                                    onTap: () {
                                      // Navigation.getInstance
                                      //     .bottomToTop_PageNavigation(
                                      //         context, Chatversescreen());
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color:
                                            themecontroller.colorPrimaryyellow,
                                        borderRadius:
                                            BorderRadius.circular(30.sp),
                                      ),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 5.sp, vertical: 7.sp),
                                      alignment: Alignment.center,
                                      child: FittedBox(
                                        fit: BoxFit.scaleDown,
                                        child: Text(
                                          "Listen",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                              fontSize: 18.sp),
                                        ),
                                      ),
                                    ),
                                  )),
                                  SizedBox(
                                    width: 10.sp,
                                  ),
                                  Expanded(
                                      child: Container(
                                    decoration: BoxDecoration(
                                      color: themecontroller.colorPrimaryyellow,
                                      borderRadius:
                                          BorderRadius.circular(30.sp),
                                    ),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 5.sp, vertical: 7.sp),
                                    alignment: Alignment.center,
                                    child: FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text(
                                        "Read",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                            fontSize: 18.sp),
                                      ),
                                    ),
                                  )),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.sp,
                    ),
                    SizedBox(
                      height: 270, // Set a height for proper rendering
                      child: ListView.builder(
                        itemCount: MockData.ChatscreenList.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, int index) {
                          var data = MockData.ChatscreenList[index];
                          return SpringWidget(
                            onTap: () {
                              QuestionBottomSheet.show(context);
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.sp),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    data["name"],
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: 18.sp),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    height: 180.sp,
                                    width: 280.sp,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(20.sp),
                                    ),
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: ImageWidget(
                                            imageUrl: data["image"])),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: Constants.screenPadding.sp),
                        child: Text(
                          "Ask about",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 18.sp),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.sp,
                    ),
                    SizedBox(
                      height: 300,
                      child: ListView.builder(
                        itemCount: MockData.Chatscreen1List.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, int index) {
                          var data = MockData.Chatscreen1List[index];
                          return Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.sp),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  height: 200.sp,
                                  width: 150.sp,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.sp),
                                  ),
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child:
                                          ImageWidget(imageUrl: data["image"])),
                                ),
                                SizedBox(
                                  height: 10.sp,
                                ),
                                Text(
                                  data["name"],
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 12.sp),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: Constants.screenPadding.sp),
                        child: Text(
                          "Discover",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 18.sp),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.sp,
                    ),
                    SizedBox(
                      height: 300,
                      child: ListView.builder(
                        itemCount: MockData.ChatscreenList.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, int index) {
                          var data = MockData.ChatscreenList[index];
                          return Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.sp),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  height: 200.sp,
                                  width: 150.sp,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.sp),
                                  ),
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child:
                                          ImageWidget(imageUrl: data["image"])),
                                ),
                                SizedBox(
                                  height: 10.sp,
                                ),
                                Text(
                                  data["name"],
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 12.sp),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      height: 90.sp,
                    ),
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
