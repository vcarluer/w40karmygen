import 'package:flutter/services.dart' show rootBundle;

class FileRepository {
  final String dataPath;

  FileRepository({required this.dataPath});

  Future<List<String>> readCsvLines(String fileName) async {
    try {
      String content = await rootBundle.loadString('$dataPath/$fileName');
      
      // Remove BOM if present
      if (content.startsWith('\uFEFF')) {
        content = content.substring(1);
      }
      
      final lines = content.split('\n');
      
      // Skip header line and empty lines
      return lines
        .where((line) => line.trim().isNotEmpty)
        .skip(1)
        .map((line) => line.trim())
        .toList();
    } catch (e) {
      throw Exception('Error reading $fileName: $e');
    }
  }
}
