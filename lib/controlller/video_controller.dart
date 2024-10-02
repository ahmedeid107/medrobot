import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:medrobot_dradham/api_services/video_services.dart';
import 'package:medrobot_dradham/controlller/home_controller.dart';
import 'package:medrobot_dradham/controlller/login_controller.dart';
import 'package:medrobot_dradham/model/videos%20model/video_model.dart';

class VideosController extends GetxController {
  LoginController loginController = Get.put(LoginController());
  VideoServices videoServices = VideoServices();
  int subcategoryId;
  VideosController({
    required this.subcategoryId,
  });

  var isLoading = false.obs;
  var videosList = <VideoModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    getVideos();
  }

  void getVideos() async {
    try {
      isLoading.value = true;
      print(
          "Fetching videos for subcategoryId: $subcategoryId"); // طباعة للتحقق
      final result = await videoServices.getVideos(
          subcategory_id: subcategoryId, user_id: loginController.user_id);

      if (result.status == "success") {
        // Convert the data to a list of VideoModel
        videosList.value = result.data
            .map<VideoModel>((category) => VideoModel.fromJson(category))
            .toList();
        print("Videos fetched: ${videosList.length}"); // طباعة عدد الفيديوهات
      } else {
        Fluttertoast.showToast(msg: "Failed to load videos");
        print("Failed to load videos"); // طباعة عند الفشل
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'Failed to load videos: $e');
      print("Error: $e"); // طباعة رسالة الخطأ
    } finally {
      isLoading.value = false;
    }
  }
}
