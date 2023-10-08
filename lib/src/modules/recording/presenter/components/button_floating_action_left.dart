import 'package:app_hospital/src/modules/recording/presenter/cubits/record_state.dart';
import 'package:app_hospital/src/modules/recording/presenter/cubits/speech_cubit.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';

class ButtonFloatingActionLeft extends StatelessWidget {
  final RecordCubit cubit;
  final RecordState state;

  const ButtonFloatingActionLeft({
    super.key,
    required this.cubit,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible:
          cubit.lastRecordedPath != null && state is! RecordingProgressState,
      child: AvatarGlow(
        animate: state is RecordingProgressState,
        glowColor: Theme.of(context).colorScheme.secondaryContainer,
        endRadius: 75.0,
        duration: const Duration(milliseconds: 2000),
        repeatPauseDuration: const Duration(milliseconds: 300),
        repeat: true,
        child: FloatingActionButton(
          backgroundColor: Theme.of(context).colorScheme.error,
          heroTag: null,
          onPressed: () {
            cubit.clearRecord();
          },
          tooltip: 'Escutando',
          child: Icon(Icons.clear,
              size: 30, color: Theme.of(context).colorScheme.onPrimary),
        ),
      ),
    );
  }
}
