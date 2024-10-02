import 'dart:convert';
import 'package:http/http.dart' as http;

class VideoServices {
  Future<VideoResult> getVideos(
      {required int user_id, required int subcategory_id}) async {
    String videosUrl =
        'https://bitcotechs.top/medrobot/get_videos.php?user_id=$user_id&subcategory_id=$subcategory_id';
    final response = await http.get(
      Uri.parse(videosUrl),
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
      },
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      return VideoResult(
        status: responseData['status'],
        subcategory_id: responseData["subcategory_id"],
        data: List<Map<String, dynamic>>.from(responseData['data']),
      );
    } else {
      throw Exception(
          'Failed to load categories. Status code: ${response.statusCode}');
    }
  }
}

class VideoResult {
  final String status;
  final int subcategory_id;
  final List<Map<String, dynamic>> data;

  VideoResult(
      {required this.subcategory_id, required this.status, required this.data});
}
