import 'package:app_hospital/src/modules/record/presenter/cubits/record_state.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_sound/flutter_sound.dart';

import '../../repository/record_impl.dart';

class RecordCubit extends Cubit<RecordState> {
  final FlutterSoundRecorder _myRecorder = FlutterSoundRecorder();
  RecordCubit() : super(InitialRecordState()) {
    _initRecord();
  }

  final bool openSession = false;

  String text = '';

  final TextEditingController textEditingController = TextEditingController();

  final voiceRepository = Modular.get<SpeechImpl>();

  void _initRecord() async {
    await _myRecorder.openRecorder();
    emit(InitialRecordState());
  }

  // Future<void> startListening() async {
  //   if (speechToText.isListening) {
  //     await speechToText.stop();
  //     emit(InitialSpeechState());
  //     return;
  //   }
  //   await speechToText.listen(
  //     onResult: _onSpeechResult,
  //     pauseFor: const Duration(seconds: 20),
  //     listenFor: const Duration(seconds: 60),
  //     localeId: 'pt_BR',
  //     cancelOnError: true,
  //   );
  //   text = '';
  //   emit(RecordingSpeechState());
  // }

  Future<void> startRecording() async {
    if (_myRecorder.isRecording) {
      await _myRecorder.stopRecorder();
      emit(InitialRecordState());
      return;
    }
    final String nameFile = DateTime.now().toString();
    await _myRecorder.startRecorder(
      toFile: '/data/user/0/com.example.app_hospital/app_flutter/$nameFile.wav',
      codec: Codec.defaultCodec,
    );
    print('/data/user/0/com.example.app_hospital/app_flutter/$nameFile.wav');
    emit(RecordingRecordState());
  }

  Future<void> uploadFile() {
    return voiceRepository.uploadFile(
      path:
          '/data/user/0/com.example.app_hospital/app_flutter/2023-09-30 13:23:36.879714.wav',
      nameFile: '2023-09-30 13:23:36.879714.wav',
    );
  }

  void _onRecordResult() {
    // if (result.finalResult) {
    //   text += "${result.recognizedWords} ";
    //   textEditingController.text += "${result.recognizedWords} ";
    //   textEditingController.selection = TextSelection.fromPosition(
    //     TextPosition(offset: textEditingController.text.length),
    //   );

    //   _wordsRecord.add(result.recognizedWords);
    //   emit(RecognizedRecordState(text: result.recognizedWords));
    // } else {
    //   text = "${result.recognizedWords} ";
    //   emit(RecordingRecordState());
    // }
  }

  void clearText() {
    textEditingController.clear();
    emit(ClearRecordState());
  }

  void saveText() async {
    final text = textEditingController.text;
    final nameFile = DateTime.now().toString();
    await voiceRepository.saveFile(text: text, nameFile: nameFile);

    final string = await voiceRepository.readFile(nameFile: nameFile);

    print(string);
  }

  void closeRecorder() async {
    await _myRecorder.closeRecorder();
    emit(InitialRecordState());
  }
}
