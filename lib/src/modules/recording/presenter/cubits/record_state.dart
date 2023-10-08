sealed class RecordState {}

final class InitialRecordState extends RecordState {}

class RecordingProgressState extends RecordState {
  final Duration duration;

  RecordingProgressState({required this.duration});
}

final class AudioProgressState extends RecordState {}

final class AudioStoppedState extends RecordState {}

final class ClearRecordState extends RecordState {}

final class LoadingRecordState extends RecordState {}

final class ErrorRecordState extends RecordState {
  final String message;

  ErrorRecordState({required this.message});
}
