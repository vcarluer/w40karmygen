import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:w40k_army_opti/core/theme/app_theme.dart';
import 'package:w40k_army_opti/features/home/presentation/pages/home_page.dart';
import 'package:w40k_army_opti/core/config/env.local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferences.getInstance(); // Initialize SharedPreferences
  
  // Set OpenRouter API key from local configuration
  const String openRouterApiKey = String.fromEnvironment(
    'OPENROUTER_API_KEY',
    defaultValue: EnvLocal.openRouterApiKey,
  );

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
      title: 'W40k Army Generator',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}
