import 'package:app_hospital/src/modules/record/presenter/cubits/speech_cubit.dart';
import 'package:flutter/material.dart';

import '../cubits/record_state.dart';

class ButtonFloatinSaveText extends StatelessWidget {
  final RecordCubit cubit;
  final RecordState state;
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
        child: Icon(state is RecordingRecordState ? null : Icons.print),
      ),
    );
  }
}
