class Env {
  static const String openRouterApiKey = String.fromEnvironment(
    'OPENROUTER_API_KEY',
    defaultValue: '',
  );

  static bool get hasOpenRouterApiKey => openRouterApiKey.isNotEmpty;
}
