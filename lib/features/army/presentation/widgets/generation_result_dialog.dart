import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/faction_provider.dart';
import '../providers/generator_provider.dart';
import '../../domain/models/faction.dart';
import 'generation_parameters_dialog.dart';

class GenerationResultDialog extends ConsumerWidget {
  final String result;

  const GenerationResultDialog({
    super.key,
    required this.result,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Parse sections from the result
    final sections = _parseSections(result);

    return AlertDialog(
      title: const Row(
        children: [
          Icon(Icons.auto_awesome),
          SizedBox(width: 8),
          Text('Generated Army List'),
        ],
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Army Name
            if (sections['name'] != null) ...[
              Text(
                sections['name']!,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
            ],

            // Army List
            if (sections['armyList'] != null) ...[
              Text(
                'Army List',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                sections['armyList']!,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 16),
            ],

            // Strategy
            if (sections['strategy'] != null) ...[
              Text(
                'Strategy',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                sections['strategy']!,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 16),
            ],

            // Required Purchases
            if (sections['requiredPurchases'] != null) ...[
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Required Purchases',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      sections['requiredPurchases']!,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                    ),
                    if (sections['totalCost'] != null) ...[
                      const Divider(),
                      Text(
                        'Total Cost: ${sections['totalCost']}',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onPrimaryContainer,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
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

  Map<String, String> _parseSections(String result) {
    final sections = <String, String>{};
    
    // Extract name
    final nameMatch = RegExp(r'Name:\s*(.+)').firstMatch(result);
    if (nameMatch != null) {
      sections['name'] = nameMatch.group(1)!.trim();
    }

    // Split into main sections
    final parts = result.split('\n\nStrategy:');
    if (parts.length > 0) {
      // Army list is everything after name until strategy
      final armyList = parts[0].replaceFirst(RegExp(r'Name:.*\n'), '').trim();
      sections['armyList'] = armyList;
    }
    
    if (parts.length > 1) {
      final strategyAndPurchases = parts[1].split('\n\nRequired Purchases:');
      sections['strategy'] = strategyAndPurchases[0].trim();
      
      if (strategyAndPurchases.length > 1) {
        final purchases = strategyAndPurchases[1].trim();
        // Extract total cost from the last line
        final costMatch = RegExp(r'Total Cost:\s*(\$\d+\.?\d*)').firstMatch(purchases);
        if (costMatch != null) {
          sections['totalCost'] = costMatch.group(1)!;
          // Remove the total cost line from purchases
          sections['requiredPurchases'] = purchases.replaceFirst(RegExp(r'\nTotal Cost:.*$'), '').trim();
        } else {
          sections['requiredPurchases'] = purchases;
        }
      }
    }

    return sections;
  }
}

Future<void> showGenerationDialog(BuildContext context, WidgetRef ref) async {
  final factions = await ref.read(factionListProvider.future);
  
  if (!context.mounted) return;
  
  await showDialog(
    context: context,
    barrierDismissible: false, // Prevent closing by tapping outside while generating
    builder: (dialogContext) => GenerationParametersDialog(
      factions: factions,
      onOptimize: (faction, instructions, pointsLimit) {
        ref.read(generationResultProvider.notifier).generateList(
          pointsLimit,
          faction: faction,
          additionalInstructions: instructions,
          onComplete: () {
            // Close the parameters dialog when generation completes
            Navigator.of(dialogContext).pop();
          },
        );
      },
    ),
  );

  // After parameters dialog closes, check if we have a result to show
  if (!context.mounted) return;
  
  final generationState = ref.read(generationResultProvider);
  if (generationState.hasValue && generationState.value != null) {
    await showDialog(
      context: context,
      builder: (context) => GenerationResultDialog(
        result: generationState.value!,
      ),
    );
  }
}
