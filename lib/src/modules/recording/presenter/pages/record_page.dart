import 'package:app_hospital/src/modules/recording/presenter/components/button_floating_action_right.dart';
import 'package:app_hospital/src/modules/recording/presenter/components/button_navigate.dart';
import 'package:app_hospital/src/modules/recording/presenter/components/button_send_upload_file.dart';
import 'package:app_hospital/src/modules/recording/presenter/components/circular_progress_custom.dart';
import 'package:app_hospital/src/modules/recording/presenter/components/list_tile_custom.dart';
import 'package:app_hospital/src/modules/recording/presenter/components/play_back_component.dart';
import 'package:app_hospital/src/modules/recording/presenter/components/text_listening.dart';
import 'package:app_hospital/src/modules/recording/presenter/cubits/record_state.dart';
import 'package:app_hospital/src/modules/recording/presenter/cubits/speech_cubit.dart';
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
          body: Visibility(
              visible: state is LoadingRecordState,
              replacement: Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const ListTileCustom(
                        namePatient: 'João da silva',
                        idPatient: 1,
                        date: '01/01/2021',
                      ),
                      const ButtonNavigate(),
                      TextListening(state: state),
                      PlayBackComponents(
                        cubit: cubit,
                        state: state,
                      )
                    ],
                  ),
                  ButtonSendUploadFile(
                    cubit: cubit,
                    state: state,
                  ),
                ],
              ),
              child: const CircularProgressCustom()),
        );
      },
    );
  }
}
