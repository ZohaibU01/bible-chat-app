import 'dart:convert';
import 'package:bible_chat_app/constant/constants.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../view/prayer/prayer_tab_screen.dart';

class PrayerController extends GetxController {
  RxString lastPlayedStepUrl = "".obs;

  final baseUrl = "${Constants.baseUrl}/api";

  Rx<Prayer?> selectedPrayer = Rx<Prayer?>(null);
  Rx<PrayerDetail?> selectedPrayerDetail = Rx<PrayerDetail?>(null);

  void selectPrayer(Prayer prayer, PrayerDetail detail) {
    selectedPrayer.value = prayer;
    selectedPrayerDetail.value = detail;
  }

  PrayerDetail? getNextPrayerDetail() {
    final prayer = selectedPrayer.value;
    final current = selectedPrayerDetail.value;
    if (prayer == null || current == null) return null;

    final index = prayer.details.indexWhere((d) => d.id == current.id);
    if (index != -1 && index < prayer.details.length - 1) {
      return prayer.details[index + 1];
    }
    return null;
  }

  PrayerDetail? getPreviousPrayerDetail() {
    final prayer = selectedPrayer.value;
    final current = selectedPrayerDetail.value;
    if (prayer == null || current == null) return null;

    final index = prayer.details.indexWhere((d) => d.id == current.id);
    if (index > 0) {
      return prayer.details[index - 1];
    }
    return null;
  }

  RxList<Prayer> pinnedPrayers = <Prayer>[].obs;
  RxList<PrayerCategory> categories = <PrayerCategory>[].obs;
  RxMap<String, List<Prayer>> prayersByCategory = <String, List<Prayer>>{}.obs;

  RxString searchQuery = "".obs;

  @override
  void onInit() {
    fetchAllPrayers();
    super.onInit();
  }

  void updateSearchQuery(String query) {
    searchQuery.value = query.trim().toLowerCase();
  }

  Future<void> fetchAllPrayers() async {
    try {
      final response = await http.get(Uri.parse("$baseUrl/prayers/getAll"));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final data = jsonData['data'];

        // Pinned prayers
        pinnedPrayers.value = List<Prayer>.from(
          data['pinnedPrayers'].map((x) => Prayer.fromJson(x)),
        );

        // Categories
        categories.value = List<PrayerCategory>.from(
          data['categories'].map((x) => PrayerCategory.fromJson(x)),
        );

        // Prayers by category
        final rawMap = data['prayersByCategory'] as Map<String, dynamic>;
        prayersByCategory.value = rawMap.map((key, value) => MapEntry(
          key,
          List<Prayer>.from(value.map((x) => Prayer.fromJson(x))),
        ));
      } else {
        print("Failed to fetch prayers: ${response.body}");
      }
    } catch (e) {
      print("Error fetching prayers: $e");
    }
  }
}

class Prayer {
  final int id;
  final String title;
  final String description;
  final String coverImg;
  final bool isPinned;
  final bool hasMultiplePrayer;
  final List<PrayerCategory> categories;
  final List<PrayerDetail> details;

  Prayer({
    required this.id,
    required this.title,
    required this.description,
    required this.coverImg,
    required this.isPinned,
    required this.hasMultiplePrayer,
    required this.categories,
    required this.details,
  });

  factory Prayer.fromJson(Map<String, dynamic> json) => Prayer(
    id: json['PrayerID'],
    title: json['Title'],
    description: json['Description'],
    coverImg: "https://genesisbackend.hboxdigital.website${json['CoverImg']}",
    isPinned: json['IsPinned'] == 1,
    hasMultiplePrayer: json['HasMultiplePrayer'] == 1,
    categories: List<PrayerCategory>.from(
      json['categories'].map((x) => PrayerCategory.fromJson(x)),
    ),
    details: List<PrayerDetail>.from(
      json['details'].map((x) => PrayerDetail.fromJson(x)),
    ),
  );
}

class PrayerDetail {
  final int id;
  final String audioUrl;
  final String prayerText;
  final String featuring;
  final String bckgrndImgUrl;
  final String description;

  PrayerDetail({
    required this.id,
    required this.audioUrl,
    required this.prayerText,
    required this.featuring,
    required this.bckgrndImgUrl,
    required this.description,
  });

  factory PrayerDetail.fromJson(Map<String, dynamic> json) => PrayerDetail(
    id: json['PrayerDetailID'],
    audioUrl: "${Constants.baseUrl}${json['AudioUrl']}",
    prayerText: json['PrayerText'],
    featuring: json['Featuring'],
    bckgrndImgUrl:
    "${Constants.baseUrl}${json['BckgrndImgUrl']}",
    description: json['Description'],
  );
}

class PrayerCategory {
  final int id;
  final String name;

  PrayerCategory({required this.id, required this.name});

  factory PrayerCategory.fromJson(Map<String, dynamic> json) => PrayerCategory(
    id: json['CategoryID'],
    name: json['Name'],
  );
}
