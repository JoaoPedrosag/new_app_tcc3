import 'package:flutter/material.dart';

class SpeechPage extends StatelessWidget {
  const SpeechPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Speech to Text'),
      ),
      body: Center(
        child: Text('Speech to Text'),
      ),
    );
  }
}
