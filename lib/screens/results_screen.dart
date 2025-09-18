import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/hashtag_analysis.dart';

class ResultsScreen extends StatelessWidget {
  final List<HashtagAnalysis> analyses;

  const ResultsScreen({super.key, required this.analyses});

  void _copyToClipboard(BuildContext context, String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Copied to clipboard')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hashtag Analysis'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                final allHashtags = analyses.map((a) => a.hashtag).join(' ');
                _copyToClipboard(context, allHashtags);
              },
              child: const Text('Copy All Hashtags'),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: analyses.length,
              itemBuilder: (context, index) {
                final analysis = analyses[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              analysis.hashtag,
                              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            IconButton(
                              icon: const Icon(Icons.copy),
                              onPressed: () => _copyToClipboard(context, analysis.hashtag),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        const Text('Trend Score', style: TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 4),
                        LinearProgressIndicator(
                          value: analysis.trendScore,
                          backgroundColor: Colors.grey[300],
                          valueColor: AlwaysStoppedAnimation<Color>(
                            analysis.trendScore > 0.8 ? Colors.green : (analysis.trendScore > 0.6 ? Colors.orange : Colors.red),
                          ),
                        ),
                        const SizedBox(height: 12),
                        const Text('Recommended Platforms', style: TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 4),
                        Wrap(
                          spacing: 8.0,
                          children: analysis.platforms.map((platform) => Chip(label: Text(platform))).toList(),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
