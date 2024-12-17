import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../domain/models/datasheet.dart';
import '../../domain/models/unit.dart';

class AddUnitDialog extends StatefulWidget {
  final Datasheet datasheet;

  const AddUnitDialog({
    super.key,
    required this.datasheet,
  });

  @override
  State<AddUnitDialog> createState() => _AddUnitDialogState();
}

class _AddUnitDialogState extends State<AddUnitDialog> {
  final _formKey = GlobalKey<FormState>();
  int _quantity = 1;
  int _points = 0;
  String _notes = '';

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Add ${widget.datasheet.name}',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Quantity',
                  border: OutlineInputBorder(),
                ),
                initialValue: _quantity.toString(),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a quantity';
                  }
                  final quantity = int.tryParse(value);
                  if (quantity == null || quantity < 1) {
                    return 'Quantity must be at least 1';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    _quantity = int.tryParse(value) ?? 1;
                  });
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Points',
                  border: OutlineInputBorder(),
                ),
                initialValue: _points.toString(),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter points';
                  }
                  final points = int.tryParse(value);
                  if (points == null || points < 0) {
                    return 'Points must be 0 or greater';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    _points = int.tryParse(value) ?? 0;
                  });
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Notes (optional)',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
                onChanged: (value) {
                  setState(() {
                    _notes = value;
                  });
                },
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Cancel'),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        final unit = Unit(
                          id: DateTime.now().toIso8601String(),
                          datasheet: widget.datasheet,
                          quantity: _quantity,
                          points: _points,
                          notes: _notes.isEmpty ? null : _notes,
                        );
                        Navigator.of(context).pop(unit);
                      }
                    },
                    child: const Text('Add Unit'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
