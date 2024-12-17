import '../../data/services/openrouter_service.dart';
import '../models/unit.dart';
import '../models/faction.dart';

class ArmyOptimizerService {
  final OpenRouterService _openRouterService;

  ArmyOptimizerService(this._openRouterService);

  Future<String> optimizeArmyList(
    List<Unit> collection, 
    Faction? selectedFaction, 
    int pointsLimit,
    {String? additionalInstructions}
  ) async {
    // Create a prompt that describes the available units and constraints
    final prompt = _createOptimizationPrompt(
      collection, 
      selectedFaction, 
      pointsLimit,
      additionalInstructions: additionalInstructions
    );
    
    try {
      return await _openRouterService.generateOptimizedList(prompt);
    } catch (e) {
      throw Exception('Failed to optimize army list: $e');
    }
  }

  String _createOptimizationPrompt(
    List<Unit> collection, 
    Faction? selectedFaction, 
    int pointsLimit,
    {String? additionalInstructions}
  ) {
    final buffer = StringBuffer();
    buffer.writeln('Create an optimized Warhammer 40,000 army list with the following constraints:');
    buffer.writeln('Points Limit: $pointsLimit points');
    
    if (selectedFaction != null) {
      buffer.writeln('Faction: ${selectedFaction.name}');
    }

    if (additionalInstructions != null && additionalInstructions.isNotEmpty) {
      buffer.writeln('\nSpecial Instructions:');
      buffer.writeln(additionalInstructions);
    }

    buffer.writeln('\nAvailable units from collection:');
    for (final unit in collection) {
      buffer.writeln('- ${unit.quantity}x ${unit.datasheet.name} (${unit.points} points each)');
    }

    buffer.writeln('\nPlease create an army list that:');
    buffer.writeln('1. Maximizes combat effectiveness');
    buffer.writeln('2. Stays within the points limit');
    buffer.writeln('3. Uses only available units from the collection');
    buffer.writeln('4. Follows army composition rules');
    if (additionalInstructions != null && additionalInstructions.isNotEmpty) {
      buffer.writeln('5. Follows the special instructions provided');
      buffer.writeln('6. Provides a brief explanation of the list\'s strategy');
    } else {
      buffer.writeln('5. Provides a brief explanation of the list\'s strategy');
    }

    return buffer.toString();
  }
}