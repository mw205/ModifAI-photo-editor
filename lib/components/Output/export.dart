import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class ExportImage {
  static Future<File> downloadNetworkImage(String imageUrl) async {
    final response = await http.get(Uri.parse(imageUrl));
    final directory = await getTemporaryDirectory();
    final imagePath =
        '${directory.path}/${DateTime.now().millisecondsSinceEpoch}.jpg';
    final File file = File(imagePath);
    await file.writeAsBytes(response.bodyBytes);
    return file;
  }
}
