import 'dart:io';

class FileRepository {
  final String dataPath;

  FileRepository({required this.dataPath});

  Future<List<String>> readCsvLines(String fileName) async {
    try {
      final file = File('$dataPath/$fileName');
      if (!await file.exists()) {
        throw FileSystemException('File not found: $fileName');
      }
      
      final content = await file.readAsString();
      final lines = content.split('\n');
      
      // Skip header line and empty lines
      return lines.where((line) => line.trim().isNotEmpty).skip(1).toList();
    } catch (e) {
      throw Exception('Error reading $fileName: $e');
    }
  }
}
