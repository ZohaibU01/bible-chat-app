import 'dart:convert';
import 'package:bible_chat_app/MVC/controller/prayerController.dart';
import 'package:bible_chat_app/constant/constants.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class Homecontroller extends GetxController {
  // Home screen observables
  RxDouble progressLine = 0.0.obs;
  RxInt currentSliderindex = 0.obs;
  RxDouble journeyprogressLine = 0.0.obs;
  RxDouble journeyslider = 50.0.obs;
  RxBool showNextbtn = false.obs;

  // Today plan
  Rx<TodayPlan?> todayPlan = Rx<TodayPlan?>(null);
  RxBool isLoadingTodayPlan = false.obs;

  // Past week plans
  RxMap<String, TodayPlan> pastWeekPlans = <String, TodayPlan>{}.obs;

  // Currently selected plan (can be today or a date-based plan)
  Rx<TodayPlan?> selectedPlan = Rx<TodayPlan?>(null);

  @override
  void onInit() {
    getTodayPlan();
    super.onInit();
  }

  Future<void> getTodayPlan() async {
    isLoadingTodayPlan.value = true;
    try {
      final response = await http.get(Uri.parse("${Constants.baseUrl}/api/devotional-of-the-day"));

      if (response.statusCode == 200) {
        final jsonBody = json.decode(utf8.decode(response.bodyBytes));
        TodayPlan plan = TodayPlan.fromJson(jsonBody["data"]);
        todayPlan.value = plan;
        selectedPlan.value = plan;
      } else {
        print("Error fetching today plan: \${response.body}");
      }
    } catch (e) {
      print("Exception in getTodayPlan: \$e");
    } finally {
      isLoadingTodayPlan.value = false;
    }
  }

  Future<void> getPastPlanForDate(String date) async {
    try {

      final response = await http.get(
        Uri.parse("${Constants.baseUrl}/api/past-devotional/$date"),
        headers: {
          'Authorization': 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MiwiaWF0IjoxNzQ0MzI5OTYwfQ.zzXIlRhEVTahN_4v87Ox8-Bjv2MVd-9SR-At06fW_Tk',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final decoded = json.decode(utf8.decode(response.bodyBytes));
        final List<dynamic> data = [decoded['data']];
        if (data.isNotEmpty) {
          final plan = TodayPlan.fromJson(data[0]);
          pastWeekPlans[date] = plan;
        }
      } else {
        print("Error fetching past plan for \$date: \${response.body}");
      }
    } catch (e) {
      print("Exception in getPastPlanForDate(\$date): \$e");
    }
  }

  void onPlanChanged(String date) async {
    if (date == _todayDateString()) {
      selectedPlan.value = todayPlan.value;
    } else if (pastWeekPlans.containsKey(date)) {
      selectedPlan.value = pastWeekPlans[date];
    } else {
      await getPastPlanForDate(date);
      selectedPlan.value = pastWeekPlans[date];
    }
  }

  String _todayDateString() {
    final now = DateTime.now();
    return "${now.year.toString().padLeft(4, '0')}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}";
  }
}

// Models
class TodayPlan {
  final List<Devotional> devotionals;
  final Prayer prayer;

  TodayPlan({required this.devotionals, required this.prayer});

  factory TodayPlan.fromJson(Map<String, dynamic> json) {
    return TodayPlan(
      devotionals: List<Devotional>.from(json['devotionals'].map((x) => Devotional.fromJson(x))),
      prayer: Prayer.fromJson(json['prayer']),
    );
  }
}

class Devotional {
  final int id;
  final String verseReference;
  final String devotionalText;
  final DateTime createdAt;

  Devotional({
    required this.id,
    required this.verseReference,
    required this.devotionalText,
    required this.createdAt,
  });

  factory Devotional.fromJson(Map<String, dynamic> json) {
    return Devotional(
      id: json['id'],
      verseReference: json['verse_reference'],
      devotionalText: json['devotional_text'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}

// class Prayer {
//   final int prayerId;
//   final String title;
//   final String description;
//   final String coverImg;
//   final int isPinned;
//   final int hasMultiplePrayer;
//   final DateTime createdAt;
//   final DateTime updatedAt;
//
//   Prayer({
//     required this.prayerId,
//     required this.title,
//     required this.description,
//     required this.coverImg,
//     required this.isPinned,
//     required this.hasMultiplePrayer,
//     required this.createdAt,
//     required this.updatedAt,
//   });
//
//   factory Prayer.fromJson(Map<String, dynamic> json) {
//     return Prayer(
//       prayerId: json['PrayerID'],
//       title: json['Title'],
//       description: json['Description'],
//       coverImg: Constants.baseUrl + json['CoverImg'],
//       isPinned: json['IsPinned'],
//       hasMultiplePrayer: json['HasMultiplePrayer'],
//       createdAt: DateTime.parse(json['CreatedAt']),
//       updatedAt: DateTime.parse(json['UpdatedAt']),
//     );
//   }
// }
