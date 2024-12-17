import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/config/env.dart';
import '../../data/services/openrouter_service.dart';
import '../../domain/services/army_optimizer_service.dart';
import '../../domain/models/faction.dart';
import 'collection_provider.dart';
import 'faction_provider.dart';
import 'optimized_army_provider.dart';

part 'optimizer_provider.g.dart';

final openRouterServiceProvider = Provider<OpenRouterService>((ref) {
  return OpenRouterService(apiKey: Env.openRouterApiKey);
});

final armyOptimizerServiceProvider = Provider<ArmyOptimizerService>((ref) {
  final openRouterService = ref.watch(openRouterServiceProvider);
  return ArmyOptimizerService(openRouterService);
});

@riverpod
class OptimizationResult extends _$OptimizationResult {
  @override
  AsyncValue<String?> build() {
    return const AsyncValue.data(null);
  }

  Future<void> optimizeList(
    String name,
    int pointsLimit, {
    Faction? faction,
    String? additionalInstructions,
  }) async {
    state = const AsyncValue.loading();
    
    try {
      final optimizer = ref.read(armyOptimizerServiceProvider);
      final collection = await ref.read(miniatureCollectionProvider.future);
      
      final result = await optimizer.optimizeArmyList(
        collection,
        faction,
        pointsLimit,
        additionalInstructions: additionalInstructions,
      );
      
      // Parse the result to extract strategy and army list
      final parts = result.split('\n\nStrategy:');
      final armyList = parts[0].trim();
      final strategy = parts.length > 1 ? parts[1].trim() : 'No strategy provided';

      // Store the optimized army
      ref.read(optimizedArmiesProvider.notifier).addOptimizedArmy(
        name: name,
        description: additionalInstructions ?? 'Standard optimization',
        pointsLimit: pointsLimit,
        armyList: armyList,
        strategy: strategy,
        faction: faction,
      );
      
      state = AsyncValue.data(result);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }
}
