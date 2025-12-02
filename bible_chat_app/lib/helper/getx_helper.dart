import 'package:bible_chat_app/constant/constants.dart';
import 'package:bible_chat_app/constant/navigation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class GetxControllersProvider extends GetxController {
  RxString imagePath = ''.obs;
  RxString AddimagePath = ''.obs;
  RxString AddvideoPath = ''.obs;
  RxString KYCFrontimagePath = ''.obs;

  var defaultImagePath = 'assets/images/default.jpg';
  Future getImage() async {
    final _picker = ImagePicker();
    final image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      imagePath.value = image.path.toString();
    } else {
      imagePath.value = '';
    }
  }

  Future getFromCameraImage() async {
    final _picker = ImagePicker();
    final image = await _picker.pickImage(source: ImageSource.camera);

    if (image != null) {
      imagePath.value = image.path.toString();
      return imagePath.value;
    } else {
      imagePath.value = '';
      return '';
    }
  }

  Future getKYCFrontImage() async {
    final _picker = ImagePicker();
    final image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      KYCFrontimagePath.value = image.path.toString();
    } else {
      KYCFrontimagePath.value = '';
    }
  }

  Future getImageForAddons() async {
    final _picker = ImagePicker();
    final image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      AddimagePath.value = image.path.toString();
    } else {
      AddimagePath.value = '';
    }
  }

  Future getFromCameraImageForAddons() async {
    final _picker = ImagePicker();
    final image = await _picker.pickImage(source: ImageSource.camera);

    if (image != null) {
      AddimagePath.value = image.path.toString();
    } else {
      AddimagePath.value = '';
    }
  }

  Future getvideo() async {
    final _picker = ImagePicker();
    final image = await _picker.pickVideo(source: ImageSource.gallery);

    if (image != null) {
      AddvideoPath.value = image.path.toString();
    } else {
      AddvideoPath.value = '';
    }
  }

  Future getvideoFromCamera() async {
    final _picker = ImagePicker();
    final image = await _picker.pickVideo(source: ImageSource.camera);

    if (image != null) {
      AddvideoPath.value = image.path.toString();
    } else {
      AddvideoPath.value = '';
    }
  }

  bool isValidEmail(String email) {
    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegExp.hasMatch(email);
  }
}
