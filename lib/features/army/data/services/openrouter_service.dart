import 'dart:convert';
import 'package:http/http.dart' as http;

class OpenRouterService {
  static const String _baseUrl = 'https://openrouter.ai/api/v1';
  final String apiKey;

  OpenRouterService({required this.apiKey});

  Future<String> generateOptimizedList(String prompt) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/chat/completions'),
      headers: {
        'Authorization': 'Bearer $apiKey',
        'Content-Type': 'application/json',
        'HTTP-Referer': 'https://github.com/vcarluer/w40k', // Required by OpenRouter
      },
      body: jsonEncode({
        'model': 'gpt-4',
        'messages': [
          {
            'role': 'system',
            'content': 'You are a Warhammer 40,000 army list optimizer. Your goal is to create the most effective army list possible given the available units.',
          },
          {
            'role': 'user',
            'content': prompt,
          },
        ],
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['choices'][0]['message']['content'];
    } else {
      throw Exception('Failed to generate optimized list: ${response.body}');
    }
  }
}