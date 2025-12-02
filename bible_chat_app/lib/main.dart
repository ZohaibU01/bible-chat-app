import 'dart:convert';
import 'dart:io';
import 'package:bible_chat_app/services/fcm_token.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bible_chat_app/constant/theme.dart';
import 'package:get/get.dart';
import 'MVC/view/onboarding/splashScreen.dart';
import 'constant/constants.dart';
import 'helper/data_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DataStroge.getInstance.initiateSession();
  await FirebaseDB.init();

  loadConfig();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const MyApp());

  Get.put(ThemeHelper());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      useInheritedMediaQuery: true,
      builder: (_, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            fontFamily: 'DMSans',
          ),
          home: child,
        );
      },
      child: Splashscreen(),
    );
  }
}

Future<void> loadConfig() async {
  try {
    String configString = await rootBundle.loadString('config/config.json');
    Map<String, dynamic> configJson = json.decode(configString);
    Constants.API_HOST = configJson['api_host'];
  } catch (e) {
    print(e);
    print("Configuration file does not exists or is not valid");
    exit(0);
  }
}
