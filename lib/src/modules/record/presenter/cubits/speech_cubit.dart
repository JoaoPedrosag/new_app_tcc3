import 'dart:async';
import 'dart:developer';
import 'package:app_hospital/src/modules/record/presenter/cubits/record_state.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:uuid/uuid.dart';

import '../../repository/record_impl.dart';

class RecordCubit extends Cubit<RecordState> {
  final FlutterSoundRecorder _myRecorder = FlutterSoundRecorder();

  final Codec _codec = Codec.aacADTS;

  RecordCubit() : super(InitialRecordState()) {
    _initRecord();
  }

  Timer? _timer;
  int elapsedSeconds = 0;
  String? lastRecordedPath;

  final voiceRepository = Modular.get<SpeechImpl>();

  void _initRecord() async {
    await openTheRecorder();

    emit(InitialRecordState());
  }

  Future<void> openTheRecorder() async {
    var status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      return;
    }
    await _myRecorder.openRecorder();
  }

  Future<void> startRecording() async {
    emit(RecordingProgressState(duration: Duration(seconds: elapsedSeconds)));
    if (_myRecorder.isRecording) {
      await stopRecording();
      return;
    }
    const uuid = Uuid();
    final String randomFileName = '${uuid.v4()}.aac';
    await _myRecorder.startRecorder(
      codec: _codec,
      toFile: randomFileName,
    );
    lastRecordedPath = randomFileName;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      elapsedSeconds++;
      emit(RecordingProgressState(duration: Duration(seconds: elapsedSeconds)));
    });
  }

  Future<void> stopRecording() async {
    await _myRecorder.stopRecorder();
    _timer?.cancel();
    elapsedSeconds = 0;
    emit(InitialRecordState());
  }

  Future<void> uploadFile() async {
    if (lastRecordedPath != null) {
      await voiceRepository.uploadFile(
        path: lastRecordedPath!,
        nameFile: lastRecordedPath!.split('/').last,
      );
    } else {
      log("Nenhum arquivo para enviar.");
    }
  }
}
