import 'package:bible_chat_app/MVC/view/home/messageScreen.dart';
import 'package:bible_chat_app/components/round_button.dart';
import 'package:bible_chat_app/constant/navigation.dart';
import 'package:bible_chat_app/data/mockData.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:bible_chat_app/components/spring_widget.dart';
import 'package:bible_chat_app/constant/constants.dart';
import 'package:bible_chat_app/constant/theme.dart';
import 'package:bible_chat_app/helper/getx_helper.dart';
import 'package:get/get.dart';

class QuestionBottomSheet extends StatelessWidget {
  QuestionBottomSheet({
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
        return QuestionBottomSheet();
      },
    );
  }

  final controllersProvider = Get.put(GetxControllersProvider());
  Widget build(BuildContext context) {
    return GetBuilder<ThemeHelper>(builder: (themecontroller) {
      return AnnotatedRegion(
        value: themecontroller.systemUiOverlayStyleForhome,
        child: Container(
          height: MediaQuery.of(context).size.height * 0.70,
          decoration: BoxDecoration(
              // gradient: themecontroller.containerGradient,
              boxShadow: [
                BoxShadow(
                  color: Colors.white.withOpacity(0.5),
                  offset: const Offset(0, 5),
                  blurRadius: 10,
                  spreadRadius: 0,
                ),
              ],
              color: themecontroller.bgcolor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.sp),
                  topRight: Radius.circular(20.sp))),
          padding: const EdgeInsets.symmetric(
            vertical: 6,
            horizontal: 6,
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: Constants.screenPadding),
              child: SingleChildScrollView(
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
                        Text(
                          "You might want to ask about...",
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.sp),
                    SizedBox(
                      height: 350.sp,
                      child: SingleChildScrollView(
                        child: Column(children: [
                          Divider(
                            color: Colors.white.withValues(alpha: 0.3),
                            thickness: 2.sp,
                          ),
                          ...MockData.QuestionList.map(
                            (e) => Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(vertical: 10.sp),
                                  child: Text(
                                    e["name"],
                                    style: TextStyle(
                                      fontSize: 13.sp,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Divider(
                                  color: Colors.white.withValues(alpha: 0.3),
                                  thickness: 2.sp,
                                ),
                              ],
                            ),
                          ).toList(),
                        ]),
                      ),
                    ),
                    SizedBox(
                      height: 10.sp,
                    ),
                    Center(
                      child: Text(
                        "Or",
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 20.sp),
                      child: RoundButton(
                        gradient: false,
                        margin: 0,
                        backgroundColor: themecontroller.colorPrimaryyellow,
                        height: 45.sp,
                        borderRadius: 10.sp,
                        title: 'Ask Your Own Question',
                        borderColor: Colors.transparent,
                        borderWidth: 1.sp,
                        iconColor: themecontroller.colorwhite,
                        textColor: Colors.black,
                        onTap: () async {
                          Navigation.getInstance.bottomToTop_PageNavigation(
                              context, MessageScreen());
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
