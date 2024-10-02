import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:medrobot_dradham/controlller/subcategory_controller.dart';
import 'package:medrobot_dradham/view/videos_screen.dart';

import '../constants/colors.dart';

class SubCategoriesScreen extends StatelessWidget {
  SubCategoriesScreen({super.key});
  Map<String, dynamic> data = Get.arguments;

  @override
  Widget build(BuildContext context) {
    SubCategoryController controller =
        Get.put(SubCategoryController(categoryId: data["categoryId"]));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: kSecondaryColor,
        title: Text(
          data["categoryTitle"],
          style: TextStyle(fontSize: 20.sp, color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Obx(
          () => controller.isLoading.value
              ? const Center(
                  child: CircularProgressIndicator(color: kSecondaryColor),
                )
              : GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 4.sp,
                    crossAxisSpacing: 4.0.sp,
                  ),
                  itemCount: controller.sub_categories.length,
                  itemBuilder: (contex, index) {
                    return InkWell(
                      onTap: () async {
                        Get.to(() => VideosScreen(), arguments: {
                          "subcategoryId": controller.sub_categories[index].id,
                          "title": controller.sub_categories[index].name
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: kSecondaryColor,
                          ),
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                              controller.sub_categories[index].image,
                            ),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.black.withOpacity(0.75),
                              ),
                              height: 40.sp,
                              width: double.infinity,
                              child: Center(
                                child: Text(
                                  controller.sub_categories[index].name,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18.sp,
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
      ),
    );
  }
}
