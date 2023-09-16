import 'package:path_provider/path_provider.dart';

import 'i_path_provider.dart';

class PathProviderImpl implements PathProvider {
  @override
  Future<String> getLocalPath() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      return directory.path;
    } catch (e) {
      throw Exception(e);
    }
  }
}
