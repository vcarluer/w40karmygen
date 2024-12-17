import '../../domain/models/datasheet.dart';
import 'file_repository.dart';

class DatasheetRepository {
  final FileRepository fileRepository;
  static const String fileName = 'Datasheets.csv';

  DatasheetRepository({required this.fileRepository});

  Future<List<Datasheet>> loadDatasheets() async {
    try {
      final lines = await fileRepository.readCsvLines(fileName);
      
      return lines.map((line) {
        final parts = line.split('|');
        if (parts.length < 14) {
          throw FormatException('Invalid datasheet data format: $line');
        }
        
        return Datasheet(
          id: parts[0],
          name: parts[1],
          factionId: parts[2],
          sourceId: parts[3],
          legend: parts[4],
          role: parts[5],
          loadout: parts[6],
          transport: parts[7] == 'null' ? null : parts[7],
          virtual: parts[8] == 'true',
          leaderHead: parts[9] == 'null' ? null : parts[9],
          leaderFooter: parts[10] == 'null' ? null : parts[10],
          damagedW: parts[11] == 'null' ? null : parts[11],
          damagedDescription: parts[12] == 'null' ? null : parts[12],
          link: parts[13],
        );
      }).toList();
    } catch (e) {
      throw Exception('Error loading datasheets: $e');
    }
  }
}
