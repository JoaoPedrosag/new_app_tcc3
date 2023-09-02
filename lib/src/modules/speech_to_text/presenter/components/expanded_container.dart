import 'package:app_hospital/src/modules/speech_to_text/presenter/cubits/speech_cubit.dart';
import 'package:app_hospital/src/modules/speech_to_text/presenter/cubits/speech_state.dart';
import 'package:flutter/material.dart';

class ExpandedContainer extends StatelessWidget {
  final SpeechCubit cubit;
  final SpeechState state;
  const ExpandedContainer(
      {super.key, required this.cubit, required this.state});

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          controller: scrollController,
          child: TextField(
            controller: cubit.textEditingController,
            readOnly: state is RecordingSpeechState,
            decoration: InputDecoration(
                hintText: state is RecordingSpeechState
                    ? 'Escutando...'
                    : 'Aperte uma vez para comecar a gravar...'),
            maxLines: null,
          ),
        ),
      ),
    );
  }
}
