import '../../data/services/openrouter_service.dart';
import '../../data/repositories/faction_repository.dart';
import '../models/unit.dart';
import '../models/faction.dart';

class ArmyGeneratorService {
  final OpenRouterService _openRouterService;
  final FactionRepository _factionRepository;

  ArmyGeneratorService(this._openRouterService, this._factionRepository);

  Future<String> generateArmyList(
    List<Unit> collection, 
    Faction? faction, 
    int pointsLimit,
    {String? additionalInstructions}
  ) async {
    // If no faction is provided, determine one based on the collection
    final effectiveFaction = faction ?? await _determineFaction(collection);
    
    // Create a prompt that describes the available units and constraints
    final prompt = _createGenerationPrompt(
      collection, 
      effectiveFaction, 
      pointsLimit,
      additionalInstructions: additionalInstructions
    );
    
    try {
      return await _openRouterService.generateArmyList(prompt);
    } catch (e) {
      throw Exception('Failed to generate army list: $e');
    }
  }

  Future<Faction> _determineFaction(List<Unit> collection) async {
    final factions = await _factionRepository.loadFactions();
    
    // Count units per faction in the collection
    final factionCounts = <String, int>{};
    for (final unit in collection) {
      final unitFactionId = unit.datasheet.factionId;
      factionCounts[unitFactionId] = (factionCounts[unitFactionId] ?? 0) + 1;
    }

    // Find the faction with the most units in collection
    String? mostCommonFactionId;
    int maxCount = 0;
    factionCounts.forEach((factionId, count) {
      if (count > maxCount) {
        maxCount = count;
        mostCommonFactionId = factionId;
      }
    });

    // Return the most common faction, or the first available if collection is empty
    return factions.firstWhere(
      (f) => f.id == mostCommonFactionId,
      orElse: () => factions.first
    );
  }

  String _createGenerationPrompt(
    List<Unit> collection, 
    Faction faction, 
    int pointsLimit,
    {String? additionalInstructions}
  ) {
    final buffer = StringBuffer();
    buffer.writeln('Create a Warhammer 40,000 army list with the following constraints:');
    buffer.writeln('Points Limit: $pointsLimit points');
    buffer.writeln('Faction: ${faction.name}');

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
    buffer.writeln('4. MUST be ${faction.name} faction-compliant');
    buffer.writeln('5. Prioritizes using units from the collection when possible');
    buffer.writeln('6. Only uses units not in the collection when necessary for faction coherency or essential army roles');
    buffer.writeln('7. Follows army composition rules');
    buffer.writeln('8. Marks any units not in the collection with "[NOT IN COLLECTION]" at the end of the unit line');
    
    if (additionalInstructions != null && additionalInstructions.isNotEmpty) {
      buffer.writeln('9. Follows the special instructions provided');
      buffer.writeln('10. Provides a brief explanation of the list\'s strategy');
    } else {
      buffer.writeln('9. Provides a brief explanation of the list\'s strategy');
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
