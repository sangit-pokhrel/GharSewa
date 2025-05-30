import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl =
      'http://localhost:5000'; // replace with your backend URL

  static Future<Map<String, dynamic>> signupUser({
    required String fullName,
    required String email,
    required String password,
  }) async {
    final url = Uri.parse('$baseUrl/api/auth/register'); // your signup endpoint

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'fullName': fullName,
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to sign up: ${response.body}');
    }
  }
}
