import 'dart:math';

import 'package:get/get.dart';
import 'package:medrobot_dradham/api_services/login_service.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:medrobot_dradham/main.dart';
import 'dart:io';

import 'package:medrobot_dradham/view/home_screen.dart';

class LoginController extends GetxController {
  var isLoading = false.obs;
  var loginMessage = ''.obs;
  int user_id = 0;
  final LoginService _loginService = LoginService();

  Future<void> login(String phone) async {
    isLoading.value = true; // إظهار مؤشر التحميل
    String? deviceId = await getDeviceId(); // الحصول على معرف الجهاز
    try {
      // انتظار استجابة الخادم
      final result =
          await _loginService.login(phone: phone, deviceId: deviceId!);

      // التحقق مما إذا كانت الاستجابة ناجحة
      if (result.status == "success") {
        if (result.userId != null) {
          user_id = result.userId!; // تعيين userId فقط إذا لم يكن null

          // الانتقال إلى الصفحة الرئيسية مع تمرير userId
          Get.offAll(() => HomeScreen());
        } else {
          print("Error: userId is null");
          loginMessage.value = 'Login failed: userId is null';
        }
      } else {
        loginMessage.value = 'Login failed'; // عرض رسالة فشل تسجيل الدخول
        print("Login failed: ${result.message}");
      }
    } catch (e) {
      loginMessage.value = 'Login failed'; // التعامل مع أي أخطاء قد تحدث
      print("Error occurred during login: $e");
    } finally {
      isLoading.value = false; // إخفاء مؤشر التحميل
    }
  }

  Future<String?> getDeviceId() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    if (Platform.isAndroid) {
      // For Android
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      if (androidInfo.isPhysicalDevice) {
        return androidInfo.fingerprint;
      } else {
        Random random = Random();
        double number = random.nextDouble();
        return number.toString();
      }
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;

      if (iosInfo.isPhysicalDevice) {
        return iosInfo.identifierForVendor;
      } else {
        Random random = Random();
        double number = random.nextDouble();
        return number.toString();
      }
    }
    return null;
  }
}
