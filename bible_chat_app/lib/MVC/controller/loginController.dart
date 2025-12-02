import 'package:bible_chat_app/MVC/model/userModel.dart';
import 'package:bible_chat_app/MVC/view/onboarding/reviewScreen.dart';
import 'package:bible_chat_app/constant/constants.dart';
import 'package:bible_chat_app/constant/navigation.dart';
import 'package:bible_chat_app/helper/data_storage.dart';
import 'package:bible_chat_app/services/ApiServices.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class Logincontroller extends GetxController {
  RxBool isLoading = false.obs;
  RxBool appleSignLoading = false.obs;
  RxBool GoogleSignLoading = false.obs;

  final usernameController = TextEditingController().obs;
  final UserAgeController = TextEditingController().obs;
  final UserDenominationController = TextEditingController().obs;
  final UserChurchController = TextEditingController().obs;

//----------------------Sign Up WITH apple----------------
  sign_in_with_apple(BuildContext context) async {
    try {
      appleSignLoading.value = true;
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      print(credential);
      appleSignLoading.value = false;
      Navigation.getInstance
          .RightToLeft_PageNavigation(context, Reviewscreen());
    } catch (e) {
      if (e is SignInWithAppleAuthorizationException) {
        print("Apple Sign-In Error Code: ${e.code}");
        print("Message: ${e.message}");
        appleSignLoading.value = false;
      } else {
        appleSignLoading.value = false;
        print("Other error: $e");
      }
    }
  }

  //----------------------Sign Up WITH Google----------------
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> signUpWithGoogle(BuildContext context) async {
    try {
      GoogleSignLoading.value = true;
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        GoogleSignLoading.value = false;
        return;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
          await auth.signInWithCredential(credential);

      final User? user = userCredential.user;

      if (user != null) {
        print('User signed in with Google: ${user.displayName}');

        final String? email = user.email;
        final String? name = user.displayName;
        final String? image = user.photoURL;
        final String? uid = user.uid;
        print(user);

        if (email != null && name != null) {
          final body = {
            "googleId": uid,
            "email": email,
            "name": name,
            "fcmToken": DataStroge.fcmToken.value
          };
          await login(context, body);
        } else {
          print('Email or Name is missing. Unable to send data to API.');
        }
      } else {
        print('Failed to sign in with Google.');
      }

      GoogleSignLoading.value = false;
    } catch (e) {
      GoogleSignLoading.value = false;
      print('Error during Google sign-in: $e');
    }
  }

  Future<void> login(BuildContext context, Map<String, dynamic> body) async {
    try {
      final response = await ApiService()
          .postRequest(Constants.signInWithGoogleApi, data: body);

      if (response?.statusCode == 200) {
        final token = response?.data['data']['auth_token'];
        final user = response?.data['data']['user'];

        print("✅ Token: $token");
        print("👤 User: $user");
        var userData = UserModel.loginfromJson(response?.data['data']['user']);
        // Create a User object from the response
        // final userObj = User.fromMap(user);

        // Save token & user in SharedPreferences
        await DataStroge.getInstance.insertUserData(userData, token);
        Fluttertoast.showToast(msg: response?.data['message']);

        Navigation.getInstance
            .RightToLeft_PageNavigation(context, Reviewscreen());
      } else {
        Fluttertoast.showToast(msg: "Invalid credentials");
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Something went wrong: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateProfile(BuildContext context) async {
    try {
      // if (filePath.isEmpty) {
      //   Fluttertoast.showToast(msg: "Please select a file to upload.");
      //   return;
      // }
      var data = {
        'name': usernameController.value.text,
        'email': DataStroge.userEmail.value,
        'church': UserChurchController.value.text,
      };
      // filePath: '/path/to/your/file.jpg', // Pass the file path if uploading a file

      final response = await ApiService()
          .putRequestWithFormData(Constants.updateProfileApi, data: data);

      if (response?.statusCode == 200) {
        final user = response?.data['data'];

        print("👤 User: $user");
        var userData = UserModel.fromJson(response?.data['data']);
        DataStroge.getInstance.updateUserData(userData);
        Fluttertoast.showToast(
            msg: response?.data['message'] ?? 'Profile updated successfully.');

        Get.back();
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Something went wrong: $e");
    }
  }
}
