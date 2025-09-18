import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:social_media_hashtag_generator/models/hashtag_analysis.dart';
import 'package:social_media_hashtag_generator/services/hashtag_service.dart';

void main() {
  group('HashtagService', () {
    test('getHashtagAnalysis returns a list of analyses on successful API call', () async {
      final mockClient = MockClient((request) async {
        final mockApiResponse = {
          'choices': [
            {
              'message': {
                'content': jsonEncode([
                  {'hashtag': '#flutter', 'trend_score': 0.9, 'platforms': ['Twitter', 'LinkedIn']},
                  {'hashtag': '#dart', 'trend_score': 0.8, 'platforms': ['Twitter']},
                ])
              }
            }
          ]
        };
        return http.Response(jsonEncode(mockApiResponse), 200);
      });

      final service = HashtagService(client: mockClient);
      final analyses = await service.getHashtagAnalysis('flutter');

      expect(analyses, isA<List<HashtagAnalysis>>());
      expect(analyses.length, 2);
      expect(analyses.first.hashtag, '#flutter');
      expect(analyses.first.trendScore, 0.9);
      expect(analyses.first.platforms, ['Twitter', 'LinkedIn']);
    });

    test('getHashtagAnalysis throws an exception on failed API call', () {
      final mockClient = MockClient((request) async {
        return http.Response('Server Error', 500);
      });

      final service = HashtagService(client: mockClient);

      expect(service.getHashtagAnalysis('flutter'), throwsException);
    });
  });
}
