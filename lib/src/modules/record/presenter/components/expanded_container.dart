import 'package:app_hospital/src/modules/record/presenter/cubits/record_state.dart';
import 'package:app_hospital/src/modules/record/presenter/cubits/speech_cubit.dart';
import 'package:flutter/material.dart';

class ExpandedContainer extends StatelessWidget {
  final RecordCubit cubit;
  final RecordState state;
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
            readOnly: state is RecordingRecordState,
            decoration: InputDecoration(
                hintText: state is RecordingRecordState
                    ? 'Escutando...'
                    : 'Aperte uma vez para comecar a gravar...'),
            maxLines: null,
          ),
        ),
      ),
    );
  }
}
