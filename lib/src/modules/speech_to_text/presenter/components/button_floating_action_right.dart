import 'package:app_hospital/src/modules/speech_to_text/presenter/cubits/speech_cubit.dart';
import 'package:app_hospital/src/modules/speech_to_text/presenter/cubits/speech_state.dart';
import 'package:flutter/material.dart';

class ButtonFloatingActionRight extends StatelessWidget {
  final SpeechCubit cubit;
  final SpeechState state;
  final bool isKeyboardOpen;

  const ButtonFloatingActionRight({
    super.key,
    required this.cubit,
    required this.state,
    required this.isKeyboardOpen,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: isKeyboardOpen ? 0 : 1,
      duration: const Duration(milliseconds: 500),
      child: FloatingActionButton(
        backgroundColor: state is RecordingSpeechState
            ? Theme.of(context).colorScheme.secondaryContainer
            : Theme.of(context).colorScheme.primary,
        heroTag: null,
        onPressed: () {
          cubit.startRecording();
        },
        tooltip: 'Escutando',
        child: Icon(state is RecordingSpeechState ? Icons.mic : Icons.mic_off),
      ),
    );
  }
}
