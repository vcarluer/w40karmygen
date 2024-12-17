import '../../domain/models/faction.dart';
import 'file_repository.dart';

class FactionRepository {
  final FileRepository fileRepository;
  static const String fileName = 'Factions.csv';

  FactionRepository({required this.fileRepository});

  Future<List<Faction>> loadFactions() async {
    try {
      final lines = await fileRepository.readCsvLines(fileName);
      
      return lines.map((line) {
        final parts = line.split('|');
        if (parts.length < 3) {
          throw FormatException('Invalid faction data format: $line');
        }
        return Faction(
          id: parts[0].trim(),
          name: parts[1].trim(),
          link: parts[2].trim(),
        );
      }).toList();
    } catch (e) {
      throw Exception('Error loading factions: $e');
    }
  }
}
