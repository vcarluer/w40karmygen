import '../../domain/models/datasheet_cost.dart';
import 'file_repository.dart';

class DatasheetCostRepository {
  final FileRepository fileRepository;
  static const String fileName = 'Datasheets_models_cost.csv';

  DatasheetCostRepository({required this.fileRepository});

  Future<List<DatasheetCost>> loadDatasheetCosts() async {
    try {
      final lines = await fileRepository.readCsvLines(fileName);
      
      return lines.map((line) {
        final parts = line.split('|');
        if (parts.length < 4) {
          throw FormatException('Invalid datasheet cost data format: $line');
        }
        
        return DatasheetCost(
          datasheetId: parts[0],
          line: int.parse(parts[1]),
          description: parts[2],
          cost: int.parse(parts[3]),
        );
      }).toList();
    } catch (e) {
      throw Exception('Error loading datasheet costs: $e');
    }
  }
}
