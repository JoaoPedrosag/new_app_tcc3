import 'dart:ui';

import 'package:app_hospital/src/modules/speech_to_text/presenter/components/list_tile_custom.dart';
import 'package:app_hospital/src/modules/speech_to_text/presenter/cubits/speech_cubit.dart';
import 'package:app_hospital/src/modules/speech_to_text/presenter/cubits/speech_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SpeechPage extends StatelessWidget {
  const SpeechPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();
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
                )),
          ),
          floatingActionButton: AnimatedOpacity(
            opacity: isKeyboardOpen ? 0 : 1,
            duration: const Duration(milliseconds: 500),
            child: FloatingActionButton(
              backgroundColor: state is RecordingSpeechState
                  ? Colors.green
                  : Theme.of(context).primaryColor,
              heroTag: null,
              onPressed: () {
                cubit.startListening();
              },
              tooltip: 'Escutando',
              child: Icon(
                  state is RecordingSpeechState ? Icons.mic : Icons.mic_off),
            ),
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
                    Expanded(
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
                    ),
                  ],
                ),
              ),
              Positioned(
                left: 16,
                bottom: 16,
                child: AnimatedOpacity(
                  opacity: isKeyboardOpen ? 0 : 1,
                  duration: const Duration(milliseconds: 500),
                  child: FloatingActionButton(
                    onPressed: () {
                      cubit.clearText();
                    },
                    tooltip: 'Limpar',
                    backgroundColor: Colors.red,
                    child: const Icon(Icons.clear),
                  ),
                ),
              ),
              if (state is RecordingSpeechState)
                Positioned.fill(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                    child: Container(
                      color: Colors.black.withOpacity(0.7),
                      child: Center(
                        child: Text(
                          cubit.text,
                          style: const TextStyle(
                              fontSize: 20, color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
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
