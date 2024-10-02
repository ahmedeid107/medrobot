// ignore_for_file: file_names

import 'package:get/get.dart';
import 'package:medrobot_dradham/Route/AppRoutes.dart';
import 'package:medrobot_dradham/view/home_screen.dart';
import 'package:medrobot_dradham/view/subcategory_screen.dart';

import '../view/login_screen.dart';
import '../view/videos_screen.dart';

class AppPages {
  static final List<GetPage> pages = [
    GetPage(
      name: AppRoutes.loginScreen,
      page: () => LoginScreen(),
    ),
    GetPage(
      name: AppRoutes.homeScreen,
      page: () => HomeScreen(),
    ),
    GetPage(
      name: AppRoutes.subcategoryScreen,
      page: () => SubCategoriesScreen(),
    ),
    GetPage(
      name: AppRoutes.videosScreen,
      page: () => VideosScreen(),
    ),
  ];
}
