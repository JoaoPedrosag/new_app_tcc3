import 'package:app_hospital/src/modules/speech_to_text/presenter/components/button_floating_action_left.dart';
import 'package:app_hospital/src/modules/speech_to_text/presenter/components/button_floating_action_right.dart';
import 'package:app_hospital/src/modules/speech_to_text/presenter/components/expanded_container.dart';
import 'package:app_hospital/src/modules/speech_to_text/presenter/components/image_filter_custom.dart';
import 'package:app_hospital/src/modules/speech_to_text/presenter/components/list_tile_custom.dart';
import 'package:app_hospital/src/modules/speech_to_text/presenter/cubits/speech_cubit.dart';
import 'package:app_hospital/src/modules/speech_to_text/presenter/cubits/speech_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_sound/flutter_sound.dart';

class SpeechPage extends StatefulWidget {
  const SpeechPage({super.key});

  @override
  State<SpeechPage> createState() => _SpeechPageState();
}

class _SpeechPageState extends State<SpeechPage> {
  final cubit = Modular.get<SpeechCubit>();
  @override
  void initState() {
    cubit.initSession();
    super.initState();
  }

  @override
  void dispose() {
    cubit.disposeSession();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom != 0.0;
    return BlocBuilder<SpeechCubit, SpeechState>(
      bloc: cubit,
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Visibility(
              visible: state is RecordingSpeechState,
              replacement: const Text('Gravar evolução de paciente'),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Escutando...'),
                ],
              ),
            ),
          ),
          floatingActionButton: ButtonFloatingActionRight(
            cubit: cubit,
            isKeyboardOpen: isKeyboardOpen,
            state: state,
          ),
          body: Stack(
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const ListTileCustom(
                      namePatient: 'João da silva',
                      idPatient: 1,
                      date: '01/01/2021',
                    ),
                    ExpandedContainer(cubit: cubit, state: state)
                  ],
                ),
              ),
              ButtonFloatingActionLeft(
                isKeyboardOpen: isKeyboardOpen,
                cubit: cubit,
              ),
              Visibility(
                visible: state is RecordingSpeechState,
                child: ImageFilterCustom(
                  cubit: cubit,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
