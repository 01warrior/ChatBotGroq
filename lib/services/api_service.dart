import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:chatscreen/config.dart';

class ApiService {
  Future<String> sendMessage(
      List<Map<String, dynamic>> messages, String model) async {
    final response = await http.post(
      Uri.parse(AppConfig.apiUrl),
      headers: {
        'Authorization': 'Bearer ${AppConfig.apiKey}',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "model": model,
        "messages": messages,
        "max_completion_tokens": AppConfig.maxTokens,
        "temperature": 1,
        "top_p": 1,
        ...(AppConfig.reasoningModels.contains(model)
            ? {"reasoning_effort": "medium"}
            : {}),
        "stream": false
      }),
    );

    print('Réponse brute: ${response.statusCode} - ${response.body}');

    if (response.statusCode == 200) {
      final decodedBody = latin1.decode(response.bodyBytes);
      final data = jsonDecode(decodedBody);
      return _parseResponse(data);
    }
    throw Exception('HTTP ${response.statusCode}: ${response.body}');
  }

  String _parseResponse(Map<String, dynamic> data) {
    try {
      String content = data['choices'][0]['message']['content'] as String;
      // Fix encoding: encode as latin1 bytes, then decode as utf8
      content = utf8.decode(latin1.encode(content));
      return content;
    } catch (e) {
      throw Exception('Invalid response format: ${e.toString()}');
    }
  }
}
