import 'package:flutter/material.dart';

import '../cubits/record_state.dart';

class TextListening extends StatelessWidget {
  final RecordState state;
  const TextListening({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: state is RecordingProgressState,
      child: (state is RecordingProgressState)
          ? Text(
              'Escutando... ${(state as RecordingProgressState).duration.inSeconds} segundos')
          : Container(),
    );
  }
}
