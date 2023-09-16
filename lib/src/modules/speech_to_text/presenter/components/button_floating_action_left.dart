import 'package:app_hospital/src/modules/speech_to_text/presenter/cubits/speech_cubit.dart';
import 'package:flutter/material.dart';

class ButtonFloatingActionLeft extends StatelessWidget {
  final bool isKeyboardOpen;
  final SpeechCubit cubit;
  const ButtonFloatingActionLeft(
      {super.key, required this.isKeyboardOpen, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 16,
      bottom: 16,
      child: AnimatedOpacity(
        opacity: isKeyboardOpen ? 0 : 1,
        duration: const Duration(milliseconds: 500),
        child: FloatingActionButton(
          onPressed: () {
            cubit.saveText();
            // cubit.clearText();
          },
          tooltip: 'Limpar',
          backgroundColor: Theme.of(context).colorScheme.error,
          child: const Icon(Icons.clear),
        ),
      ),
    );
  }
}
