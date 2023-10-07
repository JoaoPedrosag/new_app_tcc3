import 'package:app_hospital/src/modules/recording/presenter/cubits/record_state.dart';
import 'package:app_hospital/src/modules/recording/presenter/cubits/speech_cubit.dart';
import 'package:flutter/material.dart';

class ButtonSendUploadFile extends StatelessWidget {
  final RecordCubit cubit;
  final RecordState state;

  const ButtonSendUploadFile({
    super.key,
    required this.cubit,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible:
          cubit.lastRecordedPath != null && state is! RecordingProgressState,
      child: Positioned(
        bottom: 45,
        right: 10,
        child: FloatingActionButton(
          backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
          heroTag: null,
          onPressed: () {
            cubit.uploadFile();
          },
          tooltip: 'Enviar',
          child: const Icon(Icons.send),
        ),
      ),
    );
  }
}
