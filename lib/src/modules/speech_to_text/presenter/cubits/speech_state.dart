sealed class SpeechState {}

final class InitialSpeechState extends SpeechState {}

final class RecordingSpeechState extends SpeechState {}

final class RecognizedSpeechState extends SpeechState {
  final String text;

  RecognizedSpeechState({required this.text});
}

final class StoppedSpeechState extends SpeechState {}

final class ClearSpeechState extends SpeechState {}

final class ErrorSpeechState extends SpeechState {
  final String message;

  ErrorSpeechState({required this.message});
}
