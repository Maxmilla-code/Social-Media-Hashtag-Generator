import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/hashtag_analysis.dart';

class HashtagService {
  final http.Client client;

  HashtagService({http.Client? client}) : client = client ?? http.Client();

  Future<List<HashtagAnalysis>> getHashtagAnalysis(String topic) async {
    final uri = Uri.parse('https://api.openai.com/v1/chat/completions');
    // const apiKey = String.fromEnvironment('OPENAI_API_KEY');
    // if (apiKey.isEmpty) {
    //   throw Exception('API key not found. Please set the OPENAI_API_KEY environment variable.');
    // }

    final prompt = 'Generate 10-15 popular and trending social media hashtags for a product or topic about "$topic". '
                   'For each hashtag, provide a trend score from 0.0 to 1.0 and a list of recommended platforms (e.g., "Instagram", "Twitter", "LinkedIn"). '
                   'Return the result as a JSON array, where each object has "hashtag", "trend_score", and "platforms" keys.';

    final body = jsonEncode({
      'model': 'gpt-3.5-turbo',
      'messages': [{'role': 'user', 'content': prompt}],
      'temperature': 0.7,
    });

    // MOCK RESPONSE
    final mockJsonResponse = {
      'choices': [
        {
          'message': {
            'content': jsonEncode([
              {'hashtag': '#${topic.replaceAll(' ', '')}', 'trend_score': 0.9, 'platforms': ['Instagram', 'TikTok']},
              {'hashtag': '#${topic.replaceAll(' ', '')}love', 'trend_score': 0.8, 'platforms': ['Instagram']},
              {'hashtag': '#SocialMediaMarketing', 'trend_score': 0.95, 'platforms': ['LinkedIn', 'Twitter']},
              {'hashtag': '#DigitalMarketing', 'trend_score': 0.92, 'platforms': ['LinkedIn', 'Twitter']},
              {'hashtag': '#InstaGood', 'trend_score': 0.85, 'platforms': ['Instagram']},
              {'hashtag': '#MarketingTips', 'trend_score': 0.88, 'platforms': ['LinkedIn', 'Twitter', 'Instagram']},
            ])
          }
        }
      ]
    };

    final response = http.Response(jsonEncode(mockJsonResponse), 200);

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      final content = jsonDecode(jsonResponse['choices'][0]['message']['content']) as List;
      return content.map((data) => HashtagAnalysis.fromJson(data)).toList();
    } else {
      throw Exception('Failed to generate hashtags. Status code: ${response.statusCode}');
    }
  }
}
