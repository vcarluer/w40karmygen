import 'package:flutter/material.dart';
import '../../domain/models/faction.dart';

class OptimizationParametersDialog extends StatefulWidget {
  final List<Faction> factions;
  final int pointsLimit;
  final Function(String name, Faction? faction, String? instructions) onOptimize;

  const OptimizationParametersDialog({
    super.key,
    required this.factions,
    required this.pointsLimit,
    required this.onOptimize,
  });

  @override
  State<OptimizationParametersDialog> createState() => _OptimizationParametersDialogState();
}

class _OptimizationParametersDialogState extends State<OptimizationParametersDialog> {
  Faction? selectedFaction;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _instructionsController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _instructionsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Row(
        children: [
          Icon(Icons.settings),
          SizedBox(width: 8),
          Text('Army Optimization Parameters'),
        ],
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Army Name:'),
            const SizedBox(height: 8),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter a name for this army list...',
                contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              ),
            ),
            const SizedBox(height: 16),
            const Text('Faction (optional):'),
            const SizedBox(height: 8),
            DropdownButtonFormField<Faction>(
              value: selectedFaction,
              items: widget.factions.map((faction) {
                return DropdownMenuItem(
                  value: faction,
                  child: Text(faction.name),
                );
              }).toList(),
              onChanged: (Faction? value) {
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
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: _nameController.text.trim().isEmpty
              ? null
              : () {
                  widget.onOptimize(
                    _nameController.text.trim(),
                    selectedFaction,
                    _instructionsController.text.isEmpty ? null : _instructionsController.text,
                  );
                  Navigator.of(context).pop();
                },
          child: const Text('Optimize'),
        ),
      ],
    );
  }
}
