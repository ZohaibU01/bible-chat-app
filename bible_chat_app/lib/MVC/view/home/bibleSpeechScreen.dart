import 'package:bible_chat_app/components/round_button.dart';
import 'package:bible_chat_app/components/spring_widget.dart';
import 'package:bible_chat_app/components/verse_widget.dart';
import 'package:bible_chat_app/constant/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:bible_chat_app/constant/theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';

import '../../controller/readingController.dart';

class Biblespeechscreen extends StatefulWidget {
  Biblespeechscreen({super.key});

  @override
  State<Biblespeechscreen> createState() => _BiblespeechscreenState();
}

class _BiblespeechscreenState extends State<Biblespeechscreen> {
  final readingController = Get.put(ReadingController());
  final AudioPlayer _audioPlayer = AudioPlayer();
  RxBool isPlaying = false.obs;

  @override
  void initState() {
    super.initState();
    _loadChapterAudio();
  }

  Future<void> _loadChapterAudio() async {
    final url = readingController.selectedChapter.value?.audioLinks["souer"];
    if (url != null && url.isNotEmpty) {
      await _audioPlayer.setUrl(url);
    }
    // else{
    //   _audioPlayer.setUrl("url");
    // }
  }

  Future<void> _play() async {
    isPlaying.value = true;
    await _audioPlayer.play();
  }

  Future<void> _pause() async {
    await _audioPlayer.pause();
    isPlaying.value = false;
  }

