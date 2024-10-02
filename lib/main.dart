import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:medrobot_dradham/Route/AppPages.dart';
import 'view/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // تهيئة Hive
  await Hive.initFlutter();

  // فتح الصندوق الذي ستستخدمه لتخزين تقدم الفيديو
  await Hive.openBox('video_progress');
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

const platform = MethodChannel('com.adham.medrobot/screenshotDetection');

class _MyAppState extends State<MyApp> {
// Method to listen for screenshot or screen recording
  void detectScreenCapture() {
    platform.setMethodCallHandler((MethodCall call) async {
      if (call.method == 'onScreenCapture') {
        exit(0);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    detectScreenCapture();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      child: GetMaterialApp(
        theme: ThemeData(
          appBarTheme: AppBarTheme(
            iconTheme: IconThemeData(
              color: Colors.white,
            ),
          ),
        ),
        debugShowCheckedModeBanner: false,
        home: LoginScreen(),
        getPages: AppPages.pages,
      ),
    );
  }
}
