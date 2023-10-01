import 'package:app_hospital/src/modules/record/presenter/components/button_floating_action_right.dart';
import 'package:app_hospital/src/modules/record/presenter/components/button_send_upload_file.dart';
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

    return BlocBuilder<RecordCubit, RecordState>(
      bloc: cubit,
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Visibility(
              visible: state is RecordingProgressState,
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
              ButtonFloatingActionRight(
                cubit: cubit,
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
                  ElevatedButton(
                      onPressed: () {
                        Modular.to.pushNamed('/record/records_patient');
                      },
                      child: const Text('Acessar ultimos registros')),
                  Visibility(
                    visible: state is RecordingProgressState,
                    child: (state is RecordingProgressState)
                        ? Text(
                            'Escutando... ${state.duration.inSeconds} segundos')
                        : Container(),
                  ),
                  Visibility(
                    visible: cubit.lastRecordedPath != null &&
                        state is! RecordingProgressState,
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
                  ),
                ],
              ),
              Visibility(
                visible: cubit.lastRecordedPath != null &&
                    state is! RecordingProgressState,
                child: Positioned(
                  bottom: 45,
                  right: 10,
                  child: ButtonSendUploadFile(
                    cubit: cubit,
                    state: state,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
