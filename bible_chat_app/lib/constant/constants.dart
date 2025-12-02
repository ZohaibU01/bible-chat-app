import 'package:flutter_screenutil/flutter_screenutil.dart';

class Constants {
  static const double screenPadding = 20;
  static const String currency = '\$';
  static var API_HOST = "";
  static var socket_host = "";
  static var baseUrl = "https://genesisbackend.hboxdigital.website";

  static const String mapApiKey = "AIzaSyAcC8RkFxv3vKg0mEXtqSrZnL32imnLm30";

  static final String PlaceApi =
      'https://maps.googleapis.com/maps/api/place/autocomplete/json';

  static final signInWithGoogleApi = "$API_HOST/signup-with-google";
  static final signInWithAppleApi = "$API_HOST/signup-with-apple";
  static final QuestionsApi = "$API_HOST/questions";
  static final SubmitanswerApi = "$API_HOST/submit-answer";
  static final updateProfileApi = "$API_HOST/profile/update-profile";
  
  
}
