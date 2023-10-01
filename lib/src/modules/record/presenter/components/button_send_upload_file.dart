import 'package:app_hospital/src/modules/record/presenter/cubits/record_state.dart';
import 'package:app_hospital/src/modules/record/presenter/cubits/speech_cubit.dart';

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
    return FloatingActionButton(
      backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
      heroTag: null,
      onPressed: () {
        cubit.uploadFile();
      },
      tooltip: 'Enviar',
      child: const Icon(Icons.send),
    );
  }
}
