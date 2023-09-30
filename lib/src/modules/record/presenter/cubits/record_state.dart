sealed class RecordState {}

final class InitialRecordState extends RecordState {}

final class RecordingRecordState extends RecordState {}

final class RecognizedRecordState extends RecordState {
  final String text;

  RecognizedRecordState({required this.text});
}

final class StoppedRecordState extends RecordState {}

final class ClearRecordState extends RecordState {}

final class ErrorRecordState extends RecordState {
  final String message;

  ErrorRecordState({required this.message});
}
