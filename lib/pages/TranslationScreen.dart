import 'package:flutter/material.dart';
import 'dart:math';
import '../phrases.dart';

class TranslationScreen extends StatefulWidget {
  const TranslationScreen({super.key});

  @override
  _TranslationScreenState createState() => _TranslationScreenState();
}

class _TranslationScreenState extends State<TranslationScreen> {
  int currentPhraseIndex = 0;
  TextEditingController _controller = TextEditingController();
  String feedback = '';

  @override
  void initState() {
    super.initState();
    _setRandomPhrase();
  }

  void _setRandomPhrase() {
    final random = Random();
    currentPhraseIndex = random.nextInt(phrases.length);
  }

  void checkAnswer() {
    final userAnswer = _controller.text.trim();
    final correctAnswer = phrases[currentPhraseIndex]['danish']!;

    setState(() {
      if (userAnswer.toLowerCase() == correctAnswer.toLowerCase()) {
        feedback = 'Korrekt!';
        // Move to next phrase after a short delay
        Future.delayed(const Duration(seconds: 1), () {
          setState(() {
            currentPhraseIndex = (currentPhraseIndex + 1) % phrases.length;
            feedback = '';
            _controller.clear();
          });
        });
      } else {
        feedback = 'Oops! Prøv igen';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentPhrase = phrases[currentPhraseIndex];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Oversæt hverdagssætninger'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // German phrase display
            Text(
              currentPhrase['german']!,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 15),

            // Danish input field
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Skriv dansk oversættelse',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),

            // Feedback text
            Text(
              feedback,
              style: TextStyle(
                color: feedback == 'Korrekt!' ? Colors.green : Colors.red,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 15),

            // Submit button
            ElevatedButton(
              onPressed: checkAnswer,
              child: const Text('Check svar'),
            ),
          ],
        ),
      ),
    );
  }
}