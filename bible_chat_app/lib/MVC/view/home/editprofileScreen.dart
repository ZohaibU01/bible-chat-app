import 'dart:io';
import 'package:bible_chat_app/components/custom_textfiled.dart';
import 'package:bible_chat_app/components/image_widget.dart';
import 'package:bible_chat_app/components/round_button.dart';
import 'package:bible_chat_app/components/spring_widget.dart';
import 'package:bible_chat_app/constant/constants.dart';
import 'package:bible_chat_app/constant/theme.dart';
import 'package:bible_chat_app/helper/data_storage.dart';
import 'package:bible_chat_app/helper/getx_helper.dart';
import 'package:bible_chat_app/helper/internet_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../components/AgeRangeBottomSheet.dart';
import '../../../components/denominationBottomSheet.dart';
import '../../controller/loginController.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({super.key});

  final internetController = Get.put(InternetController());
  final loginController = Get.put(Logincontroller());
  final getcontroller = Get.put(GetxControllersProvider());

  RxBool apihitting = false.obs;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeHelper>(builder: (themeController) {
      return AnnotatedRegion(
        value: themeController.systemUiOverlayStylesplash,
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: themeController.bgcolor,
          appBar: AppBar(
            backgroundColor: themeController.bgcolor,
            surfaceTintColor: themeController.bgcolor,
            leading: SpringWidget(
                onTap: () {
                  Get.back();
                },
                child: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: Colors.white,
                )),
            title: Text(
              'Edit Profile',
              style: TextStyle(
                color: themeController.colorPrimarywhite,
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.sp,
              ),
            ),
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Constants.screenPadding,
              vertical: Constants.screenPadding,
            ),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        getcontroller.getImage();
                      },
                      child: Obx(() => getcontroller.imagePath.value.isNotEmpty
                          ? getcontroller.imagePath.value.startsWith('http')
                              ? CircleAvatar(
                                  radius: 100.sp,
                                  backgroundColor: Colors.white,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20.sp),
                                    child: ImageWidget(
                                        imageUrl:
                                            getcontroller.imagePath.value),
                                  ),
                                )
                              : CircleAvatar(
                                  radius: 80.sp,
                                  backgroundColor: Colors.white,
                                  backgroundImage: FileImage(
                                      File(getcontroller.imagePath.value)),
                                )
                          : CircleAvatar(
                              radius: 80.sp,
                              backgroundColor:
                                  HexColor('#FFF021').withValues(alpha: 0.3),
                              child: SvgPicture.asset(
                                "assets/icons/user.svg",
                                height: 80.sp,
                                width: 80.sp,
                                color: HexColor('#FFF021'),
                              ),
                            )),
                    ),
                    SizedBox(
                      height: 20.sp,
                    ),
                    CustomTextFieldWidget(
                      controller: loginController.usernameController.value,
                      hintText: DataStroge.userName.value.isEmpty
                          ? 'Full Name'
                          : DataStroge.userName.value,
                      fieldColor: themeController.ContainerColor,
                      inputType: TextInputType.name,
                      onsubmit: () {},
                      TextColor: Colors.white,
                      label: DataStroge.userName.value.isEmpty
                          ? 'Full Name'
                          : DataStroge.userName.value,
                      validator: (value) {
                        if (value?.isEmpty ??
                            true && DataStroge.userName.value.isEmpty) {
                          return 'Please Enter The Updated Name';
                        }
                        return null;
                      },
                      enabled: true,
                    ),
                    SpringWidget(
                      onTap: () {
                        Agerangebottomsheet.show(context);
                      },
                      child: CustomTextFieldWidget(
                        controller: loginController.UserAgeController.value,
                        hintText: DataStroge.userAgeRange.value.isEmpty
                            ? 'Select Age Range'
                            : DataStroge.userAgeRange.value,
                        fieldColor: themeController.ContainerColor,
                        inputType: TextInputType.name,
                        suffixIcon: Icon(
                          Icons.arrow_drop_down,
                          color: Colors.white,
                        ),
                        onsubmit: () {},
                        TextColor: Colors.white,
                        label: "",
                        validator: (value) {
                          if (value?.isEmpty ??
                              true && DataStroge.userAgeRange.value.isEmpty) {
                            return 'Please Enter The Age Range';
                          }
                          return null;
                        },
                        enabled: false,
                      ),
                    ),
                    SpringWidget(
                      onTap: () {
                        Denominationbottomsheet.show(context);
                      },
                      child: Obx(
                        () =>  CustomTextFieldWidget(
                          controller:
                              loginController.UserDenominationController.value,
                          hintText: DataStroge.userDenomination.value.isEmpty
                              ? 'Select Denomination'
                              : DataStroge.userDenomination.value,
                          fieldColor: themeController.ContainerColor,
                          inputType: TextInputType.name,
                          suffixIcon: Icon(
                            Icons.arrow_drop_down,
                            color: Colors.white,
                          ),
                          onsubmit: () {},
                          TextColor: Colors.white,
                          label: "",
                          validator: (value) {
                            if (value?.isEmpty ??
                                true && DataStroge.userDenomination.value.isEmpty) {
                              return 'Please Select Denomination';
                            }
                            return null;
                          },
                          enabled: false,
                        ),
                      ),
                    ),
                    CustomTextFieldWidget(
                      controller: loginController.UserChurchController.value,
                      hintText: DataStroge.userChurch.value.isEmpty
                          ? 'Enter church name'
                          : DataStroge.userChurch.value,
                      fieldColor: themeController.ContainerColor,
                      inputType: TextInputType.name,
                      onsubmit: () {},
                      TextColor: Colors.white,
                      label: "",
                      validator: (value) {
                        if (value?.isEmpty ??
                            true && DataStroge.userChurch.value.isEmpty) {
                          return 'Please enter church name';
                        }
                        return null;
                      },
                      enabled: true,
                    ),
                    SizedBox(
                      height: 20.sp,
                    ),
                  ],
                ),
              ),
            ),
          ),
          bottomNavigationBar: Padding(
            padding:  EdgeInsets.symmetric(horizontal: 20.sp,vertical: 20.sp),
            child: Obx(
              () => RoundButton(
                height: 45.sp,
                title: 'Update Profile',
                loading: apihitting.value,
                disabled: apihitting.value,
                margin: 0,
                onTap: () async {
                  if (_formKey.currentState!.validate()) {
                    apihitting.value = true;
                    await loginController.updateProfile(context);
                    apihitting.value = false;
                  }
                },
              ),
            ),
          ),
        ),
      );
    });
  }
}
