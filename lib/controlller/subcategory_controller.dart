// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:medrobot_dradham/api_services/subcategory_services.dart';
import 'package:medrobot_dradham/controlller/login_controller.dart';

import '../model/subcategory model/subcategory_model.dart';

class SubCategoryController extends GetxController {
  int categoryId;
  LoginController loginController = Get.put(LoginController());
  var sub_categories = <SubCategoryModel>[].obs;

  SubcategoryServices _subcategoryServices = SubcategoryServices();

  SubCategoryController({
    required this.categoryId,
  });

  var isLoading = false.obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getSubCategory(user_id: loginController.user_id, category_id: categoryId);
  }
//-----------

  void getSubCategory({required int user_id, required int category_id}) async {
    isLoading.value = true;

    try {
      final result = await _subcategoryServices.getSubCategory(
          user_id: user_id, category_id: category_id);
      if (result.status == "success") {
        // Convert the data to a list of CategoryModel
        sub_categories.value = result.data
            .map((category) => SubCategoryModel.fromJson(category))
            .toList();
      } else {
        Fluttertoast.showToast(msg: "Failed to load categories");
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'Failed to load categories: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
