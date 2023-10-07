import 'package:app_hospital/src/modules/recording/presenter/cubits/record_state.dart';
import 'package:app_hospital/src/modules/recording/presenter/cubits/speech_cubit.dart';
import 'package:flutter/material.dart';

class PlayBackComponents extends StatelessWidget {
  final RecordCubit cubit;
  final RecordState state;
  const PlayBackComponents(
      {super.key, required this.cubit, required this.state});

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible:
          cubit.lastRecordedPath != null && state is! RecordingProgressState,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: state is AudioProgressState
                    ? const Icon(
                        Icons.pause,
                        size: 45,
                      )
                    : const Icon(
                        Icons.play_arrow,
                        size: 45,
                      ),
                onPressed: () {
                  cubit.playLastRecordedFile();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
