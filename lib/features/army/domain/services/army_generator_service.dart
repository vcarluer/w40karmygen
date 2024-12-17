import '../../data/services/openrouter_service.dart';
import '../models/unit.dart';
import '../models/faction.dart';

class ArmyGeneratorService {
  final OpenRouterService _openRouterService;

  ArmyGeneratorService(this._openRouterService);

  Future<String> generateArmyList(
    List<Unit> collection, 
    Faction? faction, 
    int pointsLimit,
    {String? additionalInstructions}
  ) async {
    // Create a prompt that describes the available units and constraints
    final prompt = _createGenerationPrompt(
      collection, 
      faction, 
      pointsLimit,
      additionalInstructions: additionalInstructions
    );
    
    try {
      return await _openRouterService.generateArmyList(prompt);
    } catch (e) {
      throw Exception('Failed to generate army list: $e');
    }
  }

  String _createGenerationPrompt(
    List<Unit> collection, 
    Faction? faction, 
    int pointsLimit,
    {String? additionalInstructions}
  ) {
    final buffer = StringBuffer();
    buffer.writeln('Create a Warhammer 40,000 army list with the following constraints:');
    buffer.writeln('Points Limit: $pointsLimit points');
    
    if (faction != null) {
      buffer.writeln('Faction: ${faction.name}');
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
    buffer.writeln('1. Starts with a thematic name for the army list (prefixed with "Name: ")');
    buffer.writeln('2. Maximizes combat effectiveness');
    buffer.writeln('3. Stays within the points limit');
    buffer.writeln('4. Uses available units from the collection when possible');
    buffer.writeln('5. Follows army composition rules');
    buffer.writeln('6. Marks any units not in the collection with "[NOT IN COLLECTION]" at the end of the unit line');
    if (additionalInstructions != null && additionalInstructions.isNotEmpty) {
      buffer.writeln('7. Follows the special instructions provided');
      buffer.writeln('8. Provides a brief explanation of the list\'s strategy');
    } else {
      buffer.writeln('7. Provides a brief explanation of the list\'s strategy');
    }

    buffer.writeln('\nFormat your response as:');
    buffer.writeln('Name: [Thematic army name]');
    buffer.writeln('\n[Army list content with points cost for each unit]');
    buffer.writeln('Example format for units:');
    buffer.writeln('- Unit Name (points cost)');
    buffer.writeln('- Unit Name (points cost) [NOT IN COLLECTION]');
    buffer.writeln('\nStrategy:');
    buffer.writeln('[Strategy explanation]');
    buffer.writeln('\nTotal Points: [Total points cost]');
    buffer.writeln('\nRequired Purchases:');
    buffer.writeln('[List of all units marked with [NOT IN COLLECTION]]');

    return buffer.toString();
  }
}
