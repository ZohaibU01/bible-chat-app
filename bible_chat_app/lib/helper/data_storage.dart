import 'dart:developer';
import 'package:bible_chat_app/MVC/model/userModel.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DataStroge extends GetxController {
  static DataStroge? _instance;
  static DataStroge get getInstance => _instance ??= DataStroge();
  late SharedPreferences _pref;

  late Map<String, dynamic> headersMap;

  Future<SharedPreferences> _initPrefs() async {
    _pref = await SharedPreferences.getInstance();
    return _pref;
  }

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  static RxString userName = ''.obs;
  static RxString userEmail = ''.obs;
  static RxString userToken = ''.obs;
  static RxString userPhoto = ''.obs;
  static RxString userAgeRange = ''.obs;
  static RxString userDenomination = ''.obs;
  static RxString userChurch = ''.obs;
  static RxString fcmToken = ''.obs;
  static RxString currentUserId = ''.obs;
  static RxBool onboardingComplete = false.obs;

  Future initiateSession() async {
    log("initiateSession called");
    await _initPrefs();
  }

  Future<void> insertUserData(UserModel userData, String Token) async {
    final SharedPreferences prefs = await _prefs;

    await prefs.setString('token', Token);
    await prefs.setString('id', userData.userId.toString());
    await prefs.setString('userName', userData.userName.toString());
    await prefs.setString('email', userData.userEmail.toString());
    // await prefs.setString('userAgeRange', userData.userAgeRange.toString());
    // await prefs.setString('userChurch', userData.userChurch.toString());
    // await prefs.setString(
    //     'userDenomination', userData.userDenomination.toString());
    // await prefs.setString('userphoto', userData.userphoto.toString());

    // Initiate the session
    await initiateSession();

    userName.value = userData.userName.toString();
    userEmail.value = userData.userEmail.toString();
    userToken.value = Token;
    currentUserId.value = userData.userId.toString();
    userDenomination.value = userData.userDenomination.toString();
    userAgeRange.value = userData.userAgeRange.toString();
    userChurch.value = userData.userChurch.toString();
    userPhoto.value = userData.userphoto.toString();
  }

  insertDeviceAndFCMInformation({FcmToken, deviceID}) async {
    final SharedPreferences? prefs = await _prefs;
    await prefs?.setString('fcmToken', FcmToken);
    await prefs?.setString('DeviceID', deviceID);

    fcmToken.value = FcmToken;
  }

  Future setTokenAuth(String authToken) async {
    await _initPrefs();
    _pref.setString('token', authToken);
    await initiateSession();
    return true;
  }

  Future doneOnboarding() async {
    _pref.setString('onboardingComplete', "true");
    onboardingComplete.value = true;
  }

  getUserData() async {
    final SharedPreferences? prefs = await _prefs;
    userToken.value = prefs?.getString('token') ?? "";
    userName.value = prefs?.getString('userName') ?? "";
    userEmail.value = prefs?.getString('email') ?? "";
    userAgeRange.value = prefs?.getString('userAgeRange') ?? "";
    userChurch.value = prefs?.getString('userChurch') ?? "";
    userDenomination.value = prefs?.getString('userDenomination') ?? "";
    currentUserId.value = prefs?.getString('id') ?? "";
    String onboardingStatus = prefs?.getString('onboardingComplete') ?? "false";
    onboardingComplete.value = onboardingStatus == "true";
  }

  updateUserData(UserModel userData) async {
    final SharedPreferences? prefs = await _prefs;

    if (userData.userphoto != "") {
      await prefs?.setString('photo', userData.userphoto.toString());
    }
    if (userData.userName.toString() != '') {
      await prefs?.setString('userName', userData.userName.toString());

      userName.value = userData.userName.toString();
    }
    if (userData.userAgeRange.toString() != '') {
      await prefs?.setString('userAgeRange', userData.userAgeRange.toString());

      userAgeRange.value = userData.userAgeRange.toString();
    }
    if (userData.userDenomination.toString() != '') {
      await prefs?.setString(
          'userDenomination', userData.userDenomination.toString());

      userDenomination.value = userData.userDenomination.toString();
    }
    if (userData.userChurch.toString() != '') {
      await prefs?.setString('userChurch', userData.userChurch.toString());

      userChurch.value = userData.userChurch.toString();
    }
  }

  logout() async {
    final SharedPreferences prefs = await _prefs;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
    await initiateSession();

    userName.value = '';
    userEmail.value = '';
    userToken.value = '';
    currentUserId.value = '';
    // var tokenuser = prefs.getString('token') ?? "";
    log('Shared Preference Clear $userToken');
  }
}
