import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:w40k_army_opti/core/theme/app_theme.dart';
import 'package:w40k_army_opti/features/home/presentation/pages/home_page.dart';

void main() {
  runApp(
    const ProviderScope(
      child: W40kArmyOptiApp(),
    ),
  );
}

class W40kArmyOptiApp extends StatelessWidget {
  const W40kArmyOptiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'W40K Army Optimizer',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}
