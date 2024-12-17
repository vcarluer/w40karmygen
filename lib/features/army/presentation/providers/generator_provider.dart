import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/config/env.dart';
import '../../data/services/openrouter_service.dart';
import '../../data/repositories/faction_repository.dart';
import '../../data/repositories/file_repository.dart';
import '../../domain/services/army_generator_service.dart';
import '../../domain/models/faction.dart';
import 'collection_provider.dart';
import 'faction_provider.dart';
import 'generated_army_provider.dart';

part 'generator_provider.g.dart';

final openRouterServiceProvider = Provider<OpenRouterService>((ref) {
  return OpenRouterService(apiKey: Env.openRouterApiKey);
});

final fileRepositoryProvider = Provider<FileRepository>((ref) {
  return FileRepository(dataPath: 'assets/data');
});

final factionRepositoryProvider = Provider<FactionRepository>((ref) {
  final fileRepository = ref.watch(fileRepositoryProvider);
  return FactionRepository(fileRepository: fileRepository);
});

final armyGeneratorServiceProvider = Provider<ArmyGeneratorService>((ref) {
  final openRouterService = ref.watch(openRouterServiceProvider);
  final factionRepository = ref.watch(factionRepositoryProvider);
  return ArmyGeneratorService(openRouterService, factionRepository);
});

@riverpod
class GenerationResult extends _$GenerationResult {
  @override
  AsyncValue<String?> build() {
    return const AsyncValue.data(null);
  }

  Future<void> generateList(
    int pointsLimit, {
    Faction? faction,
    String? additionalInstructions,
    required Function() onComplete,
  }) async {
    if (state.isLoading) {
      return; // Prevent multiple generations running at once
    }

    state = const AsyncValue.loading();
    
    try {
      final generator = ref.read(armyGeneratorServiceProvider);
      final collection = await ref.read(miniatureCollectionProvider.future);
      
      final result = await generator.generateArmyList(
        collection,
        faction,
        pointsLimit,
        additionalInstructions: additionalInstructions,
      );
      
      // Parse the result to extract name, army list, strategy, and purchases
      final nameMatch = RegExp(r'Name:\s*(.+)').firstMatch(result);
      final name = nameMatch?.group(1)?.trim() ?? 'Unnamed Army';
      
      final parts = result.split('\n\nStrategy:');
      final armyListPart = parts[0].replaceFirst(RegExp(r'Name:.*\n'), '').trim();
      final strategyAndPurchases = parts.length > 1 ? parts[1].trim() : 'No strategy provided';

      // Extract strategy and required purchases
      final purchasesParts = strategyAndPurchases.split('\n\nRequired Purchases:');
      final strategy = purchasesParts[0].trim();
      String requiredPurchases = '';
      double totalPurchaseCost = 0.0;

      if (purchasesParts.length > 1) {
        requiredPurchases = purchasesParts[1].trim();
        // Extract total cost from the last line which should be "Total Cost: $X"
        final costMatch = RegExp(r'Total Cost:\s*\$(\d+\.?\d*)').firstMatch(requiredPurchases);
        if (costMatch != null) {
          totalPurchaseCost = double.parse(costMatch.group(1) ?? '0');
          // Remove the total cost line from required purchases
          requiredPurchases = requiredPurchases.replaceFirst(RegExp(r'\nTotal Cost:.*$'), '');
        }
      }

      // Store the generated army
      await ref.read(generatedArmiesProvider.notifier).addGeneratedArmy(
        name: name,
        description: additionalInstructions ?? 'Standard generation',
        pointsLimit: pointsLimit,
        armyList: armyListPart,
        strategy: strategy,
        faction: faction,
        requiredPurchases: requiredPurchases,
        totalPurchaseCost: totalPurchaseCost,
      );
      
      state = AsyncValue.data(result);
      onComplete(); // Call onComplete callback when generation is done
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }
}
