import 'package:bible_chat_app/MVC/controller/messageController.dart';
import 'package:bible_chat_app/components/spring_widget.dart';
import 'package:bible_chat_app/constant/constants.dart';
import 'package:bible_chat_app/constant/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class Chatversescreen extends StatefulWidget {
  @override
  _ChatversescreenState createState() => _ChatversescreenState();
}

class _ChatversescreenState extends State<Chatversescreen> {
  final MessageController controller = Get.put(MessageController());
  final ThemeHelper themeController = Get.find<ThemeHelper>();

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
        themeController.systemUiOverlayStyleForChat);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeHelper>(
      builder: (themecontroller) {
        return Scaffold(
          body: AnnotatedRegion<SystemUiOverlayStyle>(
            value: themecontroller.systemUiOverlayStyleForChat,
            child: Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(color: themecontroller.bgcolor),
              child: Column(
                children: [
                  // Header Section

                  Container(
                    padding: EdgeInsets.only(
                        top: 40.sp, bottom: 20.sp, left: 20.sp, right: 20.sp),
                    decoration: BoxDecoration(
                      color: themecontroller.ContainerColor,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                    ),
                    child: Center(
                      child: Row(
                        children: [
                          SpringWidget(
                            onTap: () => Get.back(),
                            child: Icon(Icons.arrow_back_ios_new_rounded,
                                color: Colors.white),
                          ),
                          SizedBox(
                            width: 20.sp,
                          ),
                          Text(
                            "Chat",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                              fontSize: 22.sp,
                            ),
                          ),
                          const Spacer(),
                          SvgPicture.asset(
                            "assets/icons/save.svg",
                            height: 20.sp,
                            width: 20.sp,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 20.sp,
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Messages List
                  Expanded(
                    child:   Column(
                      children: [
                          Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: Constants.screenPadding.sp),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.sp),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage(
                              "assets/images/todayVerse.png",
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
                        ListView.builder(
                            padding: EdgeInsets.all(10),
                            itemCount: controller.messages.length,
                            itemBuilder: (context, index) {
                              final message = controller.messages[index];
                              return AnimationConfiguration.staggeredList(
                                position: index,
                                duration: Duration(milliseconds: 373),
                                child: SlideAnimation(
                                  horizontalOffset: 50.0,
                                  verticalOffset: 50.0,
                                  child: FadeInAnimation(
                                    child: Align(
                                      alignment: message.isMe
                                          ? Alignment.centerRight
                                          : Alignment.centerLeft,
                                      child: Container(
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 5, horizontal: 10),
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 12, horizontal: 16),
                                        decoration: BoxDecoration(
                                          color: message.isMe
                                              ? Colors.black
                                              : themecontroller.ContainerColor,
                                          borderRadius: message.isMe
                                              ? BorderRadius.only(
                                                  bottomLeft: Radius.circular(20),
                                                  bottomRight: Radius.circular(20),
                                                  topLeft: Radius.circular(20))
                                              : BorderRadius.only(
                                                  bottomLeft: Radius.circular(20),
                                                  bottomRight: Radius.circular(20),
                                                  topRight: Radius.circular(20)),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              message.text,
                                              style: TextStyle(
                                                color: message.isMe
                                                    ? Colors.black
                                                    : Colors.white,
                                                fontSize: 14,
                                              ),
                                            ),
                                            const SizedBox(height: 8),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                      ],
                    ),
                    
                    
                    // Obx(
                    //   () => 
                    // ListView.builder(
                    //     padding: EdgeInsets.all(10),
                    //     itemCount: controller.messages.length,
                    //     itemBuilder: (context, index) {
                    //       final message = controller.messages[index];
                    //       return AnimationConfiguration.staggeredList(
                    //         position: index,
                    //         duration: Duration(milliseconds: 373),
                    //         child: SlideAnimation(
                    //           horizontalOffset: 50.0,
                    //           verticalOffset: 50.0,
                    //           child: FadeInAnimation(
                    //             child: Align(
                    //               alignment: message.isMe
                    //                   ? Alignment.centerRight
                    //                   : Alignment.centerLeft,
                    //               child: Container(
                    //                 margin: const EdgeInsets.symmetric(
                    //                     vertical: 5, horizontal: 10),
                    //                 padding: const EdgeInsets.symmetric(
                    //                     vertical: 12, horizontal: 16),
                    //                 decoration: BoxDecoration(
                    //                   color: message.isMe
                    //                       ? Colors.black
                    //                       : themecontroller.ContainerColor,
                    //                   borderRadius: message.isMe
                    //                       ? BorderRadius.only(
                    //                           bottomLeft: Radius.circular(20),
                    //                           bottomRight: Radius.circular(20),
                    //                           topLeft: Radius.circular(20))
                    //                       : BorderRadius.only(
                    //                           bottomLeft: Radius.circular(20),
                    //                           bottomRight: Radius.circular(20),
                    //                           topRight: Radius.circular(20)),
                    //                 ),
                    //                 child: Column(
                    //                   crossAxisAlignment:
                    //                       CrossAxisAlignment.start,
                    //                   children: [
                    //                     Text(
                    //                       message.text,
                    //                       style: TextStyle(
                    //                         color: message.isMe
                    //                             ? Colors.black
                    //                             : Colors.white,
                    //                         fontSize: 14,
                    //                       ),
                    //                     ),
                    //                     const SizedBox(height: 8),
                    //                   ],
                    //                 ),
                    //               ),
                    //             ),
                    //           ),
                    //         ),
                    //       );
                    //     },
                    //   ),
                    // ),
                  ),

                  // Message Input Field
                  Container(
                    padding: EdgeInsets.only(
                        bottom: 30.sp, top: 20.sp, left: 20.sp, right: 20.sp),
                    decoration: BoxDecoration(
                      color: themecontroller.ContainerColor,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(12)),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: TextField(
                              cursorColor: Colors.white,
                              controller: controller.messageController,
                              decoration: const InputDecoration(
                                labelStyle: TextStyle(color: Colors.white),
                                hintText: "Write any question here",
                                border: InputBorder.none,
                                hintStyle: TextStyle(color: Colors.white70),
                              ),
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        SpringWidget(
                          onTap: () {
                            controller.sendMessage(
                                controller.messageController.text, false);
                          },
                          child: CircleAvatar(
                            radius: 20.r,
                            backgroundColor: Colors.white,
                            child: Icon(Icons.send_outlined,
                                color: themecontroller.bgcolor),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
