import 'dart:async';
import 'package:bible_chat_app/MVC/model/QuestionModel.dart';
import 'package:bible_chat_app/MVC/view/onboarding/loginScreen.dart';
import 'package:bible_chat_app/MVC/view/onboarding/reviewScreen.dart';
import 'package:bible_chat_app/MVC/view/onboarding/welcomeScreen.dart';
import 'package:bible_chat_app/components/BottomNav.dart';
import 'package:bible_chat_app/constant/constants.dart';
import 'package:bible_chat_app/constant/navigation.dart';
import 'package:bible_chat_app/data/mockData.dart';
import 'package:bible_chat_app/helper/data_storage.dart';
import 'package:bible_chat_app/services/ApiServices.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class Onboardingcontroller extends GetxController {
//---splash screen
  RxBool showlogo = false.obs;
  RxDouble progressLine = 0.0.obs;
  RxDouble profileloading = 0.0.obs;
  RxDouble Goalsloading = 0.0.obs;
  RxDouble Personalizationloading = 0.0.obs;

//---text blinking screen
  RxBool blink = false.obs;
  RxString blinkText = "Study Scripture".obs;

//---onboarding chat screen
  RxBool showmsg = false.obs;
  RxBool showSharebtn = false.obs;

//---denomination screen
  RxInt Selected_denomination = 0.obs;

//---Bible Version screen
  RxInt Selected_BibleVersion = 0.obs;

//---Slider index
  RxInt currentSliderindex = 0.obs;

//---Age screen
  RxInt Selected_Age = 0.obs;

//---struggle Screen
  final StruggleController = TextEditingController();

  List<String> PlanList = ["monthly", "yearly"];
  RxInt SelectedPlan = 0.obs;

  RxInt questionid = 0.obs;
  RxString answers = "".obs;

//---plans Screen
  RxBool isfreeApp = false.obs;

  var questions = <QuestionModel>[].obs;
  var isLoading = false.obs;

  void showlogo_event(BuildContext context) async {
    Timer(
      Duration(seconds: 1),
      () {
        showlogo.value = true;
      },
    );

    Timer(
      Duration(seconds: 3),
      () {
        Navigation.getInstance
            .pagePushAndReplaceNavigationfade(context, Welcomescreen());
      },
    );
  }

  void blinkAnimation(BuildContext context) {
    int index = 0;
    Timer.periodic(
      const Duration(milliseconds: 500),
      (timer) async {
        if (index >= MockData.onboardingList.length) {
          timer.cancel();

          if (DataStroge.userToken.value == "") {
            Navigation.getInstance
                .pagePushAndReplaceNavigationfade(context, Loginscreen());
          } else {
            if (DataStroge.onboardingComplete.value) {
              await getAllQuestions();
              Navigation.getInstance
                  .pagePushAndReplaceNavigationfade(context, BottomNavBar());
            } else {
              await getAllQuestions();
              Navigation.getInstance
                  .pagePushAndReplaceNavigationfade(context, Reviewscreen());
            }
          }
          print('complete');
          return;
          // index = 0;
        }

        blink.value = !blink.value;
        blinkText.value = MockData.onboardingList[index];
        index++;
      },
    );
  }

  Future<void> getAllQuestions() async {
    try {
      isLoading.value = true;

      final response = await ApiService().getRequest(Constants.QuestionsApi);

      if (response?.statusCode == 200) {
        final data = response?.data['data'] as List;
        questions.value = data.map((e) => QuestionModel.fromJson(e)).toList();
        print("getAllQuestions Api ✅");
      } else {
        Fluttertoast.showToast(msg: "Failed to fetch questions.");
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Something went wrong: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> Submitanswer() async {
    try {
      isLoading.value = true;

      var body = {
        "question_id": questionid.value,
        "answer_text": answers.value
      };
      print("Body:$body");
      final response = await ApiService()
          .postRequestWithToken(Constants.SubmitanswerApi, body);

      if (response?.statusCode == 200) {
        print("Submitanswer Api ✅");
        Fluttertoast.showToast(msg: response?.data["message"]);
      } else {
        Fluttertoast.showToast(msg: "Failed to submit answer");
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Something went wrong: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
