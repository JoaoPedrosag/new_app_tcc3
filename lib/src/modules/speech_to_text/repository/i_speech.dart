abstract class ISpeech {
  Future<bool> saveFile({required String text, required String nameFile});

  Future<String> readFile({required String nameFile});
}
