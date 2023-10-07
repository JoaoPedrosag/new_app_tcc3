import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:app_hospital/src/modules/recording/presenter/cubits/record_state.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:uuid/uuid.dart';

import '../../domain/use_cases/record_impl.dart';

class RecordCubit extends Cubit<RecordState> {
  final FlutterSoundRecorder _myRecorder = FlutterSoundRecorder();
  final FlutterSoundPlayer _myPlayer = FlutterSoundPlayer();

  final Codec _codec = Codec.aacADTS;

  Duration? totalDuration;
  Duration? currentPosition;

  RecordCubit() : super(InitialRecordState()) {
    _initRecord();
  }

  Timer? _timer;
  int elapsedSeconds = 0;
  String? lastRecordedPath;

  final voiceRepository = Modular.get<SpeechImpl>();

  Future<void> _initRecord() async {
    await openTheRecorder();
    await _initPlayer();

    emit(InitialRecordState());
  }

  Future<void> _initPlayer() async {
    await _myPlayer.openPlayer();
  }

  Future<void> playLastRecordedFile() async {
    if (state is AudioProgressState) {
      await pausePlaying();
      emit(AudioStoppedState());
      return;
    }
    if (lastRecordedPath != null) {
      if (_myPlayer.isPaused) {
        await _myPlayer.resumePlayer();
        emit(AudioProgressState());
        return;
      }
      await _myPlayer.startPlayer(
          fromURI: lastRecordedPath,
          whenFinished: () {
            currentPosition = null;
            emit(AudioStoppedState());
          });
      emit(AudioProgressState());
    } else {
      log("Nenhum arquivo para tocar.");
    }
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
    try {
      if (lastRecordedPath != null) {
        emit(LoadingRecordState());
        Future.delayed(const Duration(seconds: 5));
        final Directory tempDir = await getTemporaryDirectory();
        final String pathTotal = '${tempDir.path}/${lastRecordedPath!}';
        await voiceRepository.uploadFile(
          path: pathTotal,
          nameFile: lastRecordedPath!,
        );

        clearRecord();
      }
    } on Exception {
      emit(ErrorRecordState(message: 'Erro ao enviar arquivo'));
    }
  }

  Future<void> pausePlaying() async {
    if (_myPlayer.isPlaying && !_myPlayer.isPaused) {
      await _myPlayer.pausePlayer();
    }
  }

  Future<void> resumePlaying() async {
    await _myPlayer.resumePlayer();
  }

  Future<void> seekToPosition(int positionInMilliseconds) async {
    await _myPlayer
        .seekToPlayer(Duration(milliseconds: positionInMilliseconds));
  }

  void clearRecord() {
    lastRecordedPath = null;
    emit(ClearRecordState());
  }
}
