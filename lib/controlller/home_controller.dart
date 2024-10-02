// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:medrobot_dradham/api_services/category_services.dart';
import 'package:medrobot_dradham/controlller/login_controller.dart';
import 'package:medrobot_dradham/model/category%20model/category_model.dart';

class HomeController extends GetxController {
  var isLoading = false.obs;
  var categories = <CategoryModel>[].obs;
  int user_id = 0;
  int category_id = 0;
  final _categoryServices = CategoryServices();
  LoginController loginController = Get.put(LoginController());

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getCategory(user_id: loginController.user_id);
  }

  void getCategory({required int user_id}) async {
    isLoading.value = true;
    try {
      final result = await _categoryServices.getCategory(user_id: user_id);
      if (result.status == "success" && result.data.isNotEmpty) {
        // Convert the data to a list of CategoryModel
        categories.value = result.data
            .map((category) => CategoryModel.fromJson(category))
            .toList();

        // Safely check if the first category has a valid 'category_id'
        if (result.data[0]["category_id"] != null) {
          category_id = result.data[0]["category_id"];
        } else {
          // Fluttertoast.showToast(msg: "No category ID available");
        }
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
