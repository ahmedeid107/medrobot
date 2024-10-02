import 'dart:convert';
import 'package:http/http.dart' as http;

class SubcategoryServices {
  Future<SubCategoryResult> getSubCategory(
      {required int user_id, required int category_id}) async {
    String loginUrl =
        'https://bitcotechs.top/medrobot/get_subcategories.php?user_id=$user_id&category_id=$category_id';
    final response = await http.get(
      Uri.parse(loginUrl),
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
      },
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      return SubCategoryResult(
        status: responseData['status'],
        data: List<Map<String, dynamic>>.from(responseData['data']),
      );
    } else {
      throw Exception(
          'Failed to load categories. Status code: ${response.statusCode}');
    }
  }
}

class SubCategoryResult {
  final String status;
  final List<Map<String, dynamic>> data;

  SubCategoryResult({required this.status, required this.data});
}
