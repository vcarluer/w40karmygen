import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/faction_provider.dart';
import '../providers/optimizer_provider.dart';
import '../../domain/models/faction.dart';
import 'optimization_parameters_dialog.dart';

class OptimizationResultDialog extends ConsumerWidget {
  final String result;

  const OptimizationResultDialog({
    super.key,
    required this.result,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AlertDialog(
      title: const Row(
        children: [
          Icon(Icons.auto_awesome),
          SizedBox(width: 8),
          Text('Optimized Army List'),
        ],
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              result,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Close'),
        ),
      ],
    );
  }
}

Future<void> showOptimizationDialog(BuildContext context, WidgetRef ref, int pointsLimit) async {
  final factions = await ref.read(factionListProvider.future);
  
  if (!context.mounted) return;
  
  await showDialog(
    context: context,
    barrierDismissible: false, // Prevent closing by tapping outside while optimizing
    builder: (dialogContext) => OptimizationParametersDialog(
      factions: factions,
      pointsLimit: pointsLimit,
      onOptimize: (faction, instructions) {
        ref.read(optimizationResultProvider.notifier).optimizeList(
          pointsLimit,
          faction: faction,
          additionalInstructions: instructions,
          onComplete: () {
            // Close the parameters dialog when optimization completes
            Navigator.of(dialogContext).pop();
          },
        );
      },
    ),
  );

  // After parameters dialog closes, check if we have a result to show
  if (!context.mounted) return;
  
  final optimizationState = ref.read(optimizationResultProvider);
  if (optimizationState.hasValue && optimizationState.value != null) {
    await showDialog(
      context: context,
      builder: (context) => OptimizationResultDialog(
        result: optimizationState.value!,
      ),
    );
  }
}
