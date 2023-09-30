abstract class ISpeech {
  Future<bool> saveFile({required String text, required String nameFile});

  Future<String> readFile({required String nameFile});

  Future<bool> uploadFile({required String path, required String nameFile});
}
