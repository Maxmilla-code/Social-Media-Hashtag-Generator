import 'package:flutter/material.dart';
import '../models/hashtag_analysis.dart';
import '../services/hashtag_service.dart';
import 'results_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _controller = TextEditingController();
  final HashtagService _hashtagService = HashtagService();
  bool _isLoading = false;

  void _generateHashtags() async {
    if (_controller.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a topic')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final List<HashtagAnalysis> analyses = await _hashtagService.getHashtagAnalysis(_controller.text);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ResultsScreen(analyses: analyses),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error generating hashtags: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hashtag Generator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Enter a topic (e.g., "skincare")',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            _isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _generateHashtags,
                    child: const Text('Generate Hashtags'),
                  ),
          ],
        ),
      ),
    );
  }
}
