sealed class SpeechState {}

final class InitialSpeechState extends SpeechState {}

final class RecordingSpeechState extends SpeechState {}

final class ErrorSpeechState extends SpeechState {
  final String? message;

  ErrorSpeechState({this.message = 'Erro ao gravar áudio.'});
}
