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
