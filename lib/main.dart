import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:w40k_army_opti/core/theme/app_theme.dart';
import 'package:w40k_army_opti/features/home/presentation/pages/home_page.dart';
import 'package:w40k_army_opti/core/config/env.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferences.getInstance(); // Initialize SharedPreferences
  await Env.loadLocalConfig(); // Load local configuration if available
  
  runApp(
    const ProviderScope(
      child: W40kArmyGeneratorApp(),
    ),
  );
}

class W40kArmyGeneratorApp extends StatelessWidget {
  const W40kArmyGeneratorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Warhammer 40,000 Army Generator',
      theme: AppTheme.darkTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.dark, // Force dark theme for W40K style
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}
