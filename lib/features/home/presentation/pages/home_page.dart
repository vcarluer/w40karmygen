import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('W40K Army Optimizer'),
      ),
      body: const Center(
        child: Text(
          'Welcome to W40K Army Optimizer',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
