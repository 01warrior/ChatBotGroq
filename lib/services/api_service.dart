import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:chatscreen/config.dart';

class ApiService {
  Future<String> sendMessage(String message) async {
    final response = await http.post(
      Uri.parse(AppConfig.apiUrl),
      headers: {
        'Authorization': 'Bearer ${AppConfig.apiKey}',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "model": AppConfig.defaultModel,
        "messages": [
          {"role": "user", "content": message}
        ],
        "max_tokens": AppConfig.maxTokens,
        "stream": false
      }),
    );

    print('Réponse brute: ${response.statusCode} - ${response.body}'); // Log complet

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return _parseResponse(data);
    }
    throw Exception('HTTP ${response.statusCode}: ${response.body}');
  }

  String _parseResponse(Map<String, dynamic> data) {
    try {
      return data['choices'][0]['message']['content'] as String;
    } catch (e) {
      throw Exception('Invalid response format: ${e.toString()}');
    }
  }
}
