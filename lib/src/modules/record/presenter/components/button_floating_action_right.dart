import 'package:app_hospital/src/modules/record/presenter/cubits/record_state.dart';
import 'package:app_hospital/src/modules/record/presenter/cubits/speech_cubit.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';

class ButtonFloatingActionRight extends StatelessWidget {
  final RecordCubit cubit;
  final RecordState state;
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
      child: AvatarGlow(
        animate: state is RecordingProgressState,
        glowColor: Theme.of(context).colorScheme.secondaryContainer,
        endRadius: 75.0,
        duration: const Duration(milliseconds: 2000),
        repeatPauseDuration: const Duration(milliseconds: 300),
        repeat: true,
        child: FloatingActionButton(
          backgroundColor: state is RecordingProgressState
              ? Theme.of(context).colorScheme.secondaryContainer
              : Theme.of(context).colorScheme.primary,
          heroTag: null,
          onPressed: () {
            cubit.startRecording();
          },
          tooltip: 'Escutando',
          child:
              Icon(state is RecordingProgressState ? Icons.mic : Icons.mic_off),
        ),
      ),
    );
  }
}
