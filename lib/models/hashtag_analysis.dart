class HashtagAnalysis {
  final String hashtag;
  final double trendScore; // A score from 0.0 to 1.0
  final List<String> platforms; // e.g., ['Instagram', 'Twitter']

  HashtagAnalysis({
    required this.hashtag,
    required this.trendScore,
    required this.platforms,
  });

  factory HashtagAnalysis.fromJson(Map<String, dynamic> json) {
    return HashtagAnalysis(
      hashtag: json['hashtag'] as String,
      trendScore: (json['trend_score'] as num).toDouble(),
      platforms: List<String>.from(json['platforms'] as List),
    );
  }
}
