import 'dart:convert';
import 'package:http/http.dart' as http;

class CategoryServices {
  Future<CategoryResult> getCategory({required int user_id}) async {
    String loginUrl =
        'https://bitcotechs.top/medrobot/get_categories.php?user_id=$user_id';
    final response = await http.get(
      Uri.parse(loginUrl),
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
      },
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      return CategoryResult(
        status: responseData['status'],
        data: List<Map<String, dynamic>>.from(responseData['data']),
      );
    } else {
      throw Exception(
          'Failed to load categories. Status code: ${response.statusCode}');
    }
  }
}

class CategoryResult {
  final String status;
  final List<Map<String, dynamic>> data;

  CategoryResult({required this.status, required this.data});
}
