import 'package:app_hospital/src/modules/speech_to_text/presenter/cubits/speech_cubit.dart';
import 'package:app_hospital/src/modules/speech_to_text/presenter/cubits/speech_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class SpeechPage extends StatefulWidget {
  const SpeechPage({super.key});

  @override
  State<SpeechPage> createState() => _SpeechPageState();
}

class _SpeechPageState extends State<SpeechPage> {
  final SpeechToText _speechToText = SpeechToText();
  final TextEditingController _textEditingController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _speechEnabled = false;
  late final SpeechCubit cubit;
  String _lastWords = '';

  @override
  void initState() {
    super.initState();
    cubit = BlocProvider.of<SpeechCubit>(context);
    _initSpeech();
  }

  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }

  void _startListening() async {
    await _speechToText.listen(
      onResult: _onSpeechResult,
      pauseFor: const Duration(seconds: 20),
      listenFor: const Duration(seconds: 60),
      localeId: 'pt_BR',
      cancelOnError: true,
    );
    setState(() {});
  }

  void _stopListening() async {
    await _speechToText.stop();
    setState(() {});
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    if (result.finalResult) {
      setState(() {
        _textEditingController.text += result.recognizedWords + " ";
        _textEditingController.selection = TextSelection.fromPosition(
            TextPosition(offset: _textEditingController.text.length));
      });
      _scrollController.animateTo(_scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300), curve: Curves.easeOut);
    }
  }

  void _clearText() {
    setState(() {
      _textEditingController
          .clear(); // Supondo que você esteja usando um TextEditingController
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gravar evolução de paciente'),
      ),
      body: Stack(
        children: [
          BlocBuilder<SpeechCubit, SpeechState>(
              bloc: cubit,
              builder: (context, state) {
                return switch (state) {
                  InitialSpeechState() => Container(),
                  RecordingSpeechState() => Container(),
                  ErrorSpeechState() => Container(),
                };
              }),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  child: ListTile(
                    title: Text('Paciente: Joao da Silva'),
                    subtitle: Text('Data da internação: 01/01/2021'),
                    leading: ClipOval(
                      child: Image.asset(
                        'assets/img/user.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    child: SingleChildScrollView(
                      controller: _scrollController,
                      child: TextField(
                        controller: _textEditingController,
                        readOnly: _speechToText.isListening,
                        decoration: InputDecoration(
                          hintText: _speechToText.isListening
                              ? 'Escutando...'
                              : _speechEnabled
                                  ? 'Aperte uma vez para comecar a gravar...'
                                  : 'Gravador de voz desabilitado',
                        ),
                        maxLines: null, // Permite múltiplas linhas
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 16, // Posição horizontal
            bottom: 16, // Posição vertical a partir do fundo
            child: FloatingActionButton(
              onPressed: _clearText,
              tooltip: 'Limpar',
              child: Icon(Icons.clear),
              backgroundColor: Colors.red, // Cor do botão
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed:
            // If not yet listening for speech start, otherwise stop
            _speechToText.isNotListening ? _startListening : _stopListening,
        tooltip: 'Listen',
        child: Icon(_speechToText.isNotListening ? Icons.mic_off : Icons.mic),
      ),
    );
  }
}
