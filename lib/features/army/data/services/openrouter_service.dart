import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;

class RecognitionResult {
  final String figurineName;
  final String unitName;

  RecognitionResult({required this.figurineName, required this.unitName});
}

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

  Future<RecognitionResult> recognizeUnit(Uint8List imageBytes) async {
    final base64Image = base64Encode(imageBytes);
    final dataUrl = 'data:image/jpeg;base64,$base64Image';
    
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
            'content': 'You are a Warhammer 40,000 miniature recognition expert. Your goal is to identify both the specific figurine and its unit type from the image provided.',
          },
          {
            'role': 'user',
            'content': [
              {
                'type': 'image_url',
                'image_url': {
                  'url': dataUrl
                }
              },
              {
                'type': 'text',
                'text': 'Please provide two pieces of information about this Warhammer 40,000 miniature:\n1. The specific name of this figurine\n2. The unit type/name as it appears in the game data\nFormat your response exactly like this:\nFigurine: [figurine name]\nUnit: [unit name]'
              }
            ]
          }
        ],
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final content = data['choices'][0]['message']['content'] as String;
      
      // Parse the response
      final lines = content.split('\n');
      String figurineName = '';
      String unitName = '';
      
      for (final line in lines) {
        if (line.startsWith('Figurine:')) {
          figurineName = line.substring('Figurine:'.length).trim();
        } else if (line.startsWith('Unit:')) {
          unitName = line.substring('Unit:'.length).trim();
        }
      }
      
      return RecognitionResult(
        figurineName: figurineName,
        unitName: unitName,
      );
    } else {
      throw Exception('Failed to recognize unit: ${response.body}');
    }
  }
}
