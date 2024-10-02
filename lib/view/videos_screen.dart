import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medrobot_dradham/constants/colors.dart';
import 'package:medrobot_dradham/controlller/video_controller.dart';
import 'package:medrobot_dradham/view/video_detail_screen.dart';

class VideosScreen extends StatefulWidget {
  @override
  _VideosScreenState createState() => _VideosScreenState();
}

class _VideosScreenState extends State<VideosScreen> {
  late VideosController controller;
  Map<String, dynamic> data = Get.arguments;
  @override
  void initState() {
    super.initState();
    controller = Get.put(VideosController(
        subcategoryId: data["subcategoryId"])); // استخدم المعرف المناسب
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          data["title"],
          style: TextStyle(
              color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
        ),
        backgroundColor: kSecondaryColor,
        elevation: 0,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else if (controller.videosList.isEmpty) {
          return Center(child: Text("No videos available."));
        } else {
          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: ListView.builder(
              itemCount: controller.videosList.length,
              itemBuilder: (context, index) {
                var video = controller.videosList[index];
                return GestureDetector(
                  onTap: () {
                    // الانتقال إلى صفحة الفيديو
                    Get.to(() => VideoDetailScreen(video: video));
                  },
                  child: Container(
                    margin: EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15),
                          ),
                          child: Image.network(
                            video.thumbnailUrl,
                            height: 200,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            video.videoName,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Duration: ${video.duration}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                ),
                              ),
                              Icon(
                                Icons.play_circle_fill,
                                color: kSecondaryColor,
                                size: 30,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 12), // إضافة بعض المسافة في الأسفل
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        }
      }),
    );
  }
}
