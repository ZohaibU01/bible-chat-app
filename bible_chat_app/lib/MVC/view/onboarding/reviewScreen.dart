import 'package:bible_chat_app/MVC/view/onboarding/onboardingchatScreen.dart';
import 'package:bible_chat_app/components/round_button.dart';
import 'package:bible_chat_app/constant/navigation.dart';
import 'package:bible_chat_app/constant/theme.dart';
import 'package:bible_chat_app/data/mockData.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class Reviewscreen extends StatefulWidget {
  @override
  _ReviewscreenState createState() => _ReviewscreenState();
}

class _ReviewscreenState extends State<Reviewscreen>
    with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
    
  }

  void _startAutoScroll() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 30), // Adjust speed
    );

    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.linear),
    )..addListener(() {
        if (_scrollController.hasClients) {
          double maxScroll = _scrollController.position.maxScrollExtent;
          double offset = maxScroll * _animation.value;
          _scrollController.animateTo(
            offset,
            duration: const Duration(milliseconds: 200), // Smoother transition
            curve: Curves.linear,
          );
        }
      });

    _animationController.repeat();

    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _scrollController.animateTo(
          0,
          duration: const Duration(seconds: 4), // Slow reset to top
          curve: Curves.easeInOut,
        );
        _animationController.forward(from: 0);
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
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
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ListView.builder(
                        controller: _scrollController,
                        itemCount: MockData.positiveLongReviews.length,
                        itemBuilder: (context, index) {
                          return Container(
                            // height: 250.sp,
                            margin: const EdgeInsets.symmetric(vertical: 20),
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Color.fromARGB(43, 10, 15, 113),
                              border: Border.all(
                                  color: Colors.white,
                                  width: 2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  MockData.positiveLongReviews[index]["name"]
                                      .toString(),
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 25.sp,
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                  height: 10.sp,
                                ),
                                Row(
                                  children: List.generate(
                                    double.parse(
                                            MockData.positiveLongReviews[index]
                                                    ["rating"] ??
                                                "0")
                                        .round(),
                                    (starIndex) => Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 2.sp),
                                      child: SvgPicture.asset(
                                        "assets/icons/star.svg",
                                        height: 25.sp,
                                        width: 25.sp,
                                        color:
                                            themecontroller.colorPrimaryyellow,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10.sp,
                                ),
                                Text(
                                  MockData.positiveLongReviews[index]["review"]
                                      .toString(),
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    Container(
                      height: 1000.sp,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.transparent,
                            const Color.fromARGB(237, 0, 0, 0),
                            const Color.fromARGB(255, 0, 0, 0)
                            // .withValues(alpha: 0.9),
                          ],
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10.sp,),
                            child: Text(
                              "Connect With Thousands Of Believers Today!",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.sp,
                                  letterSpacing: 1,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10.sp, vertical: 20.sp),
                            child: RoundButton(
                              gradient: false,
                              margin: 0,
                              backgroundColor: themecontroller.colorPrimarywhite,
                              height: 45.sp,
                              borderRadius: 10.sp,
                              title: 'Continue',
                              sufixicon: Icons.arrow_forward_ios,
                              iconColor: Colors.black,
                              borderColor: Colors.transparent,
                              borderWidth: 1.sp,
                              textColor: Colors.black,
                              onTap: () async {
                                Navigation.getInstance
                                    .pagePushAndReplaceNavigation(
                                        context, OnboardingChatScreen());
                              },
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
        });
  }
}
