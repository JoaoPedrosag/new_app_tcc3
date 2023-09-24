import 'package:flutter/material.dart';

import '../cubits/speech_cubit.dart';
import '../cubits/speech_state.dart';

class ButtonFloatinSaveText extends StatelessWidget {
  final SpeechCubit cubit;
  final SpeechState state;
  final bool isKeyboardOpen;
  const ButtonFloatinSaveText(
      {super.key,
      required this.cubit,
      required this.state,
      required this.isKeyboardOpen});

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: isKeyboardOpen ? 0 : 1,
      duration: const Duration(milliseconds: 500),
      child: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
        heroTag: null,
        onPressed: () {
          cubit.saveText();
        },
        tooltip: 'Salvar texto',
        child: Icon(state is RecordingSpeechState ? null : Icons.print),
      ),
    );
  }
}
