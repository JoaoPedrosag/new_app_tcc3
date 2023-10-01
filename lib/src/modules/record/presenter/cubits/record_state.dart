sealed class RecordState {}

final class InitialRecordState extends RecordState {}

class RecordingProgressState extends RecordState {
  final Duration duration;

  RecordingProgressState({required this.duration});
}

class AudioProgressState extends RecordState {}

class AudioStoppedState extends RecordState {}

final class StoppedRecordState extends RecordState {}

final class ClearRecordState extends RecordState {}

final class ErrorRecordState extends RecordState {
  final String message;

  ErrorRecordState({required this.message});
}
