import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/faction.dart';
import '../providers/optimizer_provider.dart';

class OptimizationParametersDialog extends ConsumerStatefulWidget {
  final List<Faction> factions;
  final int pointsLimit;
  final Function(Faction? faction, String? instructions) onOptimize;

  const OptimizationParametersDialog({
    super.key,
    required this.factions,
    required this.pointsLimit,
    required this.onOptimize,
  });

  @override
  ConsumerState<OptimizationParametersDialog> createState() => _OptimizationParametersDialogState();
}

class _OptimizationParametersDialogState extends ConsumerState<OptimizationParametersDialog> {
  Faction? selectedFaction;
  final TextEditingController _instructionsController = TextEditingController();

  @override
  void dispose() {
    _instructionsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final optimizationState = ref.watch(optimizationResultProvider);
    final isLoading = optimizationState.isLoading;

    return AlertDialog(
      title: Row(
        children: [
          const Icon(Icons.settings),
          const SizedBox(width: 8),
          const Text('Army Optimization Parameters'),
          if (isLoading) ...[
            const SizedBox(width: 8),
            const SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          ],
        ],
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (isLoading)
              const Padding(
                padding: EdgeInsets.only(bottom: 16),
                child: Text(
                  'Optimization in progress...',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            const Text('Faction (optional):'),
            const SizedBox(height: 8),
            DropdownButtonFormField<Faction?>(
              value: selectedFaction,
              items: [
                const DropdownMenuItem<Faction?>(
                  value: null,
                  child: Text('No Faction'),
                ),
                ...widget.factions.map((faction) {
                  return DropdownMenuItem(
                    value: faction,
                    child: Text(faction.name),
                  );
                }),
              ],
              onChanged: isLoading ? null : (Faction? value) {
                setState(() {
                  selectedFaction = value;
                });
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              ),
            ),
            const SizedBox(height: 16),
            const Text('Additional Instructions (optional):'),
            const SizedBox(height: 8),
            TextField(
              controller: _instructionsController,
              maxLines: 3,
              enabled: !isLoading,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter any specific requirements or preferences...',
                contentPadding: EdgeInsets.all(12),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Points Limit: ${widget.pointsLimit}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: isLoading ? null : () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: isLoading
              ? null
              : () {
                  widget.onOptimize(
                    selectedFaction,
                    _instructionsController.text.isEmpty
                        ? null
                        : _instructionsController.text,
                  );
                  // Don't pop the dialog when optimization starts
                  // Let it close when optimization completes
                },
          child: Text(isLoading ? 'Optimizing...' : 'Optimize'),
        ),
      ],
    );
  }
}
