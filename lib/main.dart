import 'package:flutter/material.dart';
import 'dart:math';
import 'phrases.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Translation App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const TranslationScreen(),
    );
  }
}

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
        feedback = 'Correct! Well done!';
        // Move to next phrase after a short delay
        Future.delayed(const Duration(seconds: 1), () {
          setState(() {
            currentPhraseIndex = (currentPhraseIndex + 1) % phrases.length;
            feedback = '';
            _controller.clear();
          });
        });
      } else {
        feedback = 'Oops! Try again.';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentPhrase = phrases[currentPhraseIndex];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Translation App'),
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
                labelText: 'Type the Danish translation',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),

            // Feedback text
            Text(
              feedback,
              style: TextStyle(
                color: feedback == 'Correct! Well done!' ? Colors.green : Colors.red,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 15),

            // Submit button
            ElevatedButton(
              onPressed: checkAnswer,
              child: const Text('Check Answer'),
            ),
          ],
        ),
      ),
    );
  }
}
