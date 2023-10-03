import 'package:app_hospital/src/core/const/constantes.dart';
import 'package:app_hospital/src/modules/record/presenter/cubits/player/player_state_audio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';

class PlayerCubit extends Cubit<PlayerStateAudio> {
  PlayerCubit() : super(PlayerInitial()) {
    _player.playerStateStream.listen((playerState) {
      if (playerState.processingState == ProcessingState.completed) {
        emit(PlayerCompleted());
      }
    });
  }

  final _player = AudioPlayer();

  Future<void> playAudio({required String id}) async {
    try {
      if (state is PlayerInitialized) {
        await stopAudio();
        return;
      }

      String urlAudio =
          Constants.endPoints.baseUrl + Constants.endPoints.audio + id;
      await _player.setUrl(urlAudio);
      _player.play();
      emit(PlayerInitialized());
    } on Exception {
      emit(PlayerStopped());
    }
  }

  Future<void> stopAudio() async {
    try {
      await _player.stop();
      emit(PlayerStopped());
    } on Exception {
      emit(PlayerStopped());
    }
  }
}
