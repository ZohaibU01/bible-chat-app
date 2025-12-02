import 'package:bible_chat_app/MVC/controller/prayerController.dart';
import 'package:bible_chat_app/MVC/view/prayer/readingScreen.dart';
import 'package:bible_chat_app/components/image_widget.dart';
import 'package:bible_chat_app/components/spring_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart' as rx;

class AudioPlayerScreen extends StatefulWidget {
  const AudioPlayerScreen({super.key});

  @override
  State<AudioPlayerScreen> createState() => _AudioPlayerScreenState();
}

class _AudioPlayerScreenState extends State<AudioPlayerScreen> {
  final PrayerController prayerController = Get.find<PrayerController>();
  final AudioPlayer _audioPlayer = AudioPlayer();

  Stream<DurationState> get _durationStateStream =>
      rx.Rx.combineLatest2<Duration, Duration?, DurationState>(
        _audioPlayer.positionStream,
        _audioPlayer.durationStream,
            (position, duration) => DurationState(position, duration ?? Duration.zero),
      );

  @override
  void initState() {
    super.initState();
    _loadCurrentAudio();
  }

  Future<void> _loadCurrentAudio() async {
    final currentDetail = prayerController.selectedPrayerDetail.value;
    if (currentDetail != null) {
      await _audioPlayer.setUrl(currentDetail.audioUrl);
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final prayerDetail = prayerController.selectedPrayerDetail.value!;
    final backgroundImageUrl = prayerDetail.bckgrndImgUrl;

    return Obx(()=> Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: ImageWidget(
              imageUrl: prayerController.selectedPrayerDetail.value!.bckgrndImgUrl,
              boxfit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.center,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.3),
                    Colors.black.withOpacity(0.5),
                    Colors.black.withOpacity(0.7),
                    Colors.black.withOpacity(1.0),
                  ],
                ),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _buildHeader(),
              const Spacer(),
              _buildPlayerContent(),
            ],
          ),
        ],
      ),
    ));
  }

  Widget _buildHeader() {
    var height = Get.height * 0.1;
    return SizedBox(
      height: height,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: [
          Positioned(
            top: 0.sp,
            left: 15.sp,
            child: _buildCircularIcon(
                Icons.arrow_back_ios_new_rounded, () => Get.back()),
          ),
          Positioned(
            top: 0.sp,
            right: 15.sp,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 45.sp, horizontal: 10.sp),
              child: SpringWidget(
                onTap: () {},
                child: Container(
                  padding: EdgeInsets.all(5.sp),
                  decoration: BoxDecoration(
                    color: Colors.black
                        .withOpacity(0.4), // Black background with transparency
                    shape: BoxShape.circle,
                  ),
                  child: SvgPicture.asset(
                    "assets/icons/share_icon.svg",
                    color: Colors.white,
                    height: 14.sp,
                    width: 14.sp,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlayerContent() {
    final prayerDetail = prayerController.selectedPrayerDetail.value!;
    final backgroundImageUrl = prayerDetail.bckgrndImgUrl;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20.sp),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30.sp)),
        color: Colors.transparent,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                prayerDetail.featuring,
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              SpringWidget(
                onTap: () {
                  Get.to(() => ReadingDetailScreen(
                    backgroundImageUrl: backgroundImageUrl,
                    prayerDetail: prayerDetail,
                  ));
                },
                child: SvgPicture.asset(
                  "assets/icons/bookread.svg",
                  height: 20.sp,
                  width: 20.sp,
                ),
              )
            ],
          ),
          SizedBox(height: 6.sp),
          Text(
            prayerDetail.description,
            style: TextStyle(color: Colors.white.withOpacity(0.9), fontSize: 13.sp),
          ),
          SizedBox(height: 16.sp),
          StreamBuilder<DurationState>(
            stream: _durationStateStream,
            builder: (context, snapshot) {
              final durationState = snapshot.data;
              final position = durationState?.position ?? Duration.zero;
              final total = durationState?.total ?? Duration.zero;

              return Column(
                children: [
                  Slider(
                    value: position.inSeconds.toDouble().clamp(0, total.inSeconds.toDouble()),
                    min: 0,
                    max: total.inSeconds.toDouble(),
                    activeColor: Colors.white,
                    inactiveColor: Colors.white24,
                    onChanged: (value) {
                      _audioPlayer.seek(Duration(seconds: value.toInt()));
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(_formatDuration(position), style: TextStyle(color: Colors.white, fontSize: 12.sp)),
                      Text(_formatDuration(total), style: TextStyle(color: Colors.white, fontSize: 12.sp)),
                    ],
                  ),
                ],
              );
            },
          ),
          SizedBox(height: 10.sp),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildControlIcon(Icons.skip_previous_rounded, onTap: _playPrevious),
              StreamBuilder<PlayerState>(
                stream: _audioPlayer.playerStateStream,
                builder: (context, snapshot) {
                  final isPlaying = snapshot.data?.playing ?? false;
                  final processingState = snapshot.data?.processingState;

                  if (processingState == ProcessingState.loading || processingState == ProcessingState.buffering) {
                    return CircularProgressIndicator(color: Colors.white);
                  } else if (isPlaying) {
                    return _buildControlIcon(Icons.pause_rounded, size: 34.sp, onTap: _audioPlayer.pause);
                  } else {
                    return _buildControlIcon(Icons.play_arrow_rounded, size: 34.sp, onTap: _audioPlayer.play);
                  }
                },
              ),
              _buildControlIcon(Icons.skip_next_rounded, onTap: _playNext),
              _buildControlIcon(Icons.refresh, onTap: () => _audioPlayer.seek(Duration.zero)),
            ],
          ),
          SizedBox(height: 40.sp),
        ],
      ),
    );
  }

  Future<void> _playNext() async {
    final next = prayerController.getNextPrayerDetail();
    if (next != null) {
      prayerController.selectPrayer(prayerController.selectedPrayer.value!, next);
      await _audioPlayer.setUrl(next.audioUrl);
    }
  }

  Future<void> _playPrevious() async {
    final previous = prayerController.getPreviousPrayerDetail();
    if (previous != null) {
      prayerController.selectPrayer(prayerController.selectedPrayer.value!, previous);
      await _audioPlayer.setUrl(previous.audioUrl);
    }
  }

  /// **Reusable Circular Icon Button**
  Widget _buildCircularIcon(IconData icon, VoidCallback onTap) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 45.sp, horizontal: 10.sp),
      child: SpringWidget(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(4.sp),
          decoration: BoxDecoration(
            color: Colors.black
                .withOpacity(0.4), // Black background with transparency
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: Colors.white,
            size: 16.sp,
          ),
        ),
      ),
    );
  }

  Widget _buildControlIcon(IconData icon, {double? size, VoidCallback? onTap}) {
    return SpringWidget(
      onTap: onTap ?? () {},
      child: Icon(icon, color: Colors.white, size: size ?? 24.sp),
    );
  }

  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }
}

class DurationState {
  final Duration position;
  final Duration total;

  DurationState(this.position, this.total);
}