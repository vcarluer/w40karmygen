import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/models/unit.dart';
import 'repository_providers.dart';

part 'collection_provider.g.dart';

@Riverpod(keepAlive: true)
class MiniatureCollection extends AsyncNotifier<List<Unit>> {
  @override
  Future<List<Unit>> build() async {
    final repository = await ref.watch(collectionRepositoryProvider.future);
    return repository.loadCollection();
  }

  Future<void> addUnit(Unit unit) async {
    final repository = await ref.read(collectionRepositoryProvider.future);
    
    final currentCollection = state.valueOrNull ?? [];
    final newCollection = [...currentCollection, unit];
    await repository.saveCollection(newCollection);
    state = AsyncData(newCollection);
  }

  Future<void> removeUnit(String unitId) async {
    final repository = await ref.read(collectionRepositoryProvider.future);
    
    final currentCollection = state.valueOrNull ?? [];
    final newCollection = currentCollection.where((unit) => unit.id != unitId).toList();
    await repository.saveCollection(newCollection);
    state = AsyncData(newCollection);
  }

  Future<void> updateUnitQuantity(String unitId, int quantity) async {
    final repository = await ref.read(collectionRepositoryProvider.future);
    
    final currentCollection = state.valueOrNull ?? [];
    final newCollection = currentCollection.map((unit) {
      if (unit.id == unitId) {
        return Unit(
          id: unit.id,
          datasheet: unit.datasheet,
          quantity: quantity,
          points: unit.points,
          notes: unit.notes,
        );
      }
      return unit;
    }).toList();
    await repository.saveCollection(newCollection);
    state = AsyncData(newCollection);
  }

  List<Unit> getFilteredUnits(String? factionId) {
    final currentCollection = state.valueOrNull ?? [];
    if (factionId == null) return currentCollection;
    return currentCollection.where((unit) => unit.datasheet.factionId == factionId).toList();
  }

  int getTotalPoints() {
    final currentCollection = state.valueOrNull ?? [];
    return currentCollection.fold<int>(
      0,
      (sum, unit) => sum + ((unit.points) * (unit.quantity)),
    );
  }
}
