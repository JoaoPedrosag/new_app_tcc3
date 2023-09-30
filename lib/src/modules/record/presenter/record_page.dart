import 'package:app_hospital/src/modules/record/presenter/components/button_floating_action_right.dart';
import 'package:app_hospital/src/modules/record/presenter/components/list_tile_custom.dart';
import 'package:app_hospital/src/modules/record/presenter/cubits/record_state.dart';
import 'package:app_hospital/src/modules/record/presenter/cubits/speech_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

class RecordPage extends StatefulWidget {
  const RecordPage({super.key});

  @override
  State<RecordPage> createState() => _RecordPageState();
}

class _RecordPageState extends State<RecordPage> {
  @override
  Widget build(BuildContext context) {
    final cubit = Modular.get<RecordCubit>();
    bool isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom != 0.0;
    return BlocBuilder<RecordCubit, RecordState>(
      bloc: cubit,
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Visibility(
              visible: state is RecordingRecordState,
              replacement: const Text('Gravar evolução de paciente'),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Escutando...'),
                ],
              ),
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // Visibility(
              //   visible: state is RecognizedRecordState,
              //   child: ButtonFloatinSaveText(
              //     cubit: cubit,
              //     isKeyboardOpen: isKeyboardOpen,
              //     state: state,
              //   ),
              // ),
              // const SizedBox(height: 16),
              ButtonFloatingActionRight(
                cubit: cubit,
                isKeyboardOpen: isKeyboardOpen,
                state: state,
              ),
            ],
          ),
          body: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const ListTileCustom(
                    namePatient: 'João da silva',
                    idPatient: 1,
                    date: '01/01/2021',
                  ),
                  StreamBuilder<Duration>(
                    stream: cubit.durationStream,
                    builder: (context, snapshot) {
                      final duration = snapshot.data ?? Duration.zero;
                      return Visibility(
                        visible: state is RecordingRecordState,
                        child: Text(
                          'Escutando... ${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}',
                        ),
                      );
                    },
                  ),
                ],
              ),
              // ButtonFloatingActionLeft(
              //   isKeyboardOpen: isKeyboardOpen,
              //   cubit: cubit,
              // ),
            ],
          ),
        );
      },
    );
  }
}
