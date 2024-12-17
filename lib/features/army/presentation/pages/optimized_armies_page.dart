import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/optimized_army_provider.dart';
import '../providers/optimizer_provider.dart';
import '../../domain/models/optimized_army.dart';

class OptimizedArmiesPage extends ConsumerWidget {
  const OptimizedArmiesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final armies = ref.watch(optimizedArmiesProvider);
    final optimizationResult = ref.watch(optimizationResultProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Optimized Armies'),
      ),
      body: Column(
        children: [
          // Show optimization result while generating
          optimizationResult.when(
            data: (result) => result != null
                ? Container(
                    margin: const EdgeInsets.all(8),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surfaceVariant,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.auto_awesome),
                            const SizedBox(width: 8),
                            Text(
                              'Generating Army List...',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            const Spacer(),
                            IconButton(
                              icon: const Icon(Icons.close),
                              onPressed: () {
                                ref.invalidate(optimizationResultProvider);
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(result),
                      ],
                    ),
                  )
                : const SizedBox.shrink(),
            loading: () => const Center(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: CircularProgressIndicator(),
              ),
            ),
            error: (error, _) => Container(
              margin: const EdgeInsets.all(8),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.errorContainer,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  const Icon(Icons.error_outline),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Error optimizing list: $error',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onErrorContainer,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      ref.invalidate(optimizationResultProvider);
                    },
                  ),
                ],
              ),
            ),
          ),
          // Show saved armies
          Expanded(
            child: armies.isEmpty
                ? const Center(
                    child: Text('No optimized armies yet'),
                  )
                : ListView.builder(
                    itemCount: armies.length,
                    itemBuilder: (context, index) {
                      final army = armies[index];
                      return _ArmyCard(army: army);
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class _ArmyCard extends StatelessWidget {
  final OptimizedArmy army;

  const _ArmyCard({required this.army});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: ExpansionTile(
        title: Text(army.name),
        subtitle: Text(
          '${army.faction?.name ?? 'No Faction'} - ${army.pointsLimit} points',
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Description:',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                Text(army.description),
                const SizedBox(height: 16),
                Text(
                  'Army List:',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                Text(army.armyList),
                const SizedBox(height: 16),
                Text(
                  'Strategy:',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                Text(army.strategy),
                const SizedBox(height: 8),
                Text(
                  'Created: ${_formatDate(army.createdAt)}',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')} ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }
}
