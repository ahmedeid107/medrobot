import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:medrobot_dradham/controlller/login_controller.dart';
import '../constants/colors.dart';
import 'widgets/custom_button.dart';
import 'widgets/custom_text_field.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  // Updated names for clarity
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController deviceIdController = TextEditingController();
  final LoginController controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(16.0.sp),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 20.sp,
                ),
                Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    height: MediaQuery.of(context).size.height * 0.25,
                    child: Image.asset("assets/images/logo.png")),
                const SizedBox(height: 20),
                custom_text_field(
                  hintText: "Eg: 010123456",
                  labelTextField: "Phone",
                  controller: phoneController,
                  suffixIcon: const Icon(Icons.phone),
                  suffixIconColor: const Color.fromRGBO(8, 37, 67, 1),
                ),
                SizedBox(
                  height: 10.sp,
                ),
                Obx(
                  () => controller.isLoading.value
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : custom_button(
                          buttonBackGroundColor:
                              const Color.fromRGBO(8, 37, 67, 1),
                          textButton: "Login",
                          functonOfButton: () {
                            final phone = phoneController.text;

                            controller.login(
                              phone,
                            );
                          },
                        ),
                ),
                SizedBox(
                  height: 10.sp,
                ),
                Obx(
                  () => controller.loginMessage.isNotEmpty
                      ? Text(
                          controller.loginMessage.value,
                          style: TextStyle(
                            color: controller.loginMessage.value
                                    .startsWith('Error')
                                ? Colors.red
                                : Colors.green,
                            fontSize: 16.sp,
                          ),
                        )
                      : Container(),
                ),
                SizedBox(
                  height: 20.sp,
                ),
                // const Text(
                //   'WhatsApp : 01018245372',
                //   style: TextStyle(color: kPrimaryColor),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