  Future<void> _stop() async {
    await _audioPlayer.stop();
    isPlaying.value = false;
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return GetBuilder<ThemeHelper>(
        initState: (state) {},
        dispose: (state) {},
        builder: (themecontroller) {
          return AnnotatedRegion(
            value: themecontroller.systemUiOverlayStyleForhome,
            child: Scaffold(
              backgroundColor: themecontroller.bgcolor,
              body: Obx(
                () => readingController.isLoading.value
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : Column(
                        children: [
                          biblechatHead(loadAudio: _loadChapterAudio,),
                          Stack(
                            alignment: Alignment.bottomCenter,
                            children: [
                              if (readingController.verses.isNotEmpty)
                                Obx(() => Container(
                                      height: 600.sp,
                                      child: SingleChildScrollView(
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal:
                                                  Constants.screenPadding.sp,
                                              vertical:
                                                  Constants.screenPadding.sp),
                                          child: Column(
                                            children: readingController
                                                    .verses.isEmpty
                                                ? []
                                                : readingController.verses
                                                    .map(
                                                      (verse) => Text(
                                                        "${verse.number}: ${verse.text}\n",
                                                        style: TextStyle(
                                                            wordSpacing: 2.sp,
                                                            color: Colors.white
                                                                .withValues(
                                                                    alpha: 0.8),
                                                            fontSize:
                                                                readingController
                                                                    .verseFontSize
                                                                    .value),
                                                      ),
                                                    )
                                                    .toList(),
                                          ),
                                        ),
                                      ),
                                    )),
                              Positioned(
                                bottom: 10,
                                left: 0,
                                right: 0,
                                child: Container(
                                  height: 150.sp,
                                  decoration: const BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Colors.transparent,
                                        Colors.transparent,
                                        Color.fromARGB(46, 6, 54, 93)
                                        // .withValues(alpha: 0.9),
                                      ],
                                    ),
                                  ),
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10.sp),
                                    // child: Row(
                                    //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    //   children: [
                                    //     CircleAvatar(
                                    //       radius: 20.sp,
                                    //       backgroundColor:
                                    //       themecontroller.ContainerColor,
                                    //       child: Icon(
                                    //         Icons.arrow_back_ios_new_rounded,
                                    //         color: Colors.white,
                                    //         size: 20.sp,
                                    //       ),
                                    //     ),
                                    //     SizedBox(
                                    //       width: 30.sp,
                                    //     ),
                                    //     SpringWidget(
                                    //       onTap: () {
                                    //         if (isplay.value) {
                                    //           _speak();
                                    //           isplay.value = !isplay.value;
                                    //         } else {
                                    //           _stop();
                                    //           isplay.value = !isplay.value;
                                    //         }
                                    //       },
                                    //       child: Obx(
                                    //             () => CircleAvatar(
                                    //           radius: 30.sp,
                                    //           backgroundColor:
                                    //           themecontroller.ContainerColor,
                                    //           child: Visibility(
                                    //             visible: isplay.value,
                                    //             child: Icon(
                                    //               Icons.play_arrow_rounded,
                                    //               color: Colors.white,
                                    //               size: 30.sp,
                                    //             ),
                                    //             replacement: Icon(
                                    //               Icons.pause,
                                    //               color: Colors.white,
                                    //               size: 30.sp,
                                    //             ),
                                    //           ),
                                    //         ),
                                    //       ),
                                    //     ),
                                    //     SizedBox(
                                    //       width: 30.sp,
                                    //     ),
                                    //     CircleAvatar(
                                    //       radius: 20.sp,
                                    //       backgroundColor:
                                    //       themecontroller.ContainerColor,
                                    //       child: Icon(
                                    //         Icons.arrow_forward_ios_rounded,
                                    //         color: Colors.white,
                                    //         size: 20.sp,
                                    //       ),
                                    //     ),
                                    //   ],
                                    // ),
                                    child: Obx(() => Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            // Show Back Arrow if previous chapter exists
                                            if (readingController
                                                        .selectedChapter
                                                        .value !=
                                                    null &&
                                                readingController
                                                        .selectedChapter
                                                        .value!
                                                        .number >
                                                    1)
                                              SpringWidget(
                                                onTap: () async {
                                                  await _stop();
                                                  await readingController
                                                      .loadPreviousChapter();
                                                  await _loadChapterAudio();
                                                  _play();
                                                },
                                                child: CircleAvatar(
                                                  radius: 20.sp,
                                                  backgroundColor:
                                                      themecontroller
                                                          .ContainerColor,
                                                  child: Icon(
                                                    Icons
                                                        .arrow_back_ios_new_rounded,
                                                    color: Colors.white,
                                                    size: 20.sp,
                                                  ),
                                                ),
                                              )
                                            else
                                              SizedBox(
                                                width: 40.sp,
                                              ),
                                            SizedBox(width: 30.sp),

                                            // Play/Pause Button
                                            SpringWidget(
                                              onTap: () {
                                                if (isPlaying.value) {
                                                  _pause();
                                                } else {
                                                  _play();
                                                }
                                              },
                                              child: Obx(() => CircleAvatar(
                                                    radius: 30.sp,
                                                    backgroundColor:
                                                        themecontroller
                                                            .ContainerColor,
                                                    child: Icon(
                                                      isPlaying.value
                                                          ? Icons.pause
                                                          : Icons
                                                              .play_arrow_rounded,
                                                      color: Colors.white,
                                                      size: 30.sp,
                                                    ),
                                                  )),
                                            ),

                                            SizedBox(width: 30.sp),

                                            // Show Forward Arrow if next chapter exists
                                            if (readingController
                                                        .selectedChapter
                                                        .value !=
                                                    null &&
                                                readingController
                                                        .selectedBook.value !=
                                                    null &&
                                                readingController
                                                        .selectedChapter
                                                        .value!
                                                        .number <
                                                    readingController
                                                        .selectedBook
                                                        .value!
                                                        .numberOfChapters)
                                              SpringWidget(
                                                onTap: () async{
                                                  await readingController
                                                      .loadNextChapter();
                                                  await _loadChapterAudio();
                                                  _play();
                                                },
                                                child: CircleAvatar(
                                                  radius: 20.sp,
                                                  backgroundColor:
                                                      themecontroller
                                                          .ContainerColor,
                                                  child: Icon(
                                                    Icons
                                                        .arrow_forward_ios_rounded,
                                                    color: Colors.white,
                                                    size: 20.sp,
                                                  ),
                                                ),
                                              )
                                            else
                                              SizedBox(
                                                width: 40.sp,
                                              ),
                                          ],
                                        )),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
              ),
            ),
          );
        });
  }
}

