import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:medrobot_dradham/constants/colors.dart';
import 'package:medrobot_dradham/view/subcategory_screen.dart';

import '../controlller/home_controller.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  HomeController controller = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(8, 37, 67, 1),
        title: Text(
          "MED ROBOT",
          style: TextStyle(fontSize: 20.sp, color: Colors.white),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Our Courses :",
                style: TextStyle(
                  fontSize: 18.sp,
                  color: kPrimaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 10.sp,
              ),
              Obx(
                () => controller.isLoading.value
                    ? const Center(
                        child:
                            CircularProgressIndicator(color: kSecondaryColor),
                      )
                    : controller.categories.isEmpty
                        ? const Center(
                            child: Text('No categories available'),
                          )
                        : GridView.builder(
                            shrinkWrap: true,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisSpacing: 10.0.sp,
                              crossAxisCount: 2,
                            ),
                            itemCount: controller.categories.length,
                            itemBuilder: (contex, index) {
                              return InkWell(
                                onTap: () => Get.to(
                                  () => SubCategoriesScreen(),
                                  arguments: {
                                    "categoryTitle":
                                        controller.categories[index].name,
                                    "categoryId":
                                        controller.categories[index].id,
                                  },
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: kSecondaryColor,
                                    ),
                                    borderRadius: BorderRadius.circular(15),
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                        controller.categories[index].image,
                                      ),
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          color: Colors.black.withOpacity(0.75),
                                        ),
                                        height: 40.sp,
                                        width: double.infinity,
                                        child: Center(
                                          child: Text(
                                            controller.categories[index].name,
                                            style: TextStyle(
                                              overflow: TextOverflow.ellipsis,
                                              color: Colors.white,
                                              fontSize: 20.sp,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
              ),
              SizedBox(
                height: 10.sp,
              ),
              Center(
                child: Text(
                  "MED ROBOT App version 1.0",
                  style: TextStyle(color: Colors.grey, fontSize: 15.sp),
                ),
              ),
              Center(
                child: Text(
                  "يمنع التطبيق أخذ لقطة شاشة أو تصوير فيديو حفظاً لحقوق الطبع والنشر",
                  style: TextStyle(
                      color: Colors.grey, fontSize: 15.sp, fontFamily: "Cairo"),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
