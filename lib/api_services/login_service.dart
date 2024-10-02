import 'dart:convert';
import 'package:http/http.dart' as http;

class LoginService {
  final String _loginUrl = 'https://bitcotechs.top/medrobot/login.php';

  Future<LoginResult> login(
      {required String phone, required String deviceId}) async {
    final response = await http.post(
      Uri.parse(_loginUrl),
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      body: {
        'phone': phone,
        'device_id': deviceId,
      },
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      return LoginResult(
        responseData["userId"],
        status: responseData['status'],
        message: responseData['message'],
      );
    } else {
      throw Exception('Failed to login. Status code: ${response.statusCode}');
    }
  }
}

class LoginResult {
  final String status;
  final int? userId; // تأكد من استخدام نفس الاسم 'userId'

  final String message;

  LoginResult(this.userId, {required this.status, required this.message});
}
