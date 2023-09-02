import 'package:app_hospital/src/modules/speech_to_text/presenter/components/list_tile_custom.dart';
import 'package:app_hospital/src/modules/speech_to_text/presenter/cubits/speech_cubit.dart';
import 'package:app_hospital/src/modules/speech_to_text/presenter/cubits/speech_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SpeechPage extends StatefulWidget {
  const SpeechPage({super.key});

  @override
  State<SpeechPage> createState() => _SpeechPageState();
}

class _SpeechPageState extends State<SpeechPage> {
  final ScrollController _scrollController = ScrollController();
  final cubit = Modular.get<SpeechCubit>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SpeechCubit, SpeechState>(
      bloc: cubit,
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Gravar evolução de paciente'),
          ),
          floatingActionButton: FloatingActionButton(
            heroTag: null,
            onPressed: () {
              cubit.startListening();
            },
            tooltip: 'Escutando',
            child:
                Icon(state is RecordingSpeechState ? Icons.mic : Icons.mic_off),
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
                          controller: _scrollController,
                          child: TextField(
                            controller: cubit.textEditingController,
                            readOnly: state is RecordingSpeechState,
                            decoration: InputDecoration(
                                hintText: state is RecordingSpeechState
                                    ? 'Escutando...'
                                    : 'Aperte uma vez para comecar a gravar...'),
                            maxLines: null, // Permite múltiplas linhas
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
                child: FloatingActionButton(
                  onPressed: () {
                    cubit.clearText();
                  },
                  tooltip: 'Limpar',
                  backgroundColor: Colors.red,
                  child: const Icon(Icons.clear),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
