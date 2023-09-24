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

import 'components/button_floating_save_text.dart';

class SpeechPage extends StatefulWidget {
  const SpeechPage({super.key});

  @override
  State<SpeechPage> createState() => _SpeechPageState();
}

class _SpeechPageState extends State<SpeechPage> {
  bool isGraver = false;
  FlutterSoundRecorder _myRecorder = FlutterSoundRecorder();

  @override
  void initState() {
    super.initState();
    // Be careful : openAudioSession return a Future.
    // Do not access your FlutterSoundPlayer or FlutterSoundRecorder before the completion of the Future
    _myRecorder.openRecorder().then((value) {
      print('value = $value');
    });
  }

  @override
  void dispose() {
    // Be careful : you must `close` the audio session when you have finished with it.
    _myRecorder.closeRecorder();
    super.dispose();
  }

  Future<void> record() async {
    final String nameFile = DateTime.now().toString();
    await _myRecorder.startRecorder(
      toFile: '/data/user/0/com.example.app_hospital/app_flutter/$nameFile.aac',
      codec: Codec.aacADTS,
    );
  }

  Future<void> stopRecorder() async {
    await _myRecorder.stopRecorder();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = Modular.get<SpeechCubit>();
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
          floatingActionButton: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                  onPressed: () {
                    if (!isGraver) {
                      record();

                      isGraver = true;
                    } else {
                      isGraver = false;
                      stopRecorder();
                    }
                  },
                  child: const Text('Gravar')),
              Visibility(
                visible: state is RecognizedSpeechState,
                child: ButtonFloatinSaveText(
                  cubit: cubit,
                  isKeyboardOpen: isKeyboardOpen,
                  state: state,
                ),
              ),
              const SizedBox(height: 16),
              ButtonFloatingActionRight(
                cubit: cubit,
                isKeyboardOpen: isKeyboardOpen,
                state: state,
              ),
            ],
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
