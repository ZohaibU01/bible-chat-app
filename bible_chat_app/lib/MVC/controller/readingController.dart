import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ReadingController extends GetxController {
  final baseUrl = "https://bible.helloao.org";

  // Observables
  RxList<Translation> translations = <Translation>[].obs;
  Rx<Translation?> selectedTranslation = Rx<Translation?>(null);

  RxList<Book> books = <Book>[].obs;
  Rx<Book?> selectedBook = Rx<Book?>(null);
  Rx<ChapterMetadata?> selectedChapter = Rx<ChapterMetadata?>(null);

  RxList<ChapterVerse> verses = <ChapterVerse>[].obs;
  RxBool isLoading = false.obs;
  RxDouble verseFontSize = 14.0.obs;

  @override
  void onInit() {
    fetchTranslations();
    loadFontSize();
    super.onInit();
  }

  Future<void> fetchTranslations() async {
    try {
      isLoading.value = true;
      final response = await http.get(Uri.parse("$baseUrl/api/available_translations.json"));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final translationList = List<Map<String, dynamic>>.from(data['translations']);

        translations.value = translationList.map((json) => Translation.fromJson(json)).toList();

        if (translations.isNotEmpty) {
          selectTranslation(translations.firstWhereOrNull((tr) => tr.id == "BSB",) ?? translations.first);
        }
      }
    } catch (e) {
      print("Error fetching translations: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> selectTranslation(Translation translation) async {
    selectedTranslation.value = translation;
    await fetchBooks(translation);
  }

  Future<void> fetchBooks(Translation translation) async {
    try {
      final response = await http.get(Uri.parse("$baseUrl${translation.listOfBooksApiLink}"));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final bookList = List<Map<String, dynamic>>.from(data['books']);
        books.value = bookList.map((json) => Book.fromJson(json)).toList();

        if (books.isNotEmpty) {
          selectBook(books.first);
        }
      }
    } catch (e) {
      print("Error fetching books: $e");
    }
  }

  Future<void> selectBook(Book book) async {
    selectedBook.value = book;
    // await fetchChapter(book.firstChapterApiLink);
    selectChapter(1);
  }

  Future<void> fetchChapter(String chapterApiLink) async {
    try {
      isLoading.value = true;
      final response = await http.get(Uri.parse("$baseUrl$chapterApiLink"));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> contentList = data['chapter']['content'];

        verses.value = contentList
            .where((e) => e['type'] == 'verse')
            .map<ChapterVerse>((verse) => ChapterVerse(
          number: verse['number'],
          text: verse['content'].join(" "),
        ))
            .toList();
      }
    } catch (e) {
      print("Error fetching chapter: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> selectChapter(int chapterNumber) async {
    final book = selectedBook.value;
    final translation = selectedTranslation.value;
    if (book == null || translation == null) return;

    final chapterApiLink = "/api/${translation.id}/${book.id}/$chapterNumber.json";

    try {
      isLoading.value = true;
      final response = await http.get(Uri.parse("$baseUrl$chapterApiLink"));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final contentList = data['chapter']['content'];

        verses.value = contentList
            .where((e) => e['type'] == 'verse')
            .map<ChapterVerse>((verse) => ChapterVerse(
          number: verse['number'],
          text: verse['content']
              .whereType<String>()
              .join(" "), // Skip note objects
        ))
            .toList();

        selectedChapter.value = ChapterMetadata(
          number: data['chapter']['number'],
          apiLink: data['thisChapterLink'],
          audioLinks: Map<String, String>.from(data['thisChapterAudioLinks']),
          nextChapterLink: data['nextChapterApiLink'],
          nextChapterAudioLinks: data['nextChapterAudioLinks'] != null
              ? Map<String, String>.from(data['nextChapterAudioLinks'])
              : null,
          previousChapterLink: data['previousChapterApiLink'],
          previousChapterAudioLinks: data['previousChapterAudioLinks'] != null
              ? Map<String, String>.from(data['previousChapterAudioLinks'])
              : null,
        );
      }
    } catch (e) {
      print("Error fetching chapter: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadNextChapter() async{
    final nextLink = selectedChapter.value?.nextChapterLink;
    if (nextLink != null) {
      await selectChapter(selectedChapter.value!.number + 1);
    }
  }

  Future<void> loadPreviousChapter() async{
    final prevLink = selectedChapter.value?.previousChapterLink;
    if (prevLink != null) {
      await selectChapter(selectedChapter.value!.number - 1);
    }
  }

  Future<void> loadFontSize() async {
    final prefs = await SharedPreferences.getInstance();
    double savedFontSize = prefs.getDouble('verseFontSize') ?? 14.0;
    verseFontSize.value = savedFontSize;
  }

  Future<void> saveFontSize(double size) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('verseFontSize', size);
    verseFontSize.value = size;
  }

  void updateFontSize(double newSize) {
    saveFontSize(newSize);
  }

}

// Models
class Translation {
  final String id, name, language, listOfBooksApiLink,shortName;

  Translation({
    required this.id,
    required this.name,
    required this.language,
    required this.listOfBooksApiLink,
    required this.shortName,
  });

  factory Translation.fromJson(Map<String, dynamic> json) {
    return Translation(
      id: json['id'],
      name: json['name'],
      language: json['language'],
      listOfBooksApiLink: json['listOfBooksApiLink'],
      shortName: json['shortName'],
    );
  }
}

class Book {
  final String id, name, firstChapterApiLink;
  final int numberOfChapters;

  Book({
    required this.id,
    required this.name,
    required this.firstChapterApiLink,
    required this.numberOfChapters,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'],
      name: json['name'],
      firstChapterApiLink: json['firstChapterApiLink'],
      numberOfChapters : json['numberOfChapters'],
    );
  }
}

class ChapterVerse {
  final int number;
  final String text;

  ChapterVerse({required this.number, required this.text});
}

class ChapterMetadata {
  final int number;
  final String apiLink;
  final Map<String, String> audioLinks;
  final String? nextChapterLink;
  final Map<String, String>? nextChapterAudioLinks;
  final String? previousChapterLink;
  final Map<String, String>? previousChapterAudioLinks;

  ChapterMetadata({
    required this.number,
    required this.apiLink,
    required this.audioLinks,
    this.nextChapterLink,
    this.nextChapterAudioLinks,
    this.previousChapterLink,
    this.previousChapterAudioLinks,
  });
}

