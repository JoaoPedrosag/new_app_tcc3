import 'package:flutter/material.dart';

class CircularProgressCustom extends StatelessWidget {
  const CircularProgressCustom({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Enviando arquivo...'),
        SizedBox(height: 20),
        Center(child: CircularProgressIndicator()),
      ],
    );
  }
}
