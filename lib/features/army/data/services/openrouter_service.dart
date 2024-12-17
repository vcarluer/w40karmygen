import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;

class OpenRouterService {
  static const String _baseUrl = 'https://openrouter.ai/api/v1';
  final String apiKey;

  OpenRouterService({required this.apiKey});

  Future<String> generateArmyList(String prompt) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/chat/completions'),
      headers: {
        'Authorization': 'Bearer $apiKey',
        'Content-Type': 'application/json',
        'HTTP-Referer': 'https://github.com/vcarluer/w40k', // Required by OpenRouter
      },
      body: jsonEncode({
        'model': 'openai/gpt-4o-mini',
        'messages': [
          {
            'role': 'system',
            'content': 'You are a Warhammer 40,000 army list generator. Your goal is to create effective army lists given the available units.',
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
      throw Exception('Failed to generate army list: ${response.body}');
    }
  }

  Future<String> recognizeUnit(Uint8List imageBytes) async {
    final base64Image = base64Encode(imageBytes);
    
    final response = await http.post(
      Uri.parse('$_baseUrl/chat/completions'),
      headers: {
        'Authorization': 'Bearer $apiKey',
        'Content-Type': 'application/json',
        'HTTP-Referer': 'https://github.com/vcarluer/w40k',
      },
      body: jsonEncode({
        'model': 'google/gemini-flash-1.5',
        'messages': [
          {
            'role': 'system',
            'content': 'You are a Warhammer 40,000 miniature recognition expert. Your goal is to identify the exact unit name from the image provided.',
          },
          {
            'role': 'user',
            'content': {
              'type': 'text',
              'parts': [
                {
                  'type': 'image/jpeg',
                  'data': base64Image
                },
                {
                  'type': 'text',
                  'text': 'What is the exact name of this Warhammer 40,000 unit? Please provide only the exact unit name as it appears in the game data, without any additional text or explanation.'
                }
              ]
            }
          }
        ],
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['choices'][0]['message']['content'];
    } else {
      throw Exception('Failed to recognize unit: ${response.body}');
    }
  }
}
