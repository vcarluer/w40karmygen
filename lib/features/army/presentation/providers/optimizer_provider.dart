import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/config/env.dart';
import '../../data/services/openrouter_service.dart';
import '../../domain/services/army_optimizer_service.dart';
import '../../domain/models/faction.dart';
import 'collection_provider.dart';
import 'faction_provider.dart';

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
      
      state = AsyncValue.data(result);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }
}