class biblechatHead extends StatelessWidget {
  const biblechatHead({super.key, required this.loadAudio});

  final Function() loadAudio;

  @override
  Widget build(BuildContext context) {
    final ReadingController readingController = Get.find<ReadingController>();

    return GetBuilder<ThemeHelper>(
      builder: (themecontroller) {
        return Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: themecontroller.ContainerColor,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20.sp),
              bottomRight: Radius.circular(20.sp),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.only(
              top: 80.sp,
              bottom: 10.sp,
              left: 20.sp,
              right: 20.sp,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () =>
                          _showBookSelector(context, readingController),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.2),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.4),
                          ),
                          borderRadius: BorderRadius.circular(10.sp),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 20.sp,
                          vertical: 10.sp,
                        ),
                        child: Obx(() => Text(
                              "${readingController.selectedBook.value?.name ?? ''} ${readingController.selectedChapter.value?.number ?? "1"}",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12.sp,
                              ),
                            )),
                      ),
                    ),
                    SizedBox(width: 10.sp),
                    GestureDetector(
                      onTap: () =>
                          _showTranslationSelector(context, readingController),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.2),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.4),
                          ),
                          borderRadius: BorderRadius.circular(10.sp),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 20.sp,
                          vertical: 10.sp,
                        ),
                        child: Obx(() => Text(
                              readingController
                                      .selectedTranslation.value?.shortName ??
                                  '',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12.sp,
                              ),
                            )),
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () => _showFontAdjuster(context, readingController),
                  child: SvgPicture.asset(
                    "assets/icons/TT.svg",
                    height: 17.sp,
                    width: 17.sp,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showBookSelector(BuildContext context, ReadingController controller) {
    String? expandedBookId;
    final ThemeHelper themeController = Get.find<ThemeHelper>();

    showModalBottomSheet(
      context: context,
      backgroundColor: themeController.bgcolor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      isScrollControlled: false,
      builder: (_) {
        return StatefulBuilder(
          builder: (context, setState) {
            return SingleChildScrollView(
              child: Column(
                children: controller.books.map((book) {
                  bool isExpanded = expandedBookId == book.id;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ListTile(
                        title: Text(book.name,
                            style: TextStyle(color: Colors.white)),
                        trailing: Icon(
                          isExpanded ? Icons.close : Icons.add,
                          color: Colors.white,
                        ),
                        onTap: () {
                          setState(() {
                            expandedBookId = isExpanded ? null : book.id;
                          });
                        },
                      ),
                      AnimatedSize(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        child: isExpanded
                            ? Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 12.sp, vertical: 4.sp),
                                child: Wrap(
                                  spacing: 10,
                                  runSpacing: 10,
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  alignment: WrapAlignment.center,
                                  children: List.generate(
                                    book.numberOfChapters,
                                    (index) {
                                      int chapterNum = index + 1;
                                      bool isCurrentSelected =
                                          controller.selectedBook.value?.id ==
                                                  book.id &&
                                              controller.selectedChapter
                                                      .value!.number ==
                                                  chapterNum;

                                      return GestureDetector(
                                        onTap: () async{
                                          await controller.selectBook(book);
                                          controller.selectChapter(chapterNum).then(
                                                (_) async{
                                                  await loadAudio();
                                                  Get.back();
                                          },);

                                        },
                                        child: Container(
                                          width: 35.sp,
                                          height: 35.sp,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            color: isCurrentSelected
                                                ? Colors.yellow
                                                : Colors.white12,
                                            borderRadius:
                                                BorderRadius.circular(8.sp),
                                          ),
                                          child: Text(
                                            "$chapterNum",
                                            style: TextStyle(
                                              color: isCurrentSelected
                                                  ? Colors.black
                                                  : Colors.white,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              )
                            : SizedBox.shrink(),
                      ),
                    ],
                  );
                }).toList(),
              ),
            );
          },
        );
      },
    );
  }

  void _showTranslationSelector(
      BuildContext context, ReadingController controller) {
    final ThemeHelper themeController = Get.find<ThemeHelper>();
    showModalBottomSheet(
      context: context,
      backgroundColor: themeController.bgcolor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return Obx(() => ListView.separated(
              padding: EdgeInsets.symmetric(vertical: 20.sp, horizontal: 16.sp),
              itemCount: controller.translations.length,
              separatorBuilder: (_, __) => Divider(color: Colors.white12),
              itemBuilder: (context, index) {
                final translation = controller.translations[index];
                final isSelected =
                    controller.selectedTranslation.value?.id == translation.id;

                return GestureDetector(
                  onTap: () async{
                    await controller.selectTranslation(translation).then((_) async{
                      Get.back();
                      await loadAudio();
                    },);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 12.sp),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          isSelected
                              ? Icons.check_circle
                              : Icons.radio_button_unchecked,
                          color: isSelected
                              ? Colors.white
                              : Colors.white.withOpacity(0.4),
                          size: 20.sp,
                        ),
                        SizedBox(width: 12.sp),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                translation.name,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14.sp,
                                ),
                              ),
                              SizedBox(height: 6.sp),
                              Text(
                                translation.language,
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.8),
                                  fontSize: 12.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ));
      },
    );
  }

  void _showFontAdjuster(BuildContext context, ReadingController controller) {
    final ThemeHelper themeController = Get.find<ThemeHelper>();
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      backgroundColor: themeController.bgcolor,
      builder: (context) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.sp, vertical: 20.sp),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Obx(
                () => Text(
                  "Adjust the font size",
                  style: TextStyle(
                    fontSize: controller.verseFontSize.value,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 20.sp),
              Obx(() => SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      activeTrackColor: Colors.white,
                      inactiveTrackColor: Colors.white24,
                      thumbColor: Colors.white,
                      overlayColor: Colors.white30,
                      trackHeight: 2.0,
                    ),
                    child: Slider(
                      value: controller.verseFontSize.value,
                      min: 12,
                      max: 24,
                      divisions: 6,
                      label: "${controller.verseFontSize.value.toInt()}",
                      onChanged: (value) {
                        controller.updateFontSize(value);
                      },
                    ),
                  )),
              SizedBox(height: 10.sp),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text("T",
                      style: TextStyle(color: Colors.white, fontSize: 12)),
                  Text("T",
                      style: TextStyle(color: Colors.white, fontSize: 20)),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class biblechatplayer extends StatelessWidget {
  const biblechatplayer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeHelper>(
        initState: (state) {},
        builder: (themecontroller) {
          return Container(
            width: double.infinity,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.transparent,
                    const Color.fromARGB(255, 6, 54, 93)
                    // .withValues(alpha: 0.9),
                  ],
                ),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.sp),
                    topRight: Radius.circular(20.sp))),
            child: Padding(
              padding: EdgeInsets.only(
                  top: 30.sp, bottom: 80.sp, left: 20.sp, right: 20.sp),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.fast_rewind_rounded,
                    color: Colors.white,
                    size: 30.sp,
                  ),
                  SizedBox(
                    width: 30.sp,
                  ),
                  Icon(
                    Icons.play_arrow_rounded,
                    color: Colors.white,
                    size: 30.sp,
                  ),
                  SizedBox(
                    width: 30.sp,
                  ),
                  Icon(
                    Icons.fast_forward_rounded,
                    color: Colors.white,
                    size: 30.sp,
                  ),
                ],
              ),
            ),
          );
        });
  }
}
