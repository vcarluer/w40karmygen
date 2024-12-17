import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/optimized_army_provider.dart';
import '../../domain/models/optimized_army.dart';

class OptimizedArmiesPage extends ConsumerWidget {
  const OptimizedArmiesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final armies = ref.watch(optimizedArmiesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Optimized Armies'),
      ),
      body: armies.isEmpty
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
