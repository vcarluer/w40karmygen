import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/faction.dart';
import '../providers/generator_provider.dart';

class GenerationParametersDialog extends ConsumerStatefulWidget {
  final List<Faction> factions;
  final Function(Faction? faction, String? instructions, int pointsLimit) onOptimize;

  const GenerationParametersDialog({
    super.key,
    required this.factions,
    required this.onOptimize,
  });

  @override
  ConsumerState<GenerationParametersDialog> createState() => _GenerationParametersDialogState();
}

class _GenerationParametersDialogState extends ConsumerState<GenerationParametersDialog> {
  Faction? selectedFaction;
  final TextEditingController _instructionsController = TextEditingController();
  final TextEditingController _customPointsController = TextEditingController();
  int? selectedPoints = 1000;
  bool isCustomPoints = false;

  @override
  void dispose() {
    _instructionsController.dispose();
    _customPointsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final generationState = ref.watch(generationResultProvider);
    final isLoading = generationState.isLoading;

    return AlertDialog(
      title: Row(
        children: [
          const Icon(Icons.settings),
          const SizedBox(width: 8),
          const Text('Army Generation Parameters'),
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
                  'Generation in progress...',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            const Card(
              child: Padding(
                padding: EdgeInsets.all(12),
                child: Row(
                  children: [
                    Icon(Icons.info_outline, color: Colors.blue),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'The army generation will prioritize units from your collection to create an optimized army.',
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text('Points Limit:'),
            const SizedBox(height: 8),
            DropdownButtonFormField<int?>(
              value: isCustomPoints ? null : selectedPoints,
              items: [
                const DropdownMenuItem<int?>(
                  value: 1000,
                  child: Text('1000 points'),
                ),
                const DropdownMenuItem<int?>(
                  value: 2000,
                  child: Text('2000 points'),
                ),
                const DropdownMenuItem<int?>(
                  value: 3000,
                  child: Text('3000 points'),
                ),
                const DropdownMenuItem<int?>(
                  value: null,
                  child: Text('Custom points'),
                ),
              ],
              onChanged: isLoading
                  ? null
                  : (int? value) {
                      setState(() {
                        selectedPoints = value;
                        isCustomPoints = value == null;
                      });
                    },
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              ),
            ),
            if (isCustomPoints) ...[
              const SizedBox(height: 8),
              TextField(
                controller: _customPointsController,
                enabled: !isLoading,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter custom points limit',
                  contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                ),
                onChanged: (value) {
                  setState(() {
                    selectedPoints = int.tryParse(value);
                  });
                },
              ),
            ],
            const SizedBox(height: 16),
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
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: isLoading ? null : () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: isLoading || selectedPoints == null
              ? null
              : () {
                  widget.onOptimize(
                    selectedFaction,
                    _instructionsController.text.isEmpty
                        ? null
                        : _instructionsController.text,
                    selectedPoints!,
                  );
                  // Don't pop the dialog when generation starts
                  // Let it close when generation completes
                },
          child: Text(isLoading ? 'Generating...' : 'Generate'),
        ),
      ],
    );
  }
}
